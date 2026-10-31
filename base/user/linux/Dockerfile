#USER
FROM base AS user

ARG USR=oonray \
    GH_USR=oonray \
    PUID=999 \
    PGID=999 \
    VERSION="1.0.4"\
    ARCH=amd64

ARG B_VER=0.25.0

ENV VERSION="$VERSION"\
    GH_USR=${GH_USR} USR=${USR} \
    GOPATH="/home/$USR/.go" \
    T_USR_CONF="/home/$USR/tmux.conf" \
    Z_USR_CONF="/home/$USR/.zshrc" \
    C_USR_CONF="/home/$USR/.config/dircolors" \
    PGID=${PGID} PUID=${PUID} ARCH=${ARCH}


LABEL version=${VERSION} \
      org.opencontainers.image.version=${VERSION} \
      org.opencontainers.image.title=${ARCH}-user


USER root

# APT
RUN apt-get update \
    && apt-get install -y dumb-init \
    openssh-client ssh-import-id \
    tmux zsh git jq yq curl \
    sudo zip 7zip tar xxd golang \
    netcat-traditional net-tools \
    python3 python3-pip python3-venv \
    cryptsetup cryptsetup-initramfs \
    cryptsetup-nuke-password 

# USER
RUN useradd -r -m -u $PUID -s /usr/bin/zsh $USR \
    && echo "$USR ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/$USR

SHELL ["/usr/bin/zsh","-c"]

# BAT
RUN curl -Lo /tmp/bat.deb \
    https://github.com/sharkdp/bat/releases/download/v${B_VER}/bat_${B_VER}_${ARCH}.deb \
    && apt install -y /opt/deb/bat.deb

USER ${USR}
WORKDIR ~

RUN mkdir -p .config

COPY --chown=$USR:$USR tmux.conf .tmux.conf
COPY --chown=$USR:$USR zshrc .zshrc
COPY --chown=$USR:$USR dircolors .config/dircolors

RUN git clone https://github.com/ohmyzsh/ohmyzsh.git .oh-my-zsh \
&& git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm \
&& ssh-import-id gh:$GH_USR

