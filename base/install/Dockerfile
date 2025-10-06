ARG ARCH=amd64 #amd64 arm64 i386

FROM --platform=linux/$ARCH base  AS install
ARG ARCH
ARG ENTRY=/opt/entrypoint.sh
ARG B_VER=0.25.0
ARG G_URL=https://github.com
ARG B_URL=${G_URL}/sharkdp/bat/releases/download/v${B_VER}/bat_${B_VER}_${ARCH}.deb

ARG VERSION="1.0.0"
ENV VERSION="$VERSION"

LABEL version="${VERSION}"
LABEL org.opencontainers.image.version="${VERSION}"
LABEL org.opencontainers.image.title=$ARCH-install

ENV APPIMAGE_EXTRACT_AND_RUN=1 \
    ENTRY=${ENTRY} B_VER=${B_VER} ENTRY=${ENTRY}

RUN apt-get update \
    && apt-get install -y dumb-init supervisor \
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

RUN mkdir -p /etc/supervisor.d/

COPY sshd_config /etc/ssh/sshd_config
COPY entrypoint.sh ${ENTRY}
COPY supervisord.conf /etc/supervisord.conf

RUN curl -Lo /tmp/bat.deb ${B_URL}\
    && apt install -y /tmp/bat.deb

EXPOSE 9001
SHELL ["/usr/bin/zsh","-c"]


