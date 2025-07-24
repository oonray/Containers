FROM debian:latest

RUN apt-get update && apt-get install -y openssh-client openssh-server dumb-init
COPY sshd_config /etc/ssh/sshd_config

ENTRYPOINT ["dumb-init","--"]
