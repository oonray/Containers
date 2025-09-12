FROM base AS mimtproxy

RUN apt-get update \
&& apt-get install -y mitmproxy

ENTRYPOINT ["dumb-init","--"]

CMD ["mitmweb","--no-web-open-browser", \
"--web-host","0.0.0.0", \
"--web-port","8080"]
