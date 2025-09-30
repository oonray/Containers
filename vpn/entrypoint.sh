#!/usr/bin/dumb-init /bin/bash
if (( $# < 1 ))
then
    echo "USAGE: $(basename $0) [--vpn] [--proxy] [--dns]"
    exit 2
fi

function brief(){
    echo "USAGE: $(basename $0) [--vpn] [--proxy] [--dns]"
    exit 2
}

function help(){
    echo "USAGE: $(basename $0)
    [-h] help
    [-v] vpn (needs $VPN_F)
    [-p] proxy (nees $DANTE_CONF)
    [-d] dns (needs $DNS_F)"
    exit 2
}

function vpn(){
    if [ -s $VPN_F ]; then
        echo "Using $VPN_F"
        /usr/sbin/openvpn --config $VPN_F --daemon &
    else
        echo "${VPN_F} not found" >&2
        exit 1
    fi
}

function dns(){
    echo "not implemented!" >&2
    exit 1
    if [ ! -s $DNS_F ]; then
        echo "Using $DNS_F"
        coredns &
    else
        echo "${DNS_F} not found"
        exit 1
    fi
}

function proxy(){
    if [ -s $DANTE_CONF ]; then
        echo "Using ${DANTE_CONF}"
        service danted start
    else
        echo "${DANTE_CONF} not found"
        exit 1
    fi
}

while getopts "vdph" opt; do
    case "$opt" in
        v) vpn;;
        d) dns;;
        p) proxy;;
        h) help;;
        *) brief;;
    esac
done
