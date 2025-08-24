FROM debian:latest

RUN apt-get update && apt-get upgrade
RUN apt-get install -y dumb-init openvpn dnsutils net-tools
RUN apt-get install -y proxychains socat netcat-traditional iproute2
RUN apt-get install -y dante-server

COPY entrypoint.sh /opt/entrypoint.sh
RUN chmod +x /opt/entrypoint.sh

ENV VPNDIR=/opt/vpn
ENV VPNF=${VPNDIR}/vpn.ovpn

ENV DANTECFG=/etc/danted.conf
ENV OPIPE=/tmp/output

ENTRYPOINT ["/opt/entrypoint.sh"]
CMD ["sleep","infinity"]
