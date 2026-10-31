#
# DEV CONTAINER
#

#
# GOLANG IMAGES
#
ARG GO_VERSION=latest \
    GO_VERSION_TINY=latest

#
# ZSH and shell
#
FROM oonray/user:latest AS base

ARG USR ARCH \
    PUID PGID \
    VERSION="1.0.3"

# Container ENV
ENV PUID=${PUID} \
    PGID=${PGID} \
    VERSION="$VERSION" \
    USR=${USR} ARCH=${ARCH} \
    DEBIAN_FRONTEND=noninteractive 

# neovim ENV
ENV APPIMAGE_EXTRACT_AND_RUN=1 

# GO env
ENV GOPATH="/home/$USR/.go" \
    GOROOT="/usr/local/go" \
    GO_VERSION=latest \
    GO_VERSION_TINY=latest \
    PATH="$PATH:$GOROOT/bin:$GOPATH/bin:$GOROOT_TINY/bin"

# NODE env
ENV NVM_DIR="/home/$USR/.nvm" \
    PATH="$PATH:/home/$USR/.nvm"

ENV G_DIR="/opt/git" \
    D_DIR="/opt/deb" \
    CONF_DIR="/opt/conf" \
    CONF_DIR="/opt/conf" \

LABEL version="${VERSION}" \
      org.opencontainers.image.version="${VERSION}" \
      org.opencontainers.image.title="dev"

#
# Build Start
#
USER root
COPY --chmod=+x ./entrypoint.sh /opt/entrypoint.sh
#
# APT
#
RUN apt-get update && \
    apt-get install -y \
    python3 python3-pip python3-venv \
    fuse3 fd-find ripgrep \
    gcc g++ make bear cmake llvm \
    mingw-w64 mingw-w64-tools build-essential \
    exuberant-ctags lua-check \
    swig lua5.1
#
# DEBUG
#
# APT
RUN apt-get install -y \
    man xxd ncurses-hexedit gdb

# RADARE 2
ENV RA_VER="6.0.2" \
    RA_URL="https://github.com/radareorg/radare2/releases/download/$RA_VER/radare2_$RA_VER_amd64.deb"
RUN mkdir -p /tmp \
    && curl -Lo /tmp/radare2.deb  $RA_URL\
    && apt install /tmp/radare2.deb \
    && rm -rf /tmp/radare2.deb

# GEF
RUN zsh -c "$(curl -fsSL https://gef.blah.cat/sh)"

#
# GO install

COPY --from=golang:$GO_VERISON $GOROOT $GOROOT
COPY --from=tinygo/tinygo:$GO_VERSION_TINY $GOROOT_TINY $GOROOT_TINY

#
# RUST
#
RUN curl -sSf https://sh.rustup.rs | sh -s -- -y

#
#Install NODE
#
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash \
    && [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" \
    && nvm install 23 \
    && npm install yarn

# 
#Install DOTNET
#
#RUN curl -Lo /tmp/dotnet.deb https://packages.microsoft.com/config/debian/12/packages-microsoft-prod.deb && \
#apt install -y /tmp/dotnet.deb && \
#apt-get update && \
#apt-get install -y aspnetcore-runtime-9.0 dotnet-sdk-9.0

#RUN cp ${T_CONF} /home/$USR/.tmux.conf \
#    && cp ${Z_CONF} /home/$USR/.zshrc \
#    && cp ${CONF_DIR}/zsh/.oh-my-zsh /home/$USR/.oh-my-zsh \
#    && cp $C_CONF /home/$USR/.config/dircolors

#
# NEOVIM install
#
ENV NV_VER="$(curl https://api.github.com/repos/neovim/neovim/releases/latest | jq -r .tag_name)" \
    NV_URL="https://github.com/neovim/neovim/releases/download/$NV_VER/nvim-linux-x86_64.appimage"

RUN curl -Lo /bin/nvim $NV_URL \
    && chmod 755 /bin/nvim \
    && chmod +x /bin/nvim


USER $USR
WORKDIR ~

RUN mkdir -p ${GOPATH} \
&& mkdir -p .git \
&& mkdir -p .config \
&& mkdir -p .local/share/nvim/ws/worskpaces/

COPY --chown $USR:$USR ./nvim-config/ /home/$USR/.config/nvim/
COPY --chown $USR:$USR ./tmux-config/tmux.conf /home/$USR/.tmux.conf

#
# NEOVIM Install
#
RUN zsh -c "nvim --headless -c':Lazy install | sleep 10 | qa'"
RUN zsh -c "nvim --headless -c':sleep 20 | qa'"

#
# CLEANUP
#
USER root
RUN apt-get autoremove \
    && apt-get clean \
    && rm -rf /tmp/*

USER $USR
WORKDIR ~/git

VOLUME [ "/home/${USR}/git" ]
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["tmux","new","-t","dev"]

