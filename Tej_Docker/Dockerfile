# glxgears
# ftp://www.x.org/pub/X11R6.8.1/doc/glxgears.1.html# docker build -t glxgears .
# xhost +si:localuser:root
# docker run — runtime=nvidia -ti — rm -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix glxgears
FROM ubuntu:22.04 as base
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
 mesa-utils
 
RUN apt install locales -y
RUN locale-gen en_US en_US.UTF-8
RUN update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
RUN export LANG=en_US.UTF-8

RUN apt-get update 
RUN apt install software-properties-common -y
RUN add-apt-repository universe

RUN apt-get update 
RUN apt install curl -y
RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg

RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null

RUN apt-get update
RUN apt-get upgrade -y

RUN mkdir -p /app

RUN apt install ros-humble-desktop -y
RUN apt install python3-colcon-common-extensions
RUN apt install ros-humble-hardware-interface


#rm -rf /var/lib/apt/lists/*
#CMD [“glxgears”, “-info”]
