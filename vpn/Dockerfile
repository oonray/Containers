FROM ubunut:latest

RUN apt-get update
RUN apt-get install -y \
openvpn dnsutils net-tools proxychains dumb-init \
socat netcat-traditional nmap \
dante-server iproute2 vim

RUN mkdir /opt/dante/

COPY danted.conf /opt/dante/danted.conf

COPY entrypoint.sh /opt/entrypoint.sh
RUN chmod +x /opt/entrypoint.sh

ENV VPNDIR=/opt/vpn
ENV VPNF=${VPNDIR}/vpn.ovpn

ENV DANTECFG=/etc/danted.conf
ENV DANCFG=/opt/dante/danted.conf
ENV DANPID=/run/danted.pid
ENV WORKERS=3


ENTRYPOINT ["/opt/entrypoint.sh"]
CMD ["sleep","infinity"]
