ARG ARCH=amd64 #amd64 arm64 i386

FROM --platform=linux/$ARCH base  AS install
ARG ARCH
ARG ENTRY=/opt/entrypoint.sh
ARG B_VER=0.25.0

ENV APPIMAGE_EXTRACT_AND_RUN=1 \
    ENTRY=${ENTRY} B_VER=${B_VER} ENTRY=${ENTRY}

RUN apt-get update \
    && apt-get install -y dumb-init \
    openssh-client openssh-server \
    ssh-import-id \
    \
    tmux tmuxinator zsh git jq yq curl \
    sudo zip 7zip tar xxd \
    net-tools netcat-traditional \
    python3 python3-pip python3-venv pipx \
    i2c-tools screen cifs-utils \
    cryptsetup cryptsetup-initramfs \
    cryptsetup-nuke-password 

COPY sshd_config /etc/ssh/sshd_config
COPY entrypoint.sh ${ENTRY}

ARG G_URL=https://github.com
ARG B_URL=${G_URL}/sharkdp/bat/releases/download/v${B_VER}/bat_${B_VER}_${ARCH}.deb
RUN curl -Lo /tmp/bat.deb ${B_URL}\
    && apt install -y /tmp/bat.deb

SHELL ["/usr/bin/zsh","-c"]


