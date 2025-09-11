#evilginx
FROM oonray/tmux:latest AS tmux
FROM golang:latest AS build

ENV GOROOT="/usr/local/go"

ENV B_DIR="/opt/bin"
ENV GOBIN="$B_DIR"

ENV G_DIR="/opt/git"

ENV E_GIT="$G_DIR/evilginx3"
ENV E_DIR="/opt/evilginx"
ENV E_PHISHLETS="$E_DIR/phislets"
ENV E_REDIRECTORS="$E_DIR/redirectors"
ENV E_EILPUPPET="$E_DIR/evilpuppet"
ENV E_STATIC="$E_DIR/evilpuppet"

ENV GOPATH="$E_DIR"

ENV E_BIN="$B_DIR/evilginx3"

RUN mkdir $G_DIR \
    && mkdir $B_DIR \
    && git clone https://github.com/kgretzky/evilginx2.git $E_DIR

WORKDIR $E_DIR
RUN go build -o $E_BIN -mod=vendor main.go \
    && chmod 755 $E_BIN

FROM debian:latest AS prod

ENV E_PRO=false
ENV APPIMAGE_EXTRACT_AND_RUN=1

ARG USR=evilginx
ENV USR="$USR"
ENV CONF_DIR="/opt/conf"

ENV T_CONF="$CONF_DIR/tmux/tmux.conf"
ENV Z_CONF="$CONF_DIR/zsh/zshrc"
ENV C_CONF="$CONF_DIR/colors/dircolors"

ENV B_DIR="/opt/bin"

ENV E_DIR="/opt/evilginx"
ENV E_PHISHLETS="$E_DIR/phislets"
ENV E_REDIRECTORS="$E_DIR/redirectors"
ENV E_EILPUPPET="$E_DIR/evilpuppet"
ENV E_STATIC="$E_DIR/evilpuppet"

ARG E_PORT=33500
ENV E_PORT=${E_PORT}

ARG DISPLAY=":99"
ENV DISPLAY="${DISPLAY}"

RUN mkdir -p $B_DIR \
    && mkdir -p $E_DIR \
    && mkdir -p $E_PHISHLETS \
    && mkdir -p $E_REDIRECTORS \
    && mkdir -p $E_EILPUPPET \
    && mkdir -p $E_STATIC

COPY --from=build /opt/bin/evilginx3 /opt/bin/evilginx

RUN apt-get update && \
apt-get install -y  \
python3 python3-pip python3-venv \
openssh-client openssh-server dumb-init ssh-import-id \
tmux tmuxinator zsh git jq yq curl sudo zip tar 7zip \
proxychains socat net-tools dnsutils netcat-traditional neovim \
xorg xvfb ca-certificates fonts-liberation libappindicator3-1 \
libasound2 libatk-bridge2.0-0 libatk1.0-0 libc6 libcairo2 libcups2 \
libdbus-1-3 libexpat1 libfontconfig1 libgbm1 libgcc1 libglib2.0-0 \
libgtk-3-0 libnspr4 libnss3 libpango-1.0-0 libpangocairo-1.0-0 \
libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 \
libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 \
libxss1 libxtst6 lsb-release wget xdg-utils

COPY --from=tmux /opt/deb/bat.deb /tmp/bat.deb
RUN apt install -y /tmp/bat.deb && \
rm /tmp/bat.deb

COPY --from=tmux /etc/ssh/sshd_config /etc/ssh/sshd_config

RUN useradd -u 1000 -s /usr/bin/zsh -m $USR
RUN echo "$USR ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/$USR

USER ${USR}
WORKDIR /home/${USR}
RUN mkdir -p ~/.config

#Install NODE
ENV NVM_DIR="/home/$USR/.nvm"
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash \
    && [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" \
    && nvm install 23 \
    && npm install yarn

COPY --from=tmux  $T_CONF ~/.tmux.conf
COPY --from=tmux  $Z_CONF ~/.zshrc
COPY --from=tmux  $CONF_DIR/zsh/.oh-my-zsh ~/.oh-my-zsh
COPY --from=tmux  $C_CONF ~/.config/dircolors
RUN ssh-import-id gh:oonray

ENV PUID=1000
ENV PGID=1000

#
#Cleanup
#
USER root
RUN chown -R $USR /home/$USR \
    && apt-get autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY entrypoint.sh /opt/entrypoint.sh
ENTRYPOINT ["/opt/entrypoint.sh"]
