FROM kalilinux/kali-rolling:latest

RUN apt-get update
RUN apt-get install -y \
curl mitmproxy tmux dumb-init \
kali-linux-headless \
python3 python3-pip \
net-tools dnsutils netcat-traditional proxychains socat nmap \
git jq curl zsh sudo zip tar \
mitmproxy responder peass

RUN usermod --shell /usr/bin/zsh root
RUN useradd -u 1000 -s /usr/bin/zsh -m kali
RUN echo "dev ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/kali

USER kali
WORKDIR /home/kali
COPY zsh-config/zshrc .zshrc
COPY tmux-config/tmux.conf .tmux.conf
COPY dircolors ~/.config/dircolors

ENTRYPOINT [ "dumb-init", "--" ]
CMD [ "sleep","infinity" ]
