##############################################
# Created from template ros2.dockerfile.jinja
##############################################

###########################################
# Base image
###########################################
FROM nvidia/cuda:11.8.0-runtime-ubuntu22.04 AS base

ENV DEBIAN_FRONTEND=noninteractive

# Install language
RUN apt-get update && apt-get install -y \
  locales \
  && locale-gen en_US.UTF-8 \
  && update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 \
  && rm -rf /var/lib/apt/lists/*
ENV LANG en_US.UTF-8

# Install timezone
RUN ln -fs /usr/share/zoneinfo/UTC /etc/localtime \
  && export DEBIAN_FRONTEND=noninteractive \
  && apt-get update \
  && apt-get install -y tzdata \
  && dpkg-reconfigure --frontend noninteractive tzdata \
  && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get -y upgrade \
    && rm -rf /var/lib/apt/lists/*

# Install common programs
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    gnupg2 \
    lsb-release \
    sudo \
    software-properties-common \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Install ROS2
RUN sudo add-apt-repository universe \
  && curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg \
  && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null \
  && apt-get update && apt-get install -y --no-install-recommends \
    ros-humble-ros-base \
    python3-argcomplete \
  && rm -rf /var/lib/apt/lists/*

ENV ROS_DISTRO=humble
ENV AMENT_PREFIX_PATH=/opt/ros/humble
ENV COLCON_PREFIX_PATH=/opt/ros/humble
ENV LD_LIBRARY_PATH=/opt/ros/humble/lib
ENV PATH=/opt/ros/humble/bin:$PATH
ENV PYTHONPATH=/opt/ros/humble/lib/python3.10/site-packages
ENV ROS_PYTHON_VERSION=3
ENV ROS_VERSION=2
ENV DEBIAN_FRONTEND=

###########################################
#  Develop image
###########################################
FROM base AS dev

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
  bash-completion \
  build-essential \
  cmake \
  gdb \
  git \
  openssh-client \
  python3-argcomplete \
  python3-pip \
  ros-dev-tools \
  ros-humble-ament-* \
  vim \
  && rm -rf /var/lib/apt/lists/*

RUN rosdep init || echo "rosdep already initialized"

ARG USERNAME=ros
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Create a non-root user
RUN groupadd --gid $USER_GID $USERNAME \
  && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
  # Add sudo support for the non-root user
  && apt-get update \
  && apt-get install -y sudo \
  && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME\
  && chmod 0440 /etc/sudoers.d/$USERNAME \
  && rm -rf /var/lib/apt/lists/*

# Set up autocompletion for user
RUN apt-get update && apt-get install -y git-core bash-completion \
  && echo "if [ -f /opt/ros/${ROS_DISTRO}/setup.bash ]; then source /opt/ros/${ROS_DISTRO}/setup.bash; fi" >> /home/$USERNAME/.bashrc \
  && echo "if [ -f /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash ]; then source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash; fi" >> /home/$USERNAME/.bashrc \
  && rm -rf /var/lib/apt/lists/* 

ENV DEBIAN_FRONTEND=
ENV AMENT_CPPCHECK_ALLOW_SLOW_VERSIONS=1

###########################################
#  Full image
###########################################
FROM dev AS full

ENV DEBIAN_FRONTEND=noninteractive
# Install the full release
RUN apt-get update && apt-get install -y --no-install-recommends \
  ros-humble-desktop \
  && rm -rf /var/lib/apt/lists/*
ENV DEBIAN_FRONTEND=

###########################################
#  Full+Gazebo image
###########################################
FROM full AS gazebo

ENV DEBIAN_FRONTEND=noninteractive
# Install gazebo
RUN wget https://packages.osrfoundation.org/gazebo.gpg -O /usr/share/keyrings/pkgs-osrf-archive-keyring.gpg \
  && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/pkgs-osrf-archive-keyring.gpg] http://packages.osrfoundation.org/gazebo/ubuntu-stable $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/gazebo-stable.list > /dev/null \
  && apt-get update && apt-get install -q -y --no-install-recommends \
    ros-humble-gazebo* \
  && rm -rf /var/lib/apt/lists/*
ENV DEBIAN_FRONTEND=

###########################################
#  Full+Gazebo+Nvidia image
###########################################

FROM gazebo AS gazebo-nvidia

################
# Expose the nvidia driver to allow opengl 
# Dependencies for glvnd and X11.
################
RUN apt-get update \
 && apt-get install -y -qq --no-install-recommends \
  libglvnd0 \
  libgl1 \
  libglx0 \
  libegl1 \
  libxext6 \
  libx11-6


# #Everything from this point is unique to this project
# RUN apt-get update
# RUN apt-get upgrade -y
# RUN apt-get dist-upgrade -y

# #Install dependencies for moveit
# RUN apt install ros-humble-eigen-stl-containers -y
# RUN apt install libgeometric-shapes-dev -y
# RUN pip install cmake --upgrade

# # #Installing moveit - moveit official method
# # RUN git clone https://github.com/ros-planning/moveit2.git -b $ROS_DISTRO
# # RUN for repo in moveit2/moveit2.repos $(f="moveit2/moveit2_$ROS_DISTRO.repos"; test -r $f && echo $f); do vcs import < "$repo"; done
# # RUN rosdep update
# # RUN rosdep install -r --from-paths . --ignore-src --rosdistro $ROS_DISTRO -y

# # Install moveit quick method
# RUN apt install ros-humble-moveit* -y

# RUN apt update && \
#     apt install -y libeigen3-dev
# RUN rosdep update

# ## Installing ROS Controls package
# RUN apt-get update && \
#     apt-get install -y ros-${ROS_DISTRO}-ros2-control ros-${ROS_DISTRO}-ros2-controllers&& \
#     rm -rf /var/lib/apt/lists/*

# # Installing the RP2040 controller environment

# # RUN apt-get remove binutils-arm-none-eabi gcc-arm-none-eabi
# # RUN add-apt-repository ppa:team-gcc-arm-embedded/ppa
# RUN apt-get update
# RUN apt-get upgrade
# RUN apt-get install gcc-arm-none-eabi -y
# RUN apt-get install gdb-arm-none-eabi -y
# RUN git clone --recursive https://github.com/CNHGit/DiffDriveBaseControlelr_RP2040
# RUN cd DiffDriveBaseControlelr_RP2040 && \
#     git submodule update --init --recursive && \
#     cmake -S . -B build/ && \
#     cmake --build build
# ## After this other steps are for deploying the app onto the ucontroller

# # #Install the wheelchair repo
# # RUN cd ~ && \
# #     git clone --recurse-submodules https://github.com/CNHGit/WheelChair.git && \
# #     cd src && \
# #     git clone https://github.com/RoverRobotics-forks/serial-ros2.git && \
# #     cd .. && \
# #     cd WheelChair && \
# #     colcon build && \
# #     # cmake --build build/ && \
# #     # ls WheelChair && \
# #     cmake --build .build --clean-first
#     # cmake --build build/ --verbose && \
#     # rm -rf build

# # # Installing KUKA lbr-stack
# # RUN rosdep update
# # RUN apt-get update
# # RUN apt-get upgrade -y
# # COPY iiwa_installer.sh /opt/src/scripts/setup.sh
# # RUN chmod +x /opt/src/scripts/setup.sh
# # RUN . /opt/src/scripts/setup.sh
# # RUN source opt/ros/humble/setup.bash
# # RUN colcon build --cmake-args -DCMAKE_BUILD_TYPE=Release --symlink-install
# # RUN /bin/bash -c "/opt/src/src/scripts/setup.sh"

# Env vars for the nvidia-container-runtime.
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES graphics,utility,compute
ENV QT_X11_NO_MITSHM 1  