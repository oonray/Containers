#burp
FROM oonray/kali:user
ENV DEBIAN_FRONTEND=noninteractive

ENV DISPLAY=1
ENV SCREEN=0
ENV DISPLAY_WIDTH=1024
ENV DISPLAY_HEIGHT=768

ENV STORAGE="/home/${USR}/storage"

ARG VERSION="0.1.0"
ENV VERSION="$VERSION"

LABEL version="${VERSION}"
LABEL org.opencontainers.image.version="${VERSION}"
LABEL org.opencontainers.image.title=burp

USER root
RUN apt-get update \
    && apt-get install -y dumb-init supervisor \
    mimproxy burpsuite compton \
    xfvb x11-vnc kali-desktop-xfce

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY entrypoint.sh /opt/entrypoint.sh
RUN chmod +x /opt/entrypoint.sh

USER ${USR}

EXPOSE 6001
EXPOSE 8080
VOLUME [${STORAGE}]
ENTRYPOINT ["/opt/entrypoint.sh"]
