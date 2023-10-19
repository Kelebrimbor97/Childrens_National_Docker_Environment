# Childrens National Docker Environment

Step 1: Clone this repo

This repo contains the instructions to setup the docker environment for the Kuka and Smart wheelchair projects. In theory, since we are using docker, the steps after installing docker should be the same for both windows and linux. Initially the steps shown in [this video](https://www.youtube.com/watch?v=qWuudNxFGOQ) (Also featured by ROS on their official documentation site) were followed, with the simple modification of ROS2 Galactic instead of [ROS2 Foxy](https://docs.ros.org/en/foxy/index.html). Moving ahead, the individual packages required for these projects can be found in their respective sections. As of the moment, while this project is in progress, the reason for opting to use ROS2 Galactic is it's high stability. We noticed that ROS2 Humble 

_Note:_ 
- Docker installation instructions are provided below, while it is assumed that proper graphical drivers and CUDA for Nvidia GPUs are installed, the official instructions for which can be found [here](https://docs.nvidia.com/cuda/cuda-installation-guide-linux/contents.html).

- If performing a fresh install for Nvidia Drivers on Linux, it is strongly recommended to use the [Lambda Stack](https://lambdalabs.com/lambda-stack-deep-learning-software) by Lambda labs.

## 1. System Software information

The contents of this repo were tested on the following system (not all of it is relevant):

 1. _Operating System_ - Ubuntu 20.04 [Focal Fossa](https://releases.ubuntu.com/focal/)
 2. _CPU_ - 11th Gen Intel(R) Core(TM) i7-11800H @ 2.30GHz
 3. _GPU_
    - Model - RTX 3080 Mobile
    - Driver Version - 535.113.01
    - CUDA Version - 12.2
 4. _RAM_ - 32GB
 5. _Docker version_ - 24.0.6
 6. _ROS 2 Distro_ - [Galactic](https://docs.ros.org/en/galactic/index.html)

## 2. Installing Docker

The official docker installation guide can be found [here](https://docs.docker.com/engine/install/).

For fast and easy access, it is recommended to install [docker desktop](https://www.docker.com/products/docker-desktop/). Optionally, the same steps can also be performed through CLI commands.

## 3. Downloading ROS 2 Docker image

After succesfully installing docker, we pull the ROS2 Galactic full image

```Shell
docker pull osrf/ros:galactic-desktop
```

To check that you have succesfully pulled the image, run the following command:

```Shell
docker image ls | grep galactic
```
To run this image in Bash:

```Shell
docker run -it osrf/ros:galactic-desktop
```

### Testing GUI availabity

To check if your ROS2 image has GUI capacbility run the following command:

```Shell
ros2 run turtlesim turtlesim_node
```

On fresh installs and in cases that you do not have GUI functionalities, the following error pops up:

```Shell
qt.qpa.xcb: could not connect to display 
qt.qpa.plugin: Could not load the Qt platform plugin "xcb" in "" even though it was found.
This application failed to start because no Qt platform plugin could be initialized. Reinstalling the application may fix this problem.

Available platform plugins are: eglfs, linuxfb, minimal, minimalegl, offscreen, vnc, xcb.
```

This means that the turtlesim did simulate but there was no GUI so it exited.

## 4. Setting up the environment

After this point make a separate directory to store your [Dockerfile](https://docs.docker.com/engine/reference/builder/) and other scripts. There should be only 1 Dockerfile and it has no extensions like `.txt`, `.bash`, etc. For simplicity, clone this  entire project.
