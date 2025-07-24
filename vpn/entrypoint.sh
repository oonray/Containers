#!/usr/bin/dumb-init /bin/bash
set -x

export VPN_DEV=$(cat /opt/vpn/| grep dev | awk '{print $2}')
export DANTED_CONF=/etc/danted/danted.conf

if [ -s $VPNF ] then
    openvpn $VPNF --dev "${VPN_DEV}0" || True &
    cat $DANCFG | sed 's/external:.*/external: ${VPN_DEV}0/g' | tee $DANTED_CONF || True
else
    cp $DANCFG | tee $DANTED_CONF || True
fi
sockd -f $DANTED_CONF -p $DPID -N $DWORKERS || True &
disown -r
