FROM oonray/ssh:latest

RUN apt-get update \
&& apt-get upgrade -y

RUN apt-get install -y \
fuse3 fd-find ripgrep git jq curl zsh sudo zip tar dumb-init \
tmux tmuxinator

RUN apt-get install -y \
gcc g++ make bear cmake llvm \
mingw-w64 mingw-w64-tools build-essential \
python3 python3-venv python3-pip \
exuberant-ctags lua-check \
gdb swig 

RUN apt-get autoremove && apt-get clean

#user
RUN useradd -u 1000 -s /usr/bin/zsh -m dev
#-G sudo
#RUN echo "dev ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/dev

#RUN NEOVIM
ENV APPIMAGE_EXTRACT_AND_RUN=1

#SSH
#RUN mkdir -p /home/dev/.ssh && \
#echo "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIGTCxFD2UzUYYWAuDnFzwMmeWsVkPZLNfObG3hJZ4GuKAAAABHNzaDo=" >> /home/dev/authorized_keys
#EXPOSE 22

#BAT
#export VERSION=`curl -L https://github.com/sharkdp/bat/tags | grep -oE '>(*v.*\.*\..*)<\' | grep -oE '[0-9]+\.[0-9]+\.[0-9]+' | awk 'NR==1{print $1}'`
RUN curl -Lo /tmp/bat.deb https://github.com/sharkdp/bat/releases/download/v0.25.0/bat_0.25.0_amd64.deb && \
apt install -y /tmp/bat.deb

#NVIM
RUN curl -Lo /bin/nvim "https://github.com/neovim/neovim/releases/download/`curl https://api.github.com/repos/neovim/neovim/releases/latest | jq -r .tag_name`/nvim-linux-x86_64.appimage"
RUN chmod +x /bin/nvim

#GO
RUN curl -Lo /tmp/go.tar.gz https://golang.org/dl/`curl https://go.dev/VERSION?m=text | grep go`.linux-amd64.tar.gz && \
rm -rf /usr/local/go && \
tar -C /usr/local -xzf /tmp/go.tar.gz && \
rm /tmp/go.tar.gz

#RUST
RUN curl -sSf https://sh.rustup.rs | sh -s -- -y

#COPY entrypoint.sh /opt/entrypoint.sh
#RUN chmod +x /opt/entrypoint.sh

#dotnet
RUN curl -Lo /tmp/dotnet.deb https://packages.microsoft.com/config/debian/12/packages-microsoft-prod.deb && \
apt install -y /tmp/dotnet.deb && \
apt-get update && \
apt-get install -y aspnetcore-runtime-9.0 dotnet-sdk-9.0

#USER RELATED
USER dev
WORKDIR /home/dev

#SET ENV
ENV NVM_DIR="/home/dev/.nvm"
ENV GOPATH="/home/dev/.go"
ENV GOROOT="/usr/local/go"
ENV PATH="$PATH:/home/dev/.nvm:$GOROOT/bin:$GOPATH/bin"


#SET UP ZSH
COPY zsh-config/zshrc .zshrc
RUN git clone https://github.com/ohmyzsh/ohmyzsh.git .oh-my-zsh

#NODE
RUN curl -Lo /tmp/nvm.sh https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh && \
chmod +x /tmp/nvm.sh && \
/tmp/nvm.sh
RUN . "$NVM_DIR/nvm.sh" && nvm install 23 && npm install yarn

#CONFIG
RUN mkdir -p /home/dev/.go
RUN mkdir -p /home/dev/.config
RUN mkdir -p /home/dev/.config/nvim/lua/config/
RUN mkdir -p /home/dev/.local/share/nvim/ws/worskpaces/

COPY ./nvim-config/init.lua /home/dev/.config/nvim/init.lua
COPY ./nvim-config/lua/config /home/dev/.config/nvim/lua/config
COPY ./tmux-config/tmux.conf /home/dev/.tmux.conf

COPY ./dircolors /home/dev/.config/dircolors

#Run nvim init install
RUN zsh -c "nvim --headless -c':Lazy install | sleep 10 | qa'"
RUN zsh -c "nvim --headless -c':sleep 20 | qa'"
RUN zsh -c "$(curl -fsSL https://gef.blah.cat/sh)"

#Cleanup
USER root
RUN rm -rf /tmp/*
RUN chown -R dev /home/dev
USER dev

ENV PUID=1000
ENV PGID=1000

#ENTRYPINT
ENTRYPOINT ["dumb-init","--"]
CMD ["sleep","infinity"]
