FROM ubuntu:latest

RUN apt-get update
RUN apt-get install -y dumb-init openvpn dnsutils net-tools curl vim
RUN apt-get install -y proxychains socat netcat-traditional iproute2
RUN apt-get install -y dante-server

COPY entrypoint.sh /opt/entrypoint.sh
RUN chmod +x /opt/entrypoint.sh

ENV CONF_DIR /opt/conf
RUN mkdir -p ${CONF_DIR}

ENV VPN_DIR=${CONF_DIR}/vpn
ENV VPN_F=${VPN_DIR}/vpn.ovpn

ENV DANTE_CONF=/etc/danted.conf

ENTRYPOINT ["/opt/entrypoint.sh"]
