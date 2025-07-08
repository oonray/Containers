FROM ubuntu:latest

USER oonray

RUN sudo apt-get update \
&& sudo apt-get upgrade -y
RUN sudo apt-get install -y \
fuse3 fd-find gcc g++ make bear \
cmake exuberant-ctags llvm ripgrep \
python3 python3-venv python3-pip \
jq

RUN curl https://api.github.com/repos/neovim/neovim/releases/latest
