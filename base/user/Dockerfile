#USER
FROM base AS user

ARG USR=oonray \
    GH_USR=oonray \
    PUID=999 \
    PGID=999 \
    VERSION="1.0.3"

ENV VERSION="$VERSION"\
    GH_USR=${GH_USR} USR=${USR} \
    GOPATH="/home/$USR/.go" \
    T_USR_CONF="/home/$USR/tmux.conf" \
    Z_USR_CONF="/home/$USR/.zshrc" \
    C_USR_CONF="/home/$USR/.config/dircolors" \
    PGID=${PGID} PUID=${PUID}

LABEL version="${VERSION}" \
      org.opencontainers.image.version="${VERSION}" \
      org.opencontainers.image.title="${ARCH}-user" 

RUN useradd -r -m -u $PUID -s /usr/bin/zsh $USR \
    && echo "$USR ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/$USR

USER ${USR}
WORKDIR "/home/$USR/"

COPY tmux.conf ${T_USR_CONF}
COPY zshrc ${Z_USR_CONF}
COPY dircolors ${C_USR_CONF}

RUN git clone\
https://github.com/ohmyzsh/ohmyzsh.git\
.oh-my-zsh \
&& ssh-import-id gh:$GH_USR

