FROM base as node
ARG USR
ENV USR=${USR}
USER ${USR}

#Install NODE
ENV NVM_DIR="/home/$USR/.nvm"
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash \
    && [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" \
    && nvm install 23 \
    && npm install yarn
