FROM base AS mimtproxy
ARG USR
ENV USR=${USR}
ENV DEBIAN_FRONTEND=noninteractive

ARG VERSION="0.1.0"
ENV VERSION="$VERSION"

LABEL version="${VERSION}"
LABEL org.opencontainers.image.version="${VERSION}"
LABEL org.opencontainers.image.title=mitmproxy

USER root
RUN apt-get update \
&& apt-get install -y mitmproxy


USER ${USR}

EXPOSE 8080
COPY supervisord.conf /etc/supervisor.d/mitmproxy.conf
ENTRYPOINT ["dumb-init","--"]
CMD ["supervisorctl", "start","mitmproxy"]

