#Using the GUI enabled image as BASE we create a separate image specific to the project instead of a unified image that has too many packages 

FROM humble_cuda AS base

#Basic updates
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get dist-upgrade -y

#Install dependencies for moveit
RUN apt install ros-humble-eigen-stl-containers -y
RUN apt install libgeometric-shapes-dev -y
RUN pip install cmake --upgrade

# #Installing moveit - moveit official method
# RUN git clone https://github.com/ros-planning/moveit2.git -b $ROS_DISTRO
# RUN for repo in moveit2/moveit2.repos $(f="moveit2/moveit2_$ROS_DISTRO.repos"; test -r $f && echo $f); do vcs import < "$repo"; done
# RUN rosdep update
# RUN rosdep install -r --from-paths . --ignore-src --rosdistro $ROS_DISTRO -y

# Install moveit quick method
RUN apt install ros-humble-moveit -y
RUN apt install ros-$ROS_DISTRO-rmw-cyclonedds-cpp -y
RUN export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp

RUN apt update && \
    apt install -y libeigen3-dev
RUN rosdep update


## Installing ROS Controls package
RUN apt-get update && \
    apt-get install -y ros-${ROS_DISTRO}-ros2-control ros-${ROS_DISTRO}-ros2-controllers&& \
    rm -rf /var/lib/apt/lists/*

# Installing KUKA lbr-stack

# SHELL ["/bin/bash", "-c"]

# ARG FRI_CLIENT_VERSION=1.15

# RUN apt update
# RUN apt upgrade -y

# # create workspace
# RUN mkdir -p home/ros2_ws/src
# WORKDIR /home/ros2_ws/

# COPY ./ /home/ros2_ws/src
# RUN rosdep install -i --from-paths src --rosdistro ${ROS_DISTRO} -y 

# # "--symlink-install" allows the code in the locally mounted volume ./src to be adjusted without rebuilding
# RUN source /opt/ros/${ROS_DISTRO}/setup.bash && \
#     colcon build --symlink-install --cmake-args -DFRI_CLIENT_VERSION=${FRI_CLIENT_VERSION} --no-warn-unused-cli

# # source the workspace
# RUN echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> ~/.bashrc
# RUN source /home/ros2_ws/install/local_setup.bash && echo "source /home/ros2_ws/install/local_setup.bash" >> ~/.bashrc
# CMD ["/bin/bash"]

RUN rosdep update
RUN apt-get update
RUN apt-get upgrade -y
COPY iiwa_installer.sh /opt/src/scripts/setup.sh
RUN chmod +x /opt/src/scripts/setup.sh
RUN . /opt/src/scripts/setup.sh
# RUN source /opt/ros/humble/setup.bash
# RUN colcon build --cmake-args -DCMAKE_BUILD_TYPE=Release --symlink-install
# RUN /bin/bash -c "/opt/src/src/scripts/setup.sh"