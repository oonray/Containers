#burp
FROM oonray/kali:user
ENV DEBIAN_FRONTEND=noninteractive

ARG DISPLAY_NUMBER=1
ENV DISPLAY=:${DISPLAY_NUMBER}
ENV SCREEN=0

ARG DISPLAY_WIDTH=1024
ENV DISPLAY_WIDTH=${DISPLAY_WIDTH}

ARG DISPLAY_HEIGHT=768
ENV DISPLAY_HEIGHT=${DISPLAY_HEIGHT}}

ENV STORAGE="/home/${USR}/storage"

ARG VERSION="0.1.1"
ENV VERSION="$VERSION"

LABEL version="${VERSION}"
LABEL org.opencontainers.image.version="${VERSION}"
LABEL org.opencontainers.image.title=burp

USER root
RUN apt-get update \
    && apt-get install -y dumb-init supervisor \
    mitmproxy burpsuite compton \
    xvfb xfce4 xfce4-goodies dbus-x11

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY entrypoint.sh /opt/entrypoint.sh
RUN chmod +x /opt/entrypoint.sh

USER ${USR}

EXPOSE 6001
EXPOSE 8080

VOLUME [${STORAGE}]
ENTRYPOINT ["/opt/entrypoint.sh"]
