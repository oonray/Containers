#!/usr/bin/dumb-init /bin/zsh
/usr/sbin/sshd -D
cd /home/dev/git && tmux new -t dev
sleep infinity #never die unless killed
