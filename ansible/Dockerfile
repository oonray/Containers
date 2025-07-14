FROM ubuntu:latest
USER root
RUN apt-get update; \
    apt-get install -y gcc python3 python3-pip software-properties-common dumb-init openssh-client; \
    apt-get clean all

RUN add-apt-repository --yes --update ppa:ansible/ansible
RUN apt-get install -y ansible ansible-lint

COPY start.sh /opt/start.sh
RUN  chmod +x /opt/start.sh

RUN ansible-galaxy collection install ansible.windows community.vmware

ENTRYPOINT ["dumb-init","/opt/start.sh" ]
