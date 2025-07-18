#!/usr/bin/dumb-init /bin/bash
cp /opt/dante/proxy_danted.conf /etc/danted.conf

[ -s "/opt/vpn/vpn.ovpn" ] && cp /opt/dante/vpn_danted.conf /etc/danted.conf
[ -s "/etc/danted.conf" ] && service start danted
[ -s "/opt/vpn/vpn.ovpn" ] && openvpn /opt/vpn/vpn.ovpn #&
#disown -r
