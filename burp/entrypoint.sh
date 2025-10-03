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

while getopts "vdph" opt; do
    case "$opt" in
        v) vpn;;
        d) dns;;
        p) proxy;;
        h) help;;
        *) brief;;
    esac
done
