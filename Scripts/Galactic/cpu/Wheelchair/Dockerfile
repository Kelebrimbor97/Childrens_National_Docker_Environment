#Using the GUI enabled image as BASE we create a separate image specific to the project instead of a unified image that has too many packages 
# Remember to replace the name galactic_cuda with whatever name you've given to your image

FROM galactic_cpu AS base

#Basic updates
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get dist-upgrade -y

# Install utilities
RUN apt-get install gedit -y

# Base ROS libraries
RUN apt install python3-colcon-common-extensions
RUN apt install ros-$ROS_DISTRO-hardware-interface

# #Install dependencies for moveit
# RUN apt install ros-$ROS_DISTRO-eigen-stl-containers -y
# RUN apt install libgeometric-shapes-dev -y
# RUN pip install cmake --upgrade

# # #Installing moveit - moveit official method
# # RUN git clone https://github.com/ros-planning/moveit2.git -b $ROS_DISTRO
# # RUN for repo in moveit2/moveit2.repos $(f="moveit2/moveit2_$ROS_DISTRO.repos"; test -r $f && echo $f); do vcs import < "$repo"; done
# # RUN rosdep update
# # RUN rosdep install -r --from-paths . --ignore-src --rosdistro $ROS_DISTRO -y

# # Install moveit quick method
# RUN apt install ros-$ROS_DISTRO-moveit* -y

# RUN apt update && \
#     apt install -y libeigen3-dev
# RUN rosdep update


# ## Installing ROS Controls package
# RUN apt-get update && \
#     apt-get install -y ros-${ROS_DISTRO}-ros2-control ros-${ROS_DISTRO}-ros2-controllers&& \
#     rm -rf /var/lib/apt/lists/*

# RUN add-apt-repository ppa:team-gcc-arm-embedded/ppa
RUN apt-get update
RUN apt-get upgrade
RUN apt-get install gcc-arm-none-eabi -y
RUN apt-get install gdb-arm-none-eabi -y
RUN git clone --recursive https://github.com/CNHGit/DiffDriveBaseControlelr_RP2040
RUN cd DiffDriveBaseControlelr_RP2040 && \
    git submodule update --init --recursive && \
    cmake -S . -B build/ && \
    cmake --build build

# Install serial ROS 2 dependency
# RUN cd ~ && \
#     git clone https://github.com/RoverRobotics-forks/serial-ros2.git && \
#     colcon build
    # target_compile_options(${PROJECT_NAME} PRIVATE -fPIC)


# Install the wheelchair repo
RUN cd ~ && \
    git clone --recurse-submodules https://github.com/CNHGit/WheelChair.git

RUN cd ~/WheelChair/src && \
    git clone https://github.com/RoverRobotics-forks/serial-ros2.git

RUN cd ~/WheelChair/src/serial-ros2 && \
    echo 'target_compile_options(${PROJECT_NAME} PRIVATE -fPIC)' >> CMakeLists.txt
    # cd .. && \

RUN cd ~/WheelChair && \
    colcon build && \
    rm -rf build

RUN apt-get install usbutils fdisk -y


# Install librealsense
RUN mkdir -p /etc/apt/keyrings
RUN curl -sSf https://librealsense.intel.com/Debian/librealsense.pgp | sudo tee /etc/apt/keyrings/librealsense.pgp > /dev/null

RUN echo "deb [signed-by=/etc/apt/keyrings/librealsense.pgp] https://librealsense.intel.com/Debian/apt-repo `lsb_release -cs` main" | \
tee /etc/apt/sources.list.d/librealsense.list

RUN apt-get update
# RUN apt-get install librealsense2-dkms -y
RUN apt-get install librealsense2-utils -y
RUN apt-get install librealsense2-dev -y
RUN apt-get install librealsense2-dbg -y
RUN apt install ros-$ROS_DISTRO-realsense2-* -y

RUN pip install pyrealsense2

#Install Cartographer
RUN apt-get update
RUN apt-get install -y python3-wstool python3-rosdep ninja-build stow

RUN apt install ros-$ROS_DISTRO-cartographer -y
RUN apt install ros-$ROS_DISTRO-cartographer-ros -y

RUN apt install ros-$ROS_DISTRO-navigation2 ros-$ROS_DISTRO-nav2-bringup -y

RUN apt-get install ros-$ROS_DISTRO-joint-state-publisher* ros-$ROS_DISTRO-robot-localization* -y
# RUN apt-get install ros-$ROS_DISTRO-slam-toolbox* -y
# RUN apt install ros-$ROS_DISTRO-rmw-cyclonedds-cpp -y
RUN echo "source /opt/ros/$ROS_DISTRO/setup.bash">>~/.bashrc
# RUN source /opt/ros/$ROS_DISTRO/setup.bash
# RUN source ~/.bashrc
# RUN apt install ros-$ROS_DISTRO-turtlebot3* -y
# RUN apt install ros-$ROS_DISTRO-slam-toolbox -y

#Install RPLidar

    # cmake --build build/ && \
    # ls WheelChair && \
#     cmake --build .build --clean-first
    # cmake --build build/ --verbose && \