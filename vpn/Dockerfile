FROM golang
ENV GOPATH=/go
WORKDIR /go

RUN apt-get update
RUN apt-get install -y openvpn dnsutils net-tools proxychains nginx
RUN apt-get install -y socat mitmproxy tmux neovim
RUN apt-get install -y dante-server wireguard iptables wireguard-tools coredns 
COPY danted.conf /etc/danted.conf

RUN ip link add dev wg0 type wireguard
RUN ip address add dev wg0 192.168.2.1/24
RUN ip address add dev wg0 192.168.2.1 peer 192.168.2.2

COPY entrypoint.sh /opt/entrypoint.sh
RUN chmod +x /opt/entrypoint.sh

WORKDIR /go/bin
CMD ["/bin/bash","-c","/opt/entrypoint.sh"]
