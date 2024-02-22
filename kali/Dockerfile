FROM kalilinux/kali-rolling:latest

RUN apt-get update && \
    apt-get upgrade -y

RUN apt-get install -y nmap \
    netcat-traditional \
    git nginx curl wget \
    golang gcc apt-transport-https \
    python3 python3-pip python2 pass ruby openssh-server \
    zsh zsh-syntax-highlighting zsh-autosuggestions \
    exploitdb radare2 gobuster ffuf smbmap sqlmap \
    crackmapexec torsocks proxychains socat tmux \
    enum4linux smbclient recon-ng beef-xss \
    bat locate sshpass john hashcat neovim

RUN cp /etc/skel/.zshrc /root/ &&\
    chsh -s /bin/zsh

RUN mkdir /opt/git
WORKDIR /opt/git
RUN git clone --recurse https://github.com/leostat/rtfm.git

WORKDIR /root
