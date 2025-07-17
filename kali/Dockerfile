FROM kalilinux/kali-rolling:latest

RUN apt-get update
RUN apt-get install -y \
curl mitmproxy tmux \
python3 python3-pip dumb-init net-tools dnsutils netcat-traditional nmap \
git jq curl zsh sudo zip tar

RUN usermod --shell /usr/bin/zsh root

WORKDIR /root
COPY zsh-config/zshrc .zshrc
COPY tmux-config/tmux.conf .tmux.conf

WORKDIR /root
