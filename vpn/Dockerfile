FROM debian:latest

RUN apt-get update
RUN apt-get install -y \
openvpn dnsutils net-tools proxychains dumb-init \
socat netcat-traditional nmap \
iproute2 vim
RUN apt-get install -y dante-server

COPY entrypoint.sh /opt/entrypoint.sh
RUN chmod +x /opt/entrypoint.sh

ENV VPNDIR=/opt/vpn
ENV VPNF=${VPNDIR}/vpn.ovpn

ENV DANTECFG=/etc/danted.conf
ENV OPIPE=/tmp/output

ENTRYPOINT ["/opt/entrypoint.sh"]
CMD ["sleep","infinity"]
