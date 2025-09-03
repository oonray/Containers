FROM oonray/ssh:latest

RUN apt-get update && \
apt-get install -y tmux tmuxinator zsh git jq curl sudo zip tar dumb-init 

ENV GOPATH="/home/$USR/.go"
ENV GOROOT="/usr/local/go"
ENV PATH="$PATH:$GOROOT/bin:$GOPATH/bin"

ENV CONF_DIR="/opt/conf"
ENV T_DIR="$CONF_DIR/tmux"
ENV T_CONF="$CONF_DIR/tmux/tmux.conf"

ENV Z_DIR="$CONF_DIR/zsh"
ENV Z_CONF="$Z_DIR/zshrc"

ENV C_DIR="$CONF_DIR/colors"
ENV C_CONF="$C_DIR/dircolors"


RUN mkdir -p $CONF_DIR && \
mkdir -p $T_DIR && \
mkdir -p $Z_DIR && \
mkdir -p $C_DIR

RUN mkdir -p /opt/conf/tmux
COPY tmux.conf /opt/conf/tmux/tmux.conf
COPY zshrc /opt/conf/zsh/zshrc
RUN git clone https://github.com/ohmyzsh/ohmyzsh.git $Z_DIR/.oh-my-zsh
COPY dircolors /opt/conf/colors/dircolors

RUN chmod -R 0755 /opt/conf

RUN curl -Lo /tmp/bat.deb https://github.com/sharkdp/bat/releases/download/v0.25.0/bat_0.25.0_amd64.deb && \
apt install -y /tmp/bat.deb && \
rm /tmp/bat.deb
