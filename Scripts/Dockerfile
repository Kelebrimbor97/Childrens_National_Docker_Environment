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

# Unclear from this point
