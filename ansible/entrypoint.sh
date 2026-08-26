#!/usr/bin/dumb-init /bin/bash
if [ -d "/opt/ssh" ]; then
    cp /opt/ssh/* ~/.ssh
    chmod 400 ~/.ssh/id_rsa
    eval `ssh-agent -s`
    ssh-agent
    ssh-add ~/.ssh/id_rsa
fi
service start sshd
sleep infinity
