# Childrens National Docker Environment

### Description
This repo contains the instructions to setup the docker environment for the Kuka and Smart wheelchair projects. In theory, since we are using docker, the steps after installing docker should be the same for both windows and linux. Initially the steps shown in [this video](https://www.youtube.com/watch?v=qWuudNxFGOQ) (Also featured by ROS on their official documentation site) were followed, with the simple modification of ROS2 Galactic instead of [ROS2 Foxy](https://docs.ros.org/en/foxy/index.html). Moving ahead, the individual packages required for these projects can be found in their respective sections. As of the moment, while this project is in progress, the reason for opting to use ROS2 Galactic is it's high stability. We noticed that ROS2 Humble has issued loading URDF files.

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


## 3. Downloading Ubuntu 20.04 with ROS 2 Docker image

After succesfully installing docker pull the custom docker image created by [Allison Thackston](https://www.allisonthackston.com/) on [Dockerhub](https://hub.docker.com/r/althack/ros2).

> [!Warning]
> Make sure that you choose the right OS, the right cuda version, and the right Distribution compatible with your system, in this specified order.

> [!Important]
> Galactic has reached End of Life (EOL) so there may be issues in the future such as Nvidia cuda image version mismatch. In the image provided by Allison Thackston uses CUDA 11.7. However, that version does not exist on Dockerhub (atleast not anyomre) and thus if you try to docker-run it directly, it will pop up with an error. Simplest method to counter this is to go to Nvidia's Dockerhub ([nvidia/cuda](https://hub.docker.com/r/nvidia/cuda)) and select the correct docker image.

Pull the galactic image

   1. If you **have** CUDA enabled GPU:
      ```Shell
      docker pull althack/ros2:galactic-cuda-gazebo-nvidia-2022-12-01
      ```

   2. If you **DON'T have** CUDA enabled GPU:
      ```Shell
      docker pull althack/ros2:galactic-gazebo-2022-12-01
      ``` 

For further uses we have assumed CUDA enabled systems.

## 4. Running the dockerfile

Either clone this entire repository or just download the provided Dockerfile.

After you have the Dockerfile locally stored on your machine, navigate to the location where you have that file and run the following command:

```Shell
docker build -t ros2_galactic .
```

Feel free to replace `ros2_galactic` with a name of your own choice, but also remeber to substitute it correctly in the commands that follow.

## 5. Setting up the environment

After this point make a separate directory to store your [Dockerfile](https://docs.docker.com/engine/reference/builder/) and other scripts. There should be only 1 Dockerfile and it has no extensions like `.txt`, `.bash`, etc. For simplicity, clone this  entire project.
