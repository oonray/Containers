#DEV
FROM base AS dev

ARG L_HOST="127.0.0.1" \
    L_PORT="42069"\
    USR ARCH \
    PUID PGID \
    VERSION="1.0.3"

ENV G_DIR="/opt/git" \
    D_DIR="/opt/deb" \
    L_HOST=${L_HOST} \
    L_PORT=${L_PORT} \
    CONF_DIR="/opt/conf" \
    CONF_DIR="/opt/conf" \
    NVM_DIR="/home/$USR/.nvm" \
    GOPATH="/home/$USR/.go" GOROOT="/usr/local/go" \
    PUID=${PUID} PGID=${PGID} VERSION="$VERSION" \
    USR=${USR} ARCH=${ARCH} APPIMAGE_EXTRACT_AND_RUN=1 \
    PATH="$PATH:/home/$USR/.nvm:$GOROOT/bin:$GOPATH/bin" \
    T_DIR="$CONF_DIR/tmux" T_CONF="$CONF_DIR/tmux/tmux.conf" \
    Z_DIR="$CONF_DIR/zsh" Z_CONF="$Z_DIR/zshrc" \
    C_DIR="$CONF_DIR/colors" C_CONF="$C_DIR/dircolors" \
    DEBIAN_FRONTEND=noninteractive

LABEL version="${VERSION}" \
      org.opencontainers.image.version="${VERSION}" \
      org.opencontainers.image.title="dev"

USER $USR

COPY ./nvim-config/ /home/$USR/.config/nvim/
COPY ./tmux-config/tmux.conf /home/$USR/.tmux.conf

RUN sudo chown -R $USR:$USR /home/$USR/

WORKDIR /home/$USR/git
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["tmux","new","-t","dev"]

