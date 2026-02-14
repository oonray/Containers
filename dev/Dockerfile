#DEV
FROM base AS dev
ARG L_HOST="127.0.0.1"
ENV L_HOST=${L_HOST}

ARG L_PORT="42069"
ENV L_PORT=${L_PORT}

ENV APPIMAGE_EXTRACT_AND_RUN=1

ARG USR
ENV USR=${USR}
ARG ARCH
ENV ARCH=${ARCH}
ARG PUID
ENV PUID=${PUID}
ARG PGID
ENV PGID=${PGID}

ENV G_DIR="/opt/git"
ENV D_DIR="/opt/deb"
ENV CONF_DIR="/opt/conf"

ENV GOPATH="/home/$USR/.go"
ENV GOROOT="/usr/local/go"

ENV NVM_DIR="/home/$USR/.nvm"
ENV PATH="$PATH:/home/$USR/.nvm:$GOROOT/bin:$GOPATH/bin"

ENV CONF_DIR="/opt/conf"
ENV T_DIR="$CONF_DIR/tmux"
ENV T_CONF="$CONF_DIR/tmux/tmux.conf"

ENV Z_DIR="$CONF_DIR/zsh"
ENV Z_CONF="$Z_DIR/zshrc"

ENV C_DIR="$CONF_DIR/colors"
ENV C_CONF="$C_DIR/dircolors"

ARG VERSION="1.0.2"
ENV VERSION="$VERSION"
ENV DEBIAN_FRONTEND=noninteractive

LABEL version="${VERSION}"
LABEL org.opencontainers.image.version="${VERSION}"
LABEL org.opencontainers.image.title=dev

USER $USR
WORKDIR /home/$USR

COPY ./nvim-config/ /home/$USR/.config/nvim/
COPY ./entrypoint.sh /opt/entrypoint.sh

WORKDIR /home/$USR/git
#
#Entrypoint
#
VOLUME [ "/home/${USR}/git" ]
#ENTRYPOINT ["/opt/entrypoint.sh"]
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["tmux","new","-t","dev"]

