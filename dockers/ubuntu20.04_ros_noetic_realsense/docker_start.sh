docker build --build-arg PYTHON_VERSION=3.8 --build-arg ROS_DISTRO=noetic --build-arg USERNAME=$USER --build-arg UID=$UID -t ubuntu20.04:base .    
docker run --rm --privileged -v /dev:/dev -e DISPLAY=$DISPLAY --gpus all --network host --user $USER --name ubuntu20.04 -it ubuntu20.04:base /bin/zsh
