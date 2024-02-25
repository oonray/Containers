FROM kalilinux/kali-rolling:latest

RUN apt-get update

RUN apt-get install -y nmap curl gobuster

RUN cp /etc/skel/.zshrc /root/ &&\
    chsh -s /bin/zsh

WORKDIR /root
