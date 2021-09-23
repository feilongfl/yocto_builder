FROM ubuntu:18.04

# RUN sed -i 's/archive.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list
# RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
# RUN sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Shanghai

RUN apt-get update && apt-get -y dist-upgrade && apt-get install -y \
            gcc-multilib chrpath socat cpio python \
            python3 python3-pip python3-pexpect xz-utils debianutils iputils-ping \
            python3-git python3-jinja2 locales bash-completion \
            gawk wget git diffstat unzip texinfo gcc build-essential \
            libegl1-mesa libsdl1.2-dev pylint3 xterm python3-subunit mesa-common-dev \
            sudo fish tmux nload htop vim zstd liblz4-tool zsh powerline fonts-powerline zsh-theme-powerlevel9k zsh-syntax-highlighting powerline

ENV USERNAME=yocto
ARG USERPASS=yocto

ARG PUID=1000
ARG PGID=1000

RUN groupadd -g ${PGID} ${USERNAME} \
            && useradd -u ${PUID} -g ${USERNAME} -d /home/${USERNAME} ${USERNAME} \
            && usermod -aG sudo ${USERNAME} \
            && mkdir /home/${USERNAME} \
            && chown -R ${USERNAME}:${USERNAME} /home/${USERNAME} \
            && echo ${USERNAME}:${USERPASS} | chpasswd

RUN locale-gen en_US.UTF-8

ENV LANG en_US.UTF-8

COPY ./yocto-build.sh /home/${USERNAME}/build.sh

USER ${USERNAME}

WORKDIR /home/${USERNAME}/poky

ENV TERM="xterm-256color"

RUN sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

RUN echo "source /usr/share/powerlevel9k/powerlevel9k.zsh-theme" >> ~/.zshrc && \
    echo "source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc && \
    echo source /home/${USERNAME}/poky/oe-init-build-env >> ~/.zshrc && \
    echo powerline-config tmux setup>> ~/.zshrc

ENTRYPOINT tmux new-session -A -c /home/${USERNAME}/poky -s ${USERNAME} -n ${USERNAME} "zsh"
