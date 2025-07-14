FROM debian:latest

RUN apt-get update \
&& apt-get upgrade -y

RUN apt-get install -y \
fuse3 fd-find ripgrep git jq curl zsh sudo zip tar dumb-init tmux

RUN apt-get install -y \
gcc g++ make bear cmake llvm \
mingw-w64 mingw-w64-tools build-essential \
python3 python3-venv python3-pip \
exuberant-ctags lua-check

#user
RUN useradd -s /usr/bin/zsh -G sudo -m dev
RUN echo "dev ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/dev

ENV APPIMAGE_EXTRACT_AND_RUN=1

#NVIM
RUN curl -Lo /bin/nvim "https://github.com/neovim/neovim/releases/download/`curl https://api.github.com/repos/neovim/neovim/releases/latest | jq -r .tag_name`/nvim-linux-x86_64.appimage"
RUN chmod +x /bin/nvim

#GO
RUN curl -Lo /tmp/go.tar.gz https://golang.org/dl/`curl https://go.dev/VERSION?m=text | grep go`.linux-amd64.tar.gz && \
rm -rf /usr/local/go && \
tar -C /usr/local -xzf /tmp/go.tar.gz && \
rm /tmp/go.tar.gz

#RUST
RUN curl -Lo /tmp/rustup.sh https://sh.rustup.rs && \
chmod +x /tmp/rustup.sh && \
/tmp/rustup.sh -y

COPY entrypoint.sh /home/dev/entrypoint.sh
RUN chmod +x /home/dev/entrypoint.sh
RUN chown dev /home/dev/entrypoint.sh

USER dev
WORKDIR /home/dev
ENV NVM_DIR="/home/dev/.nvm"
ENV GOPATH="/home/dev/.go"
ENV GOROOT="/usr/local/go"
ENV PATH="$PATH:/home/dev/.nvm:$GOROOT/bin:$GOPATH/bin"

RUN mkdir -p /home/dev/.go
RUN mkdir -p /home/dev/.config/nvim/lua/config/
RUN mkdir -p /home/dev/.local/share/nvim/workspaces/
RUN mkdir -p /home/dev/.local/share/nvim/sessions/
RUN chown -R dev:dev /home/dev

COPY zsh-config/zshrc .zshrc
RUN git clone https://github.com/ohmyzsh/ohmyzsh.git .oh-my-zsh

RUN curl -Lo /tmp/nvm.sh https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh && \
chmod +x /tmp/nvm.sh && \
/tmp/nvm.sh
RUN . "$NVM_DIR/nvm.sh" && nvm install 23 && npm install yarn

COPY ./nvim-config/init.lua /home/dev/.config/nvim/init.lua
COPY ./nvim-config/lua/config /home/dev/.config/nvim/lua/config

RUN . "$NVM_DIR/nvm.sh" && nvim --headless -c':Lazy install | sleep 10 | qa'
#RUN . "$NVM_DIR/nvm.sh" && nvim --headless -c':Mason | I | U | sleep 10 | qa'

ENTRYPOINT ["dumb-init", "--"]
CMD ["zsh","-c","/home/dev/entrypoint.sh"]
