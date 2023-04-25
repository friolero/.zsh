FROM ubuntu:20.04 
#FROM nvidia/cuda:11.6.0-devel-ubuntu20.04

LABEL maintainer="Zeng Yuwei yuwei.zeng0101@gmail.com"

ENV PYTHON_VERSION 3.8
ARG DEBIAN_FRONTEND=noninteractive

# dependencies for ros, zshand vim ale
RUN apt-get update && \
    apt-get -y install --no-install-recommends \
       sudo \
       python${PYTHON_VERSION} \
       python${PYTHON_VERSION}-dev \
       python3-pip\
       software-properties-common \
       lsb-release \
       build-essential \
       cmake \
       libxrandr-dev \
       libxinerama-dev \
       libxcursor-dev \
       libxi-dev \
       libgl1-mesa-dev \
       libxxf86vm-dev \
       imagemagick \
       openssh-client \
       ca-certificates \
       trash-cli \
       wget \
       curl \
       git \
       zsh \
       vim \
       gnupg 
RUN pip install -U pip gpustat matplotlib pillow

# setup ssh key for git cloning private repos later in a inelegant way
RUN mkdir /root/.ssh
ADD id_rsa /root/.ssh/id_rsa
RUN touch /root/.ssh/known_hosts && \
    ssh-keyscan -H github.com >> ~/.ssh/known_hosts

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

# setup vim
WORKDIR /home/$USERNAME
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

# setup zsh
RUN apt-get update && \
    apt-get -y install --no-install-recommends fonts-powerline && \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
RUN git clone git@github.com:friolero/.zsh.git && \
    ln -sf /home/$USERNAME/.zsh/.zshrc /home/$USERNAME/.zshrc && \
    chown -R $USERNAME: /home/$USERNAME/.zsh  

# install vundle plugin and initialize zsh
USER $USERNAME
RUN /bin/bash -c "ln -sf /home/$USERNAME/.vim/.vimrc /home/$USERNAME; python3 /home/$USERNAME/.vim/bundle/YouCompleteMe/install.py; vim -T dumb -n -i NONE -es -S <(echo -e 'silent! PluginInstall')"
RUN /bin/zsh /home/$USERNAME/.zshrc
