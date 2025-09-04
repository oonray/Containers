#
#SSH + TMUX
#
FROM oonray/tmux:latest

#
#Set ENV
#
ENV APPIMAGE_EXTRACT_AND_RUN=1

ENV USR=dev
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
#Install deps
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
#Create user
#
RUN useradd -u 1000 -s /usr/bin/zsh -m $USR
RUN echo "$USR ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/$USR

#
#Install NVIM
#
RUN curl -Lo /bin/nvim "https://github.com/neovim/neovim/releases/download/`curl https://api.github.com/repos/neovim/neovim/releases/latest | jq -r .tag_name`/nvim-linux-x86_64.appimage"
RUN chmod +x /bin/nvim

#
#Install RUST
#
RUN curl -sSf https://sh.rustup.rs | sh -s -- -y

# 
#Install GO
#
COPY --from=golang:latest ${GOROOT} ${GOROOT}

# 
#Install DOTNET
#
RUN curl -Lo /tmp/dotnet.deb https://packages.microsoft.com/config/debian/12/packages-microsoft-prod.deb && \
apt install -y /tmp/dotnet.deb && \
apt-get update && \
apt-get install -y aspnetcore-runtime-9.0 dotnet-sdk-9.0

#
#Install NODE
#
RUN zsh -c 'mkdir -p $NVM_DIR &&\
curl -Lo /tmp/nvm.sh https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh && \
chmod +x /tmp/nvm.sh && \
source $NVM_DIR/nvm.sh && \
source /opt/conf/zsh/zshrc && \
nvm install 23 && \
npm install yarn'

RUN mkdir -p /home/dev/.ssh && \
cp /root/.ssh/authorized_keys /home/dev/.ssh/authorized_keys && \
chown -r dev:dev /home/dev/.ssh

#
#Configure User
#
USER dev
WORKDIR /home/dev

#
#Configure NVIM
#
RUN mkdir -p ${GOPATH} && \
mkdir -p /home/dev/.config && \
mkdir -p /home/dev/.local/share/nvim/ws/worskpaces/

COPY ./nvim-config/ /home/dev/.config/nvim/

#
#NVIM INIT
#
RUN zsh -c "nvim --headless -c':Lazy install | sleep 10 | qa'"
RUN zsh -c "nvim --headless -c':sleep 20 | qa'"
#
#Install debuggers gdb gef + radare
#
RUN zsh -c "$(curl -fsSL https://gef.blah.cat/sh)" && \
apt-get install -y radare2 xxd ncurses-hexedit

#
#Cleanup
#
USER root
RUN rm -rf /opt/* && \
chown -R $USR /home/$USR && \
apt-get autoremove && \
apt-get clean

#
#Entrypoint
#
ENTRYPOINT ["/opt/entrypoint.sh"]
