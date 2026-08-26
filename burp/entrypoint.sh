#!/usr/bin/dumb-init /bin/bash

function help()
{
    echo "USAGE: $(basename $0)"
    echo "  [-m]mitmproxy"
    exit 2
}

if [ $# -le 0 ]
then
    help
fi

PROXY=false

while getopts "hs" opt; do
    case "$opt" in
        s) PROXY=true ;;
        h) ;&
        *) eval ${help[func]};;
    esac
done

if $PROXY; then
    mitmweb --no-web-open-browser  \
    --web-host 0.0.0.0  \
    --web-port $PORT
fi
