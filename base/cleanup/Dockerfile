FROM base AS cleanup
ARG USR
ENV USR=${USR}

USER root
RUN chown -R $USR:$USR /home/$USR \
    && apt-get autoremove \
    && apt-get clean \
    && rm -rf /opt/conf \
    /var/lib/apt/lists/* \
    /tmp/* \
    /var/tmp/* \
    /var/log/*

USER $USR
