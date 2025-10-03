#burp
FROM oonray/kali:user

RUN apt-get update \
    && apt-get install -y dumb-init \
    mimproxy burpsuite \
    xfvb x11-vnc kali-desktop-i3

COPY entrypoint.sh /opt/entrypoint.sh
RUN chmod +x /opt/entrypoint.sh

ENTRYPOINT ["/opt/entrypoint.sh"]
