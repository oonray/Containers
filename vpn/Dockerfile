FROM golang:latest AS coredns
RUN git clone https://github.com/coredns/coredns /tmp/coredns
WORKDIR /tmp/coredns
RUN apt-get update \
    && apt-get install make \
    && make

FROM debian:trixie-slim
ENV DEBIAN_FRONTEND=noninteractive

ARG VERSION="1.0.0"
ENV VERSION="$VERSION"

LABEL version="${VERSION}"
LABEL org.opencontainers.image.version="${VERSION}"
LABEL org.opencontainers.image.title=vpn

ARG CONF_DIR=/opt/conf
ENV CONF_DIR=${CONF_DIR}

ENV VPN_DIR=${CONF_DIR}/vpn
ENV VPN_F=${VPN_DIR}/vpn.ovpn

ENV DANTE_DIR=${CONF_DIR}/dante
ENV DANTE_F=${DANTE_DIR}/danted.conf

ENV DNS_DIR=${CONF_DIR}/dns
ENV DNS_F=${DNS_DIR}/Corefile

RUN apt-get update \
    && apt-get -y upgrade \
    && apt-get -y install \
        dumb-init coreutils sipcalc jq \
        dnsutils net-tools curl vim nmap \
        proxychains socat netcat-traditional iproute2 \
        traceroute tcpdump iputils-ping \
        network-manager-openvpn openvpn

RUN apt-get install -y dante-server

COPY supervisord.conf /etc/supervisord.conf
COPY entrypoint.sh /opt/entrypoint.sh
COPY --from=coredns /tmp/coredns/coredns /usr/bin/coredns

RUN chmod +x /opt/entrypoint.sh

RUN mkdir -p ${CONF_DIR} \
&& mkdir -p ${VPN_DIR} \
&& mkdir -p ${DANTE_DIR} \
&& mkdir -p ${DNS_DIR}

EXPOSE 1080/tcp
EXPOSE 9001/tcp
EXPOSE 53/udp

ENTRYPOINT ["/opt/entrypoint.sh"]
