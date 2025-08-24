#!/usr/bin/dumb-init /bin/bash
set -x

if [ -s $VPNF ]; then
    /usr/sbin/openvpn $VPNF --dev "${VPN_DEV}0" > $OPIPE &
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
