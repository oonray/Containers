FROM golang:latest
FROM python:latest
FROM oonray/ssh:latest
FROM oonray/tmux:latest
FROM kalilinux/kali-rolling:latest

ENV GOPATH="/home/kali/.go"
ENV GOROOT="/usr/local/go"
ENV PATH="$PATH:$GOROOT/bin:$GOPATH/bin"

ENV CONF_DIR /opt/conf
ENV T_DIR ${CONF_DIR}/tmux
ENV T_CONF /opt/conf/tmux/tmux.conf

ENV Z_DIR ${CONF_DIR}/zsh
ENV Z_CONF ${Z_DIR}/zshrc

ENV C_DIR ${CONF_DIR}/dircolors
ENV C_CONF ${C_DIR}/dircolors

ENV PUID=1000
ENV PGID=1000

RUN apt-get update
RUN apt-get install -y kali-linux-headless
RUN apt-get install -y \
mitmproxy net-tools dnsutils netcat-traditional \
proxychains socat nmap \
responder peass netexec

RUN usermod --shell /usr/bin/zsh root
RUN useradd -u 1000 -s /usr/bin/zsh -m kali
RUN echo "kali ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/kali

USER kali
WORKDIR /home/kali

RUN cp $T_CONF ~/.tmux.conf && \
cp $Z_CONF ~/.zshrc && \
cp -r $Z_DIR/.oh-my-zsh ~/.oh-my-zsh && \
cp $C_CONF ~/.config/dircolors

ENV PUID=1000
ENV PGID=1000

ENTRYPOINT ["/opt/entrypoint.sh"]
