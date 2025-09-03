FROM kalilinux/kali-rolling:latest

ENV USR kali
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

ENV PUID=1000
ENV PGID=1000

COPY --from=golang:latest ${GOROOT} ${GOROOT}
COPY --from=python:latest / /
COPY --from=oonray/tmux:latest / /

RUN apt-get update
RUN apt-get install -y kali-linux-core
RUN apt-get install -y \
mitmproxy net-tools dnsutils netcat-traditional \
proxychains socat nmap \
responder peass netexec

RUN useradd -u 1000 -s /usr/bin/zsh -m $USR
RUN echo "$USR ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/$USR

USER kali
WORKDIR /home/kali

RUN mkdir ~/.config && \
cp $T_CONF ~/.tmux.conf && \
cp $Z_CONF ~/.zshrc && \
cp -r $Z_DIR/.oh-my-zsh ~/.oh-my-zsh && \
cp $C_CONF ~/.config/dircolors

#
#Cleanup
#
USER root
RUN rm -rf /tmp/* && \
chown -R $USR /home/$USR && \
apt-get autoremove && apt-get clean

ENTRYPOINT ["/opt/entrypoint.sh"]
