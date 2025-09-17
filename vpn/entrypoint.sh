#!/usr/bin/dumb-init /bin/bash
set -x

if [ -s $DANTE_CONF ]; then
    service danted start
else
    echo "${DANTE_CONF} not found"
fi

if [ -s $VPN_F ]; then
    /usr/sbin/openvpn --config $VPN_F --daemon
else
    echo "no vpn.ovpn in ${VPN_DIR}"
    sleep infinity
fi
