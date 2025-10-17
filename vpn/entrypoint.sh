#!/usr/bin/dumb-init /bin/bash

HELP=false
VPN=false
PROXY=false
DNS=false

function help(){
    printf "$(basename $0):\n\t[-h]help\n\t[-v]vpn\n\t[-p]proxy\n\t[-d]dns \n"
    exit 2
}

if [ $# -le 1 ];then help; fi

while getopts "hvpd" opt; do
    case "$opt" in
        v) VPN=true ;;
        p) PROXY=true ;;
        d) DNS=true ;;
        h) ;&
        *) help ;;
    esac
done

if $VPN; then
    if [ -z $VPN_F ]; then
        echo 'VPN file not set' >&2
        exit 1
    fi
    if [ ! -s $VPN_F ]; then
        echo "$VPN_F not found" >&2
        exit 1
    fi
    supervisorctl start vpn
fi

if $PROXY; then
    if [ -z $DANTE_F ]; then
        echo 'proxy file not set' >&2
        exit 1
    fi
    if [ ! -s $DANTE_F ]; then
        echo "$DANTE_F not found" >&2
        exit 1
    fi

    supervisorctl start proxy
fi

if $DNS; then
    if [ -z $DNS_F ]; then
        echo 'dns file not set' >&2
        exit 1
    fi
    if [ ! -s $DNS_F ]; then
        echo "$DNS_F not found" >&2
        exit 1
    fi

    supervisorctl start dns
fi
