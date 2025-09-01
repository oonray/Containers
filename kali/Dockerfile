FROM kalilinux/kali-rolling:latest

RUN apt-get update
RUN apt-get install -y kali-linux-headless
RUN apt-get install -y \
curl mitmproxy tmux dumb-init \
python3 python3-pip \
net-tools dnsutils netcat-traditional \
proxychains socat nmap \
git jq sudo zip tar \
responder peass netexec

RUN usermod --shell /usr/bin/zsh root
RUN useradd -u 1000 -s /usr/bin/zsh -m kali
RUN echo "kali ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/kali

USER kali
WORKDIR /home/kali

FROM oonray/tmux:latest
RUN cp ${T_CONF} ~/.tmux.conf && \
cp ${Z_CONF} ~/.zshrc && \
cp -r ${Z_DIR}/.oh-my-zsh ~/.oh-my-zsh && \
cp ${C_CONF} ~/.config/dircolors

ENV PUID=1000
ENV PGID=1000

ENTRYPOINT [ "dumb-init", "--" ]
CMD [ "sleep","infinity" ]
