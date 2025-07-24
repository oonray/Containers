#!/usr/bin/dumb-init /bin/bash
set -x

export VPN_DEV=$(cat $VPNF | grep dev | awk '{print $2}')

cat $DANCFG | tee $DANTECFG

if [ -s $VPNF ]; then
    /usr/sbin/openvpn $VPNF --dev "${VPN_DEV}0" || true &
    cat $DANCFG | sed 's/external:.*/external: ${VPN_DEV}0/g' | tee $DANTECFG
fi

service danted start || true
disown -r
sleep infinity
