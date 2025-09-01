#!/usr/bin/dumb-init /usr/bin/zsh
ssh-import-id gh:oonray
service start sshd
sleep infinity #never die unless killed
