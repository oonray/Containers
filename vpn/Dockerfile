FROM ubuntu:latest

ARG CONF_DIR=/opt/conf
ENV CONF_DIR=${CONF_DIR}

ENV VPN_DIR=${CONF_DIR}/vpn
ENV VPN_F=${VPN_DIR}/vpn.ovpn
ENV DANTE_CONF=/etc/danted.conf

RUN apt-get update \
    && apt-get install -y dumb-init \
                openvpn dnsutils net-tools curl vim \
                proxychains socat netcat-traditional iproute2 \
                dante-server nmap traceroute tcpdump

COPY entrypoint.sh /opt/entrypoint.sh
RUN chmod +x /opt/entrypoint.sh

RUN mkdir -p ${CONF_DIR}

ENTRYPOINT ["/opt/entrypoint.sh"]
