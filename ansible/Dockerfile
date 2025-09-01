FROM oonray/ssh:latest

USER root

RUN apt-get update && \
    apt-get install -y gcc python3 python3-pip pipx python3-venv \
    software-properties-common dumb-init && \
    apt-get clean all

RUN add-apt-repository --yes --update ppa:ansible/ansible && \
apt-get install -y ansible ansible-lint

RUN useradd -u 1000 -s /usr/bin/zsh -m ansible

COPY entrypoint.sh /opt/entrypoint.sh
RUN  chmod +x /opt/entrypoint.sh

RUN ansible-galaxy collection install ansible.windows community.vmware

ENTRYPOINT ["/opt/entrypoint.sh" ]
