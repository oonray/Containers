ARG IMAGE=kalilinux/kali-rolling
ARG ENTRY=/opt/entrypoint.sh
ARG B_VER=0.25.0
ARG ARCH=amd64 #amd64 arm64 i386

FROM ${IMAGE}:${ARCH} AS install
ARG USR
ARG GH_USR
ARG ENTRY
ARG B_VER
ARG ARCH
ARG PUID
ARG PGID

ENV ARC=${ARCH} APPIMAGE_EXTRACT_AND_RUN=1 \
    ENTRY=${ENTRY} B_VER=${B_VER}


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
    && apt install -y /opt/deb/bat.deb

SHELL ["/usr/bin/zsh","-c"]

COPY ../user/tmux.conf /opt/conf
COPY ../user/zshrc /opt/conf
COPY ../user/dircolors /opt/conf

FROM install AS installgo
ENV GOROOT="/usr/local/go"
ENV PATH="$PATH:$GOROOT/bin"
COPY --from=golang:latest ${GOROOT} ${GOROOT}

FROM installgo AS user
