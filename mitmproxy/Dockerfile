FROM base AS mimtproxy
ARG USR
ENV USR=${USR}

USER root
RUN apt-get update \
&& apt-get install -y mitmproxy

USER ${USR}

ENTRYPOINT ["dumb-init","--"]

CMD ["mitmweb","--no-web-open-browser", \
"--web-host","0.0.0.0", \
"--web-port","8080"]
