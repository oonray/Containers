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

COPY --from=golang:latest ${GOROOT} ${GOROOT}
COPY --from=rust:latest / /
COPY --from=mcr.microsoft.com/dotnet/runtime:9.0 / /
COPY --from=mcr.microsoft.com/dotnet/sdk:9.0 / /
COPY --from=node:latest / /

#
#install deps
#
RUN apt-get install -y \
python3 python3-pip python3-venv

RUN apt-get install -y \
fuse3 fd-find ripgrep sudo

RUN apt-get install -y \
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
#Cleanup
#
USER root
RUN rm -rf /tmp/* && \
chown -R $USR /home/$USR && \
apt-get autoremove && apt-get clean

#
#USR
#
USER dev
WORKDIR /home/dev

RUN mkdir -p ~/.config && \
cp $T_CONF ~/.tmux.conf && \
cp $Z_CONF ~/.zshrc && \
cp -r $Z_DIR/.oh-my-zsh ~/.oh-my-zsh && \
cp $C_CONF ~/.config/dircolors

#
#NVIM CONFIG
#
RUN mkdir -p ${GOPATH}
RUN mkdir -p /home/dev/.config && \
mkdir -p /home/dev/.local/share/nvim/ws/worskpaces/

COPY ./nvim-config/ /home/dev/.config/nvim/

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
