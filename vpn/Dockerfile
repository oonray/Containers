#vpn
FROM golang:latest as coredns
ADD https://github.com/coredns/coredns /tmp/coredns
WORKDIR /tmp/coredns
RUN go get \
    && go build

FROM ubuntu:latest

ARG CONF_DIR=/opt/conf
ENV CONF_DIR=${CONF_DIR}

ENV VPN_DIR=${CONF_DIR}/vpn
ENV VPN_F=${VPN_DIR}/vpn.ovpn
ENV DANTE_CONF=/etc/danted.conf

ENV DNS_DIR=${CONF_DIR}/dns
ENV DNS_F=${DNS_DIR}/Corefile

RUN apt-get update \
    && apt-get install -y dumb-init coreutils sipcalc jq \
                dnsutils net-tools curl vim nmap \
                proxychains socat netcat-traditional iproute2 \
                dante-server raceroute tcpdump iputils-ping \
                network-manager-openvpn openvpn

COPY entrypoint.sh /opt/entrypoint.sh
COPY --from=coredns /tmp/coredns/coredns /usr/bin/coredns

RUN chmod +x /opt/entrypoint.sh

RUN mkdir -p ${CONF_DIR}
ENTRYPOINT ["/opt/entrypoint.sh"]
