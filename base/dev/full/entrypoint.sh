#!/usr/bin/dumb-init /usr/bin/zsh
ssh-import-id gh:oonray
service start sshd
#nvim --listen $L_HOST:$L_PORT --headless /home/$USR/.git
