#!/usr/bin/dumb-init /bin/bash
cp /opt/dante/proxy_danted.conf /etc/danted.conf

export DCONF=/opt/dante/proxy_danted.conf
export DWORKERS=3
export DPID=/run/dante.pid

[ -s "/opt/vpn/vpn.ovpn" ] && export DCONF=/opt/dante/vpn_danted.conf
[ -s "/etc/danted.conf" ] && sockd -f $DCONF -p $DPID -N $DWORKERS
[ -s "/opt/vpn/vpn.ovpn" ] && openvpn /opt/vpn/vpn.ovpn #&
#disown -r
