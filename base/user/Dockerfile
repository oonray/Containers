#USER
FROM base AS user
ARG USR=oonray
ARG GH_USR=oonray
ARG PUID=999
ARG PGID=999

ARG VERSION="1.0.3"
ENV VERSION="$VERSION"

LABEL version="${VERSION}"
LABEL org.opencontainers.image.version="${VERSION}"
LABEL org.opencontainers.image.title=$ARCH-user

ENV GH_USR=${GH_USR} USR=${USR}
ENV  \
    GOPATH="/home/$USR/.go" \
    T_USR_CONF="/home/$USR/tmux.conf" \
    Z_USR_CONF="/home/$USR/.zshrc" \
    C_USR_CONF="/home/$USR/.config/dircolors"

RUN useradd -r -m -u $PUID -s /usr/bin/zsh $USR \
    && echo "$USR ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/$USR

USER ${USR}
ENV PGID=${PGID} PUID=${PUID}
WORKDIR "/home/$USR/"

COPY tmux.conf ${T_USR_CONF}
COPY zshrc ${Z_USR_CONF}
COPY dircolors ${C_USR_CONF}

RUN git clone https://github.com/ohmyzsh/ohmyzsh.git .oh-my-zsh

RUN ssh-import-id gh:$GH_USR

