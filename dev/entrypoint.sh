#!/usr/bin/zsh
sudo chown -R dev:dev /home/dev &
tmux new-session -d -s dev -t dev -c /home/dev
sleep infinity
