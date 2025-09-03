#mine
FROM oonray/tmux:latest

#SET ENV
ENV APPIMAGE_EXTRACT_AND_RUN=1

ENV USR dev
ENV GOPATH="/home/$USR/.go"
ENV GOROOT="/usr/local/go"
ENV NVM_DIR="/home/$USR/.nvm"
ENV PATH="$PATH:/home/dev/.nvm:$GOROOT/bin:$GOPATH/bin"

ENV CONF_DIR="/opt/conf"
ENV T_DIR="$CONF_DIR/tmux"
ENV T_CONF="$CONF_DIR/tmux/tmux.conf"

ENV Z_DIR="$CONF_DIR/zsh"
ENV Z_CONF="$Z_DIR/zshrc"

ENV C_DIR="$CONF_DIR/colors"
ENV C_CONF="$C_DIR/dircolors"

ENV PUID=1000
ENV PGID=1000


#
#install deps
#
RUN apt-get update && \
apt-get install -y \
python3 python3-pip python3-venv && \
\
apt-get install -y \
fuse3 fd-find ripgrep sudo && \
\
apt-get install -y \
gcc g++ make bear cmake llvm \
mingw-w64 mingw-w64-tools build-essential \
exuberant-ctags lua-check \
gdb swig

#
#USR
#
RUN useradd -u 1000 -s /usr/bin/zsh -m $USR
RUN echo "$USR ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/$USR

#
#Install NVIM
#
RUN curl -Lo /bin/nvim "https://github.com/neovim/neovim/releases/download/`curl https://api.github.com/repos/neovim/neovim/releases/latest | jq -r .tag_name`/nvim-linux-x86_64.appimage"
RUN chmod +x /bin/nvim

#
#RUST
#
RUN curl -sSf https://sh.rustup.rs | sh -s -- -y

# 
#GO
#
COPY --from=golang:latest ${GOROOT} ${GOROOT}

# 
#DOTNET
#
RUN curl -Lo /tmp/dotnet.deb https://packages.microsoft.com/config/debian/12/packages-microsoft-prod.deb && \
apt install -y /tmp/dotnet.deb && \
apt-get update && \
apt-get install -y aspnetcore-runtime-9.0 dotnet-sdk-9.0

#
#NODE
#
RUN curl -Lo /tmp/nvm.sh https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh && \
chmod +x /tmp/nvm.sh && \
/tmp/nvm.sh
RUN . "$NVM_DIR/nvm.sh" && nvm install 23 && npm install yarn

#
#USR
#
USER dev
WORKDIR /home/dev

#
#NVIM CONFIG
#
RUN mkdir -p ${GOPATH}
RUN mkdir -p /home/dev/.config && \
mkdir -p /home/dev/.local/share/nvim/ws/worskpaces/

COPY ./nvim-config/ /home/dev/.config/nvim/

#
#Cleanup
#
USER root
RUN rm -rf /opt/* && \
chown -R $USR /home/$USR && \
apt-get autoremove && apt-get clean

USER dev

#
#NVIM INIT
#
RUN zsh -c "nvim --headless -c':Lazy install | sleep 10 | qa'"
RUN zsh -c "nvim --headless -c':sleep 20 | qa'"
#
# gdb gef
#
RUN zsh -c "$(curl -fsSL https://gef.blah.cat/sh)"

#
#entrypoint
#
ENTRYPOINT ["/opt/entrypoint.sh"]
