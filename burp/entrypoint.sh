#!/usr/bin/dumb-init /bin/bash

declare -A help
help["cflag"]="h"
help["sflag"]="[-h]help"
help["func"]="help_func"
help["needs"]=""

declare -A mitm
help["cflag"]="m"
help["sflag"]="[-m]mimtpwoxy"
help["func"]="mitm_func"
help["needs"]=""

function help_func()
{
    echo "USAGE: $(basename $0)"
    echo ${help[sflag]}
    exit 2
}


if (( $# < 1 ))
then
    eval "${help[func]}"
fi

flag_s="${help[cflag]}"

function mitm_func(){
mitmweb --no-web-open-browser  \
--web-host 0.0.0.0  \
--web-port 8080
}

while getopts $flag_s opt; do
    case "$opt" in
        h) ;&
        *) eval ${help[func]};;
    esac
done
