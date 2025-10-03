#burp
FROM oonray/kali:user

ARG VERSION="0.1.0"
ENV VERSION="$VERSION"
ENV NAME="Burp"

LABEL version="${VERSION}"
LABEL org.opencontainers.image.version="${VERSION}"
LABEL org.opencontainers.image.title=${NAME}

RUN apt-get update \
    && apt-get install -y dumb-init \
    mimproxy burpsuite \
    xfvb x11-vnc kali-desktop-i3

COPY entrypoint.sh /opt/entrypoint.sh
RUN chmod +x /opt/entrypoint.sh

VOLUME ["/home/kali/storage"]
ENTRYPOINT ["/opt/entrypoint.sh"]
