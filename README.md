# Childrens National Docker Environment

### Description
This repo contains the instructions to setup the docker environment for the Kuka and Smart wheelchair projects. In theory, since we are using docker, the steps after installing docker should be the same for both windows and linux. Moving ahead, the individual packages required for these projects can be found in their respective sections. There were originally branches for both [ROS2 Galactic](https://docs.ros.org/en/galactic/index.html) and [ROS2 Humble](https://docs.ros.org/en/humble/index.html), however later on we realized that most of the ROS packages for the Wheelchair only worked on Galactic. Additionally, the KUKA project works with a device that has driver support for only Galactic. So, while very stable and capable of working in general, the Humble Docker image has no use, atleast as far as these 2 projects are concerned. Thus, the Humble image has been moved to Archive and additional developments for these projects will be carried out in Galactic only.

>[!Note]
>- Docker installation instructions are provided below, while it is assumed that for devices with an Nvidia GPU proper graphical drivers and CUDA for Nvidia GPUs are installed, the official instructions for which can be found [here](https://docs.nvidia.com/cuda/cuda-installation-guide-linux/contents.html).
>- If performing a fresh install for Nvidia Drivers on Linux, it is strongly recommended to use the [Lambda Stack](https://lambdalabs.com/lambda-stack-deep-learning-software) by Lambda labs. They also have additional support for ngc containers which is used for these Docker environments.

## 1. Requirements

The following packages need to be installed on your base machine:

1. **Linux** - Any flavor works. We use Ubuntu, specifically,  20.04
2. **Docker** - Installation instructions can be found [here](https://docs.docker.com/engine/install/). Make sure that you also follow the [post-installation instructions](https://docs.docker.com/engine/install/linux-postinstall/) to ensure a smooth experience where you don't have to constantly add `sudo` for every docker command.
3. **Nvidia GPU Drivers** _(Recommended)_ - Although you can install the driver separately, I would highly recommend using Lambda Stack as mentioned above.
<!-- The contents of this repo were tested on the following system:

 1. _Base Operating System_ - Ubuntu 20.04 [Focal Fossa](https://releases.ubuntu.com/focal/)
 2. _CPU_ - 11th Gen Intel(R) Core(TM) i7-11800H @ 2.30GHz
 3. _GPU_
    - Model - RTX 3080 Mobile
    - Driver Version - 535.113.01
    - CUDA Version - 12.2
 4. _RAM_ - 32GB
 5. _Docker version_ - 24.0.6
 6. _ROS 2 Distro_ - [Galactic](https://docs.ros.org/en/galactic/index.html) OR [Humble](https://docs.ros.org/en/humble/index.html)  -->

<!-- ## 2. Downloading Ubuntu 20.04/22.04 with ROS 2 Docker image

After succesfully installing docker pull the custom docker image created by [Allison Thackston](https://www.allisonthackston.com/) on [Dockerhub](https://hub.docker.com/r/althack/ros2).

> [!Warning]
> Make sure that you choose the right OS, the right cuda version, and the right Distribution compatible with your system, in this specified order.
> 1. Ubuntu 20.04 - ROS Galactic
> 2. Ubuntu 22.04 - ROS Humble

> [!Important]
> Galactic has reached End of Life (EOL) so there may be issues in the future such as Nvidia CUDA image version mismatch. In the image provided by Allison Thackston uses CUDA 11.7. However, that version does not exist on Dockerhub (atleast not anymore to my knowledge) and thus if you try to docker-run it directly, it will pop up with an error. Simplest method to counter this is to go to Nvidia's Dockerhub ([nvidia/cuda](https://hub.docker.com/r/nvidia/cuda)) and select the correct docker image.

### A. Pulling the galactic image

   1. If you **have** CUDA enabled GPU:
      ```Shell
      docker pull althack/ros2:galactic-cuda-gazebo-nvidia-2022-12-01
      ```

   2. If you **DON'T have** CUDA enabled GPU:
      ```Shell
      docker pull althack/ros2:galactic-gazebo-2022-12-01
      ``` 

### B. Pulling the Humble image

   1. If you **have** CUDA enabled GPU:
      ```Shell
      docker pull althack/ros2:humble-cuda-full-2024-02-01
      ```

   2. If you **DON'T have** CUDA enabled GPU:
      ```Shell
      docker pull althack/ros2:humble-full-2024-02-01
      ```
> [!Note]
> For further uses we have assumed **CUDA enabled systems with a Humble installation**. -->

## 2. Building the docker images using the Dockerfile

   ### 1. Building the base Ubuntu-ROS2 image
   Clone this repo. Depending on the distro you wish to use, navigate to the correct folder.

   The current structure (detailed only for important files) of this repo looks as shown below.

   ```bash
.
├── Images
├── README.md
└── Scripts
    ├── Archive
    └── Galactic
        ├── cpu
        │   ├── Dockerfile
        │   ├── KUKA
        │   └── Wheelchair
        │       └── Dockerfile
        ├── cuda
        │   ├── Dockerfile
        │   ├── KUKA
        │   └── Wheelchair
        │       └── Dockerfile
        ├── ros_entrypoint.sh
        └── Table.stl
   ```

   Navigate into the `Scripts` folder inside the cloned repo and run the following command

   ```Shell
   docker build -t <BASE_IMAGE_NAME> .
   ```

   you can replace `BASE_IMAGE_NAME` with a name of your own choice, but also remeber to substitute it correctly in the commands that follow.

   #### A. For cpu install

   Navigate to `Scripts/Galactic/cpu` and:

   ```Shell
   docker build -t galactic_cpu .
   ```
   #### B. For CUDA install

   Navigate to `Scripts/Galactic/cuda` and:
   ```Shell
   docker build -t galactic_cuda .
   ``` 

   The following command will show docker images currently built and available on your host machine.

   ```Shell
   docker image ls
   ```

   ### 2. Building the project specific docker images

   Now that you have a base image built, it is time to build a project specific image that uses the above image as a base image. For this navigate to the project for which you wish to create an image for. And again, we build it:

   ```Shell
   docker build -t <PROJECT_IMAGE _NAME> .
   ``` 

## 4. Using the docker environment

After creating the docker image, it is ready to use. The command for using this is as following:

```Shell
xhost +local:docker
docker run -it --rm --name=<CONTAINER_NAME> --gpus=all --net=host --pid=host --privileged --env="DISPLAY=$DISPLAY" <IMAGE_NAME>
```

>[!Note]
>- I'll be explaining these arguments eventually.

<!-- ## 6. Using the IIWA stack

We use the (kind of) official [lbr-stack](https://github.com/lbr-stack/lbr_fri_ros2_stack/tree/humble). You don't need to download that but it needs to be built after starting the docker. The docker is started with `root` access by default. -->