xhost local:root

XAUTH=/tmp/.docker.xauth

docker run -it \
    --name=galactic_gui_gpu \
    --env="DISPLAY=$DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="/TMP/ .X11-unix:/tmp/ .X11-unix:rw" \
    --env="XAUTHORITY=$XAUTH" \
    --volume="$XAUTHORITY=$XAUTH" \
    --net=host \
    --priviliged \
    osrf/ros:galactic-desktop \
    bash

echo "GUI with GPU acceleration configured"