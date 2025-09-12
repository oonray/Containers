FROM base AS user
ARG USR=oonray
ARG GH_USR=oonray
ARG PUID=999
ARG PGID=999

ENV GH_USR=${GH_USR} USR=${USR}
ENV  \
    GOPATH="/home/$USR/.go" \
    T_USR_CONF="/home/$USR/tmux.conf" \
    Z_USR_CONF="/home/$USR/.zshrc" \
    C_USR_CONF="/home/$USR/.config/dircolors"

RUN useradd -r -m -u $PUID -g $USR -s /usr/bin/zsh $USR \
    && echo "$USR ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/$USR

USER ${USR}
ENV PGID=${PGID} PUID=${PUID}
WORKDIR "/home/$USR/"

RUN mkdir -p $CONF_USR_DIR/.config \
    && cp -r /opt/conf/zshrc ${Z_USR_CONF} \
    && cp -r /opt/conf/tmux.conf ${T_USR_CONF} \
    && cp -r /opt/conf/dircolors ${T_USR_CONF}

RUN git clone https://github.com/ohmyzsh/ohmyzsh.git $CONF_USR_DIR/.oh-my-zsh

RUN ssh-import-id gh:$GH_USR

