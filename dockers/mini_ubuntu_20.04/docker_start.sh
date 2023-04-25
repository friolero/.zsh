docker build --build-arg PYTHON_VERSION=3.8 --build-arg USERNAME=$USER --build-arg UID=$UID -t mini_ubuntu20.04 .
docker run --rm --privileged -v /Users/zyuwei/Projects:/home/zyuwei/Projects -e DISPLAY=$DISPLAY --network host --user $USER --name ubuntu20.04 -it mini_ubuntu20.04 /bin/zsh
