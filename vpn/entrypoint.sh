#!/usr/bin/dumb-init /bin/bash
set -xe

export VPN_DEV=$(cat /opt/vpn/| grep dev | awk '{print $2}')
export DANTED_CONF=/etc/danted/danted.conf

if [ -s $VPNF ] then
    openvpn $VPNF --dev "${VPN_DEV}0" &
    cat $DANCFG | sed 's/external:.*/external: ${VPN_DEV}0/g' | tee $DANTED_CONF
else
    cp $DANCFG | tee $DANTED_CONF
fi
#sockd -f $DANTED_CONF -p $DPID -N $DWORKERS &
disown -r
