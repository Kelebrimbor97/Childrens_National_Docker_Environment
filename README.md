# Childrens National Docker Environment

### Description
This repo contains the instructions to setup the docker environment for the Kuka and Smart wheelchair projects. In theory, since we are using docker, the steps after installing docker should be the same for both windows and linux. Moving ahead, the individual packages required for these projects can be found in their respective sections. There are branches for both [ROS2 Galactic](https://docs.ros.org/en/galactic/index.html) and [ROS2 Humble](https://docs.ros.org/en/humble/index.html).

_Note:_ 
- Docker installation instructions are provided below, while it is assumed that proper graphical drivers and CUDA for Nvidia GPUs are installed, the official instructions for which can be found [here](https://docs.nvidia.com/cuda/cuda-installation-guide-linux/contents.html).

- If performing a fresh install for Nvidia Drivers on Linux, it is strongly recommended to use the [Lambda Stack](https://lambdalabs.com/lambda-stack-deep-learning-software) by Lambda labs. They also have additional support for ngc containers which is used for these Docker environments.

## 1. System Software information

The contents of this repo were tested on the following system:

 1. _Base Operating System_ - Ubuntu 20.04 [Focal Fossa](https://releases.ubuntu.com/focal/)
 2. _CPU_ - 11th Gen Intel(R) Core(TM) i7-11800H @ 2.30GHz
 3. _GPU_
    - Model - RTX 3080 Mobile
    - Driver Version - 535.113.01
    - CUDA Version - 12.2
 4. _RAM_ - 32GB
 5. _Docker version_ - 24.0.6
 6. _ROS 2 Distro_ - [Galactic](https://docs.ros.org/en/galactic/index.html) OR [Humble](https://docs.ros.org/en/humble/index.html) 

## 2. Installing Docker

The official docker installation guide can be found [here](https://docs.docker.com/engine/install/).


## 3. Downloading Ubuntu 20.04/22.04 with ROS 2 Docker image

After succesfully installing docker pull the custom docker image created by [Allison Thackston](https://www.allisonthackston.com/) on [Dockerhub](https://hub.docker.com/r/althack/ros2).

> [!Warning]
> Make sure that you choose the right OS, the right cuda version, and the right Distribution compatible with your system, in this specified order.
> 1. Ubuntu 20.04 - ROS Galactic
> 2. Ubuntu 22.04 - ROS Humble

> [!Important]
> Galactic has reached End of Life (EOL) so there may be issues in the future such as Nvidia CUDA image version mismatch. In the image provided by Allison Thackston uses CUDA 11.7. However, that version does not exist on Dockerhub (atleast not anymore to my knowledge) and thus if you try to docker-run it directly, it will pop up with an error. Simplest method to counter this is to go to Nvidia's Dockerhub ([nvidia/cuda](https://hub.docker.com/r/nvidia/cuda)) and select the correct docker image.

### 1. Pulling the galactic image

   1. If you **have** CUDA enabled GPU:
      ```Shell
      docker pull althack/ros2:galactic-cuda-gazebo-nvidia-2022-12-01
      ```

   2. If you **DON'T have** CUDA enabled GPU:
      ```Shell
      docker pull althack/ros2:galactic-gazebo-2022-12-01
      ``` 

### 2. Pulling the Humble image

   1. If you **have** CUDA enabled GPU:
      ```Shell
      docker pull althack/ros2:humble-cuda-full-2024-02-01
      ```

   2. If you **DON'T have** CUDA enabled GPU:
      ```Shell
      docker pull althack/ros2:humble-full-2024-02-01
      ```
> [!Note]
> For further uses we have assumed **CUDA enabled systems with a Humble installation**.

## 4. Building the docker image using the Dockerfile

Depending on the distro you wish to use, navigate to the correct branch and clone it.

Navigate into the scripts folder inside the cloned repo and run the following command

```Shell
docker build -t humble_cuda .
```

you can replace `humble_cuda` with a name of your own choice, but also remeber to substitute it correctly in the commands that follow.

The following command will show docker images currently built and available on your host machine.

```Shell
docker image ls
```

## 5. Using the docker environment

After creating the docker image, it is ready to use. The command for using this is as following:

```Shell
docker run -it --rm --name=humbdolt --gpus=all --net=host --pid=host --privileged --env="DISPLAY=$DISPLAY" --volume="$PWD/focal_galactic/ros2_ws:/home/${USER}/ros2_ws" --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" humble_cuda
```

_Note_ : I'll be explaining these arguments eventually.

## 6. Using the IIWA stack

We use the (kind of) official [lbr-stack](https://github.com/lbr-stack/lbr_fri_ros2_stack/tree/humble). You don't need to download that but it needs to be built after starting the docker. The docker is started with `root` access by default.