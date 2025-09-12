ARG ARCH=amd64 #amd64 arm64 i386
ARG ENTRY=/opt/entrypoint.sh
ARG B_VER=0.25.0

FROM --platform=linux/$ARCH base  AS install

ENV ARC=${ARCH} APPIMAGE_EXTRACT_AND_RUN=1 \
    ENTRY=${ENTRY} B_VER=${B_VER} ENTRY=${ENTRY}


RUN apt-get update \
    && apt-get install -y dumb-init \
    openssh-client openssh-server \
    ssh-import-id \
    \
    tmux tmuxinator zsh git jq yq curl unrar \
    sudo zip 7zip tar xxd netcat-traditional \
    net-tools dns-utils netcat-traditional \
    python3 python3-pip python3-venv pipx \
    i2c-tools screen set cifs-utils \
    cryptsetup cryptsetup-initramfs \
    cryptsetup-nuke-password \
    \
    kali-linux-core kali-system-cli

COPY ../ssh/sshd_config /etc/ssh/sshd_config
COPY ../ssh/entrypoint.sh ${ENTRY}

RUN curl -Lo /tmp/bat.deb \
    https://github.com/sharkdp/bat/releases/download/v${B_VER}/bat_${B_VER}_${ARC}.deb \
    && apt install -y /tmp/bat.deb

SHELL ["/usr/bin/zsh","-c"]

COPY ../../tmux/tmux.conf /opt/conf
COPY ../../tmux/zshrc /opt/conf
COPY ../../tmux/dircolors /opt/conf

