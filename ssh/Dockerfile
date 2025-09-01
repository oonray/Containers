FROM debian:latest

RUN apt-get update \
&& apt-get install -y openssh-client openssh-server dumb-init ssh-import-id

RUN mkdir /opt/ssh && chmod 0755 /opt/ssh
COPY sshd_config /etc/ssh/sshd_config
RUN ssh-import-id gh:oonray

COPY entrypoint.sh /opt/entrypoint.sh
RUN chmod +x /opt/entrypoint.sh

EXPOSE 22

