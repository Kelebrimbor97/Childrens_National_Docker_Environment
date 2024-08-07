#Using the GUI enabled image as BASE we create a separate image specific to the project instead of a unified image that has too many packages 
# Remember to replace the name GALACTIC_cuda with whatever name you've given to your image
# Using the GUI enabled image as BASE we create a separate image specific to the project
FROM galactic_jetson AS base

# Remove conflicting opencv-dev package if exists
# RUN dpkg -l | grep opencv-dev && \
#     apt-get remove -y opencv-dev

# Install libopencv-dev (attempting to fix overwrite issue)
RUN apt-get update && \
    apt-get install -y --no-install-recommends libopencv-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Basic updates and install utilities
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y gedit && \
    apt-get install -y \
        python3-colcon-common-extensions \
        ros-$ROS_DISTRO-hardware-interface \
        gcc-arm-none-eabi \
        ros-$ROS_DISTRO-ament-cmake-clang-format \
        usbutils \
        fdisk \
        python3-wstool \
        python3-rosdep \
        ninja-build \
        stow \
        ros-$ROS_DISTRO-cartographer \
        ros-$ROS_DISTRO-cartographer-ros \
        ros-$ROS_DISTRO-navigation2 \
        ros-$ROS_DISTRO-nav2-bringup \
        ros-$ROS_DISTRO-joint-state-publisher* \
        ros-$ROS_DISTRO-robot-localization* && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Clone and build DiffDriveBaseController_RP2040
RUN git clone --recursive https://github.com/CNHGit/DiffDriveBaseControlelr_RP2040 && \
    cd DiffDriveBaseControlelr_RP2040 && \
    git submodule update --init --recursive && \
    cmake -S . -B build/ && \
    cmake --build build

# Clone and build WheelChair repo
RUN git clone --recurse-submodules https://github.com/CNHGit/WheelChair.git ~/WheelChair && \
    cd ~/WheelChair/src && \
    git clone https://github.com/RoverRobotics-forks/serial-ros2.git && \
    echo 'target_compile_options(${PROJECT_NAME} PRIVATE -fPIC)' >> ~/WheelChair/src/serial-ros2/CMakeLists.txt && \
    cd ~/WheelChair && \
    source /opt/ros/$ROS_DISTRO/setup.bash && \
    colcon build && \
    rm -rf build

# Install librealsense
RUN mkdir -p /etc/apt/keyrings && \
    curl -sSf https://librealsense.intel.com/Debian/librealsense.pgp | sudo tee /etc/apt/keyrings/librealsense.pgp > /dev/null && \
    echo "deb [signed-by=/etc/apt/keyrings/librealsense.pgp] https://librealsense.intel.com/Debian/apt-repo `lsb_release -cs` main" | \
    tee /etc/apt/sources.list.d/librealsense.list && \
    apt-get update && \
    apt-get install -y \
        # librealsense2-dkms \
        librealsense2-utils \
        librealsense2-dev \
        librealsense2-dbg \
        ros-$ROS_DISTRO-realsense2-* && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN pip install pyrealsense2

# Source ROS setup
RUN echo "source /opt/ros/$ROS_DISTRO/setup.bash" >> ~/.bashrc && \
    echo ". /usr/share/gazebo/setup.sh" >> ~/.bashrc && \
    echo "source ~/WheelChair/install/setup.bash" >> ~/.bashrc
