ARG IMAGE=debian
ARG GH_USR=oonray
ARG USR=${GH_USR}
ARG ENTRY=/opt/entrypoint.sh
ARG B_VER=0.25.0
ARG ARCH=trixie-slim
ARG PUID=999
ARG PGID=999

FROM ${IMAGE}:${ARCH} AS install
ARG USR
ARG GH_USR
ARG ENTRY
ARG B_VER
ARG ARCH
ARG PUID
ARG PGID

ENV ARC=${ARCH} GH_USR=${GH_USR} USR=${USR} \
    APPIMAGE_EXTRACT_AND_RUN=1 ENTRY=${ENTRY} 

ENV GOPATH="/home/$USR/.go" \
    GOROOT="/usr/local/go"

ENV CONF_USR_DIR="/home/$USR/" \
    T_USR_CONF="$CONF_USR_DIR/tmux.conf" \
    Z_USR_CONF="$CONF_USR_DIR/.zshrc" \
    C_USR_CONF="$CONF_USR_DIR/.config/dircolors"

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
    cryptsetup-nuke-password 

COPY ../ssh/sshd_config /etc/ssh/sshd_config
COPY ../ssh/entrypoint.sh ${ENTRY}

RUN curl -Lo /tmp/bat.deb \
    https://github.com/sharkdp/bat/releases/download/v${B_VER}/bat_${B_VER}_${ARC}.deb \
    && apt install -y /opt/deb/bat.deb

SHELL ["/usr/bin/zsh","-c"]

COPY ../tmux/tmux.conf /opt/conf
COPY ../tmux/zshrc /opt/conf
COPY ../tmux/dircolors /opt/conf

FROM install AS installgo
ENV GOROOT="/usr/local/go"
ENV PATH="$PATH:$GOROOT/bin"
COPY --from=golang:latest ${GOROOT} ${GOROOT}

FROM installgo AS user
ONBUILD ARG USR
ONBUILD ARG GH_USR
ONBUILD ARG PUID
ONBUILD ARG PGID

ONBUILD ENV GH_USR=${GH_USR} USR=${USR}
ONBUILD ENV  \
    GOPATH="/home/$USR/.go" \
    CONF_USR_DIR="/home/$USR/" \
    T_USR_CONF="$CONF_USR_DIR/tmux.conf" \
    Z_USR_CONF="$CONF_USR_DIR/.zshrc" \
    C_USR_CONF="$CONF_USR_DIR/.config/dircolors"

ONBUILD RUN groupadd -g $PGID $USR \
    && useradd -r -m -u $PUID -g $USR -s /usr/bin/zsh ${USR} \
    && echo "$USR ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/$USR

ONBUILD USER ${USR}
ONBUILD ENV PGID=${PGID} PUID=${PUID}
ONBUILD WORKDIR ${CONF_USR_DIR}

ONBUILD RUN mkdir -p $CONF_USR_DIR/.config \
    && cp -r /opt/conf/zshrc ${Z_USR_CONF} \
    && cp -r /opt/conf/tmux.conf ${T_USR_CONF} \
    && cp -r /opt/conf/dircolors ${T_USR_CONF}

ONBUILD RUN git clone https://github.com/ohmyzsh/ohmyzsh.git $CONF_USR_DIR/.oh-my-zsh

ONBUILD RUN ssh-import-id gh:$GH_USR

FROM user AS cleanup

ONBUILD USER root
ONBUILD RUN chown -R $USR:$USR /home/$USR \
    && apt-get autoremove \
    && apt-get clean \
    && rm -rf /opt/conf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ONBUILD USER $USR
