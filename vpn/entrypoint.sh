#!/bin/bash
wg genkey | tee /root/privatekey | wg pubkey > /root/publickey
wg set wg0 listen-port 51820 private-key /root/privatekey peer $2 allowed-ips $1
ip link set up dev wg0
openvpn /root/.vpn.opvn
service danted start
