ARG IMAGE=debian
ARG GH_USR=evilginx
ARG USR=${GH_USR}
ARG ENTRY=/opt/entrypoint.sh
ARG B_VER=0.25.0
ARG ARCH=trixie-slim
ARG PUID=999
ARG PGID=999

FROM oonray/debian:latest

#Install NODE
ENV NVM_DIR="/home/$USR/.nvm"
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash \
    && [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" \
    && nvm install 23 \
    && npm install yarn

COPY entrypoint.sh /opt/entrypoint.sh
ENTRYPOINT ["/opt/entrypoint.sh"]
