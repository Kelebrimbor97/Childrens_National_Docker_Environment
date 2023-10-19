#IMPORTANT! Make sure that your terminal is in the directory where you have cloned this repo

#Base image is Galactic desktop
FROM osrf/ros:galactic-desktop

#Nvidia-container runtime
ENV NVIDIA_VISIBLE_DEVICES ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,} graphics

SHELL [ "/bin/bash", "-c"]
RUN apt-get update
RUN apt-get install -y git && apt-get install -y python3-pip


RUN source /opt/ros/galactic/setup.bash \
    && cd ~/ \
    && git clone https://github.com/Kelebrimbor97/Childrens_National_Docker_Environment

# Install dependencies for turtlebot3
RUN apt install ros-galactic-turtlebot3* \
    && mkdir turtlebot3_ws \
    && cd turtlebot3_ws && mkdir src \
    && wget https://raw.githubusercontent.com/ROBOTIS-GIT/turtlebot3/ros2/turtlebot3.repos 

# More turtlebot3 dependencies
RUN pip install vcstool \
    && rosdep update \
    && rosdep install --from-paths src --ignore-src -y

#Build and source workspace
RUN colcon build \
    && source install /setup.bash

#Export variables to bashrc
RUN export TURTLEBOT3_MODEL=burger \
    && export GAZEBO_MODEL_PATH=$GAZEBO_MODEL_PATH:`ros2 pkg prefix turtlebot3_gazebo`/share/turtlebot3_gazebo/models/ 