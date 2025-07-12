FROM golang
ENV GOPATH=/go
WORKDIR /go

RUN apt-get update
RUN apt-get install -y \
openvpn dnsutils net-tools proxychains nginx dumb-init \
socat mitmproxy tmux neovim \
dante-server wireguard iptables wireguard-tools

COPY danted.conf /etc/danted.conf

COPY entrypoint.sh /opt/entrypoint.sh
RUN chmod +x /opt/entrypoint.sh

WORKDIR /go/bin
CMD ["/bin/bash","-c","/opt/entrypoint.sh"]
