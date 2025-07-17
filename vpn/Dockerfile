FROM debian:latest

RUN apt-get update
RUN apt-get install -y \
openvpn dnsutils net-tools proxychains dumb-init \
socat mitmproxy netcat-traditional nmap tmux \
dante-server wireguard wireguard-tools iptables

RUN mkdir /opt/vpn/
RUN mkdir /opt/dante/

COPY vpn_danted.conf /opt/dante/vpn_danted.conf
COPY proxy_danted.conf /opt/dante/proxy_danted.conf

COPY entrypoint.sh /opt/entrypoint.sh
RUN chmod +x /opt/entrypoint.sh

ENTRYPOINT ["/opt/entrypoint.sh"]
CMD ["sleep","infinity"]
