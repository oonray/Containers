FROM ubuntu:latest
USER root
RUN apt-get update && \
    apt-get install -y gcc python3 python3-pip software-properties-common dumb-init openssh-client && \
    apt-get clean all

RUN add-apt-repository --yes --update ppa:ansible/ansible && \
apt-get install -y ansible ansible-lint

RUN useradd -u 1000 -s /usr/bin/zsh -m ansible

COPY start.sh /opt/start.sh
RUN  chmod +x /opt/start.sh

RUN ansible-galaxy collection install ansible.windows community.vmware

ENTRYPOINT ["/opt/entrypoint.sh" ]
