FROM debian:latest

RUN apt-get update && \
apt-get install -y \
openvpn dnsutils net-tools proxychains dumb-init \
socat netcat-traditional nmap \
dante-server

RUN mkdir /opt/dante/

COPY danted.conf /opt/dante/danted.conf

COPY entrypoint.sh /opt/entrypoint.sh
RUN chmod +x /opt/entrypoint.sh

ENV VPNDIR=/opt/vpn
ENV VPNF=${VPNDIR}/vpn.ovpn

ENV DANCFG=/opt/dante/dated.conf
ENV DANPID=/run/danted.pid
ENV WORKERS=3


ENTRYPOINT ["/opt/entrypoint.sh"]
CMD ["sleep","infinity"]
