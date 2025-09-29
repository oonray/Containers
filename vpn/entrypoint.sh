#!/usr/bin/dumb-init /bin/bash
if [ -s $VPN_F ]; then
    /usr/sbin/openvpn --config $VPN_F --daemon &
else
    echo "no vpn.ovpn in ${VPN_DIR}"
fi

if [ -s $DANTE_CONF ]; then
    service danted start
else
    echo "${DANTE_CONF} not found"
fi

fg
