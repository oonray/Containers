#!/usr/bin/dumb-init /bin/bash
set -x

export VPN_DEV=$(cat $VPNF | grep dev | awk '{print $2}')

if [ -s $VPNF ]; then
    /usr/sbin/openvpn $VPNF &
fi

if [ -s $DANTECFG ]; then
    service danted start
fi

while true
do
    if read line <$pipe; then
        echo $line
    else
        sleep 1
    fi
done
