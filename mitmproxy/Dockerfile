FROM oonray/tmux:latest AS tmux
FROM kalilinux/kali-rolling:latest

ENV APPIMAGE_EXTRACT_AND_RUN=1

ENV USR=kali
ENV GOROOT="/usr/local/go"
ENV CONF_DIR="/opt/conf"
ENV T_CONF="$CONF_DIR/tmux/tmux.conf"
ENV Z_CONF="$CONF_DIR/zsh/zshrc"
ENV C_CONF="$CONF_DIR/colors/dircolors"

COPY --from=golang:latest ${GOROOT} ${GOROOT}

RUN apt-get update && apt-get install -y dumb-init \
tmux tmuxinator zsh git jq curl sudo zip tar \
python3 python3-pip python3-venv \
python3-impacket python3-scapy \
mitmproxy

RUN useradd -u 1000 -s /usr/bin/zsh -m $USR
USER kali
WORKDIR /home/kali
RUN mkdir -p ~/.config

COPY --from=tmux --chown=kali:kali ${T_CONF} ~/.tmux.conf
COPY --from=tmux --chown=kali:kali ${Z_CONF} ~/.zshrc
COPY --from=tmux --chown=kali:kali ${CONF_DIR}/zsh/.oh-my-zsh ~/.oh-my-zsh
COPY --from=tmux --chown=kali:kali $C_CONF ~/.config/dircolors

ENV PUID=1000
ENV PGID=1000

ENTRYPOINT ["dumb-init","--"]

CMD ["mitmweb","--no-web-open-browser", \
"--web-host","0.0.0.0", \
"--web-port","8080"]
