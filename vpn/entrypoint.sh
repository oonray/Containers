#!/usr/bin/dumb-init /bin/bash

declare -A help
help["cflag"]="h"
help["sflag"]="[-h]help"
help["func"]="help_func"
help["needs"]=""

declare -A vpn
vpn["cflag"]="v"
vpn["sflag"]="[-v]vpn"
vpn["func"]="vpn_func"
vpn["needs"]="$VPN_F"

declare -A proxy
proxy["cflag"]="p"
proxy["sflag"]="[-p]proxy"
proxy["func"]="proxy_func"
proxy["needs"]="$DANTE_F"

declare -A dns
dns["cflag"]="d"
dns["sflag"]="[-d]dns"
dns["func"]="dns_func"
dns["needs"]="$DNS_F"

function help_func()
{
    echo "USAGE: $(basename $0)"
    echo ${help[sflag]}
    echo ${vpn[sflag]}
    echo ${proxy[sflag]}
    echo ${dns[sflag]}
    exit 2
}

if (( $# < 1 ))
then
    eval "${help[func]}"
fi


function vpn_func(){
    if [ -z ${vpn["needs"]} ]; then
        echo 'VPN file not set' >&2
        exit 1
    fi
    if [ ! -s ${vpn["needs"]} ]; then
        echo "${vpn["needs"]} not found" >&2
        exit 1
    fi
    supervisorctl start vpn
}

function dns_func(){
    if [ -z ${dns["needs"]} ]; then
        echo 'dns file not set' >&2
        exit 1
    fi
    if [ ! -s ${dns["needs"]} ]; then
        echo "${dns["needs"]} not found" >&2
        exit 1
    fi

    supervisorctl start dns
}

function proxy_func(){
    if [ -z ${proxy["needs"]} ]; then
        echo 'proxy file not set' >&2
        exit 1
    fi
    if [ ! -s ${proxy["needs"]} ]; then
        echo "${proxy["needs"]} not found" >&2
        exit 1
    fi

    supervisorctl start proxy
}

flag_s="${help[cflag]}${vpn[cflag]}${proxy[cflag]}${dns[cflag]}a"
while getopts $flag_s opt; do
    case "$opt" in
        v) eval ${vpn[func]} ;;
        p) eval ${proxy[func]} ;;
        d) eval ${dns[func]} ;;
        d) supervisorctl start all ;;
        h) ;&
        *) eval ${help[func]};;
    esac
done
