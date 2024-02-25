FROM kalilinux/kali-rolling:latest

RUN apt-get update 

RUN apt-get install -y nmap git curl  

RUN apt-get install -y \
    python3 python3-pip python2 pass ruby openssh-server \
    zsh zsh-syntax-highlighting zsh-autosuggestions \
    exploitdb radare2 gobuster ffuf smbmap sqlmap 

RUN apt-get install -y nmap \
    crackmapexec torsocks proxychains socat tmux \
    enum4linux smbclient recon-ng beef-xss \
    bat locate sshpass john hashcat neovim

RUN cp /etc/skel/.zshrc /root/ &&\
    chsh -s /bin/zsh

WORKDIR /root
