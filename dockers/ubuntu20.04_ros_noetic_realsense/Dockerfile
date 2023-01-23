#TODO(zyuwei) base image is going to deprecate
FROM nvidia/cuda:11.3.0-devel-ubuntu20.04 

LABEL maintainer="Zeng Yuwei yuwei.zeng0101@gmail.com"

ENV ROS_DISTRO noetic
ENV PYTHON_VERSION 3.8
ARG DEBIAN_FRONTEND=noninteractive

# dependencies for ros, zshand vim ale
RUN apt-get update && \
    apt-get -y install --no-install-recommends \
       linux-modules-extra-$(uname -r) \
       linux-headers-$(uname -r) \
       python${PYTHON_VERSION} \
       python${PYTHON_VERSION}-dev \
       python3-pip\
       cmake \
       software-properties-common \
       lsb-release \
       curl \
       openssh-client \
       git \
       zsh \
       vim 

# install ROS 
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
RUN apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
RUN curl -sSL 'http://keyserver.ubuntu.com/pks/lookup?op=get&search=0xC1CF6E31E6BADE8868B172B4F42ED6FBAB17C654' | apt-key add -
RUN apt-get update && \
    apt-get install -y \
        ros-${ROS_DISTRO}-desktop-full  \
        ros-${ROS_DISTRO}-catkin \
        ros-${ROS_DISTRO}-ddynamic-reconfigure \
        python3-catkin-tools #TODO(zyuwei) rosdep if needed

# install librealsense and realsense_ros
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE || sudo apt-key adv --keyserver
RUN add-apt-repository "deb https://librealsense.intel.com/Debian/apt-repo $(lsb_release -cs) main" -u
RUN apt-get update && \
    apt-get -y install --no-install-recommends \ 
        librealsense2-dkms \
        librealsense2-utils \
        librealsense2-dev \
        librealsense2-udev-rules
RUN mkdir -p /tmp/catkin_ws/src && \
    cd /tmp/catkin_ws/src  && \
    git clone https://github.com/IntelRealSense/realsense-ros.git && \
    cd realsense-ros && \
    git checkout `git tag | sort -V | grep -P "^2.\d+\.\d+" | tail -1`  && \
    cd /tmp/catkin_ws/src 
RUN /bin/bash -c "source /opt/ros/${ROS_DISTRO}/setup.bash; catkin_init_workspace /tmp/catkin_ws/src; cd /tmp/catkin_ws; catkin_make clean; catkin_make -DCATKIN_ENABLE_TESTING=False -DCMAKE_BUILD_TYPE=Release; catkin_make install"

# setup ssh key for git cloning private repos later in a inelegant way
RUN mkdir /root/.ssh
ADD id_ed25519 /root/.ssh/id_ed25519
RUN touch /root/.ssh/known_hosts
RUN ssh-keyscan -H github.com >> ~/.ssh/known_hosts

# create local user 
# to conclude if this is really better than to directly use root later
ARG USERNAME
ARG UID
ARG RSA_FOLDER
RUN adduser \
    --home /home/$USERNAME \
    --shell /bin/sh \
    --uid $UID \
    --gecos "" \
    --ingroup sudo\
    --disabled-password \
    $USERNAME
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# setup zsh
WORKDIR /home/$USERNAME
RUN mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg && \
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    chmod a+r /etc/apt/keyrings/docker.gpg
RUN apt-get update && \
    apt-get -y install --no-install-recommends \
       fonts-powerline \
       trash-cli \
       ca-certificates \
       curl \
       gnupg \
       lsb-release \
       docker-ce \
       docker-ce-cli \
       containerd.io 
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
RUN git clone git@github.com:friolero/.zsh.git && \
    ln -sf /home/$USERNAME/.zsh/.zshrc /home/$USERNAME/.zshrc && \
    chown -R $USERNAME: /home/$USERNAME/.zsh  

# source ros and realsense_ros in zshby default
RUN echo "source /opt/ros/${ROS_DISTRO}/setup.zsh" >> /home/$USERNAME/.zshrc
RUN mv /tmp/catkin_ws /home/$USERNAME && chown -R $USERNAME: /home/$USERNAME/catkin_ws
RUN echo "source /home/$USERNAME/catkin_ws/devel/setup.zsh" >> /home/$USERNAME/.zshrc

# setup vim
RUN apt-get update && \
    apt-get -y install --no-install-recommends \
       black \
       pylint \ 
       flake8 \ 
       isort \
       pycodestyle \
       pydocstyle \
       clang-format \
       clang-tidy 
RUN git clone --recursive git@github.com:friolero/.vim.git && \
    chown -R $USERNAME: /home/$USERNAME/.vim

# install vundle plugin
USER $USERNAME
RUN /bin/bash -c "ln -sf /home/$USERNAME/.vim/.vimrc /home/$USERNAME; python3 /home/$USERNAME/.vim/bundle/YouCompleteMe/install.py; vim -T dumb -n -i NONE -es -S <(echo -e 'silent! PluginInstall')"
RUN /bin/zsh /home/$USERNAME/.zshrc
