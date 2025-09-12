FROM golang:latest AS build

ENV GOROOT="/usr/local/go"
ENV B_DIR="/opt/bin"
ENV GOBIN="$B_DIR"
ENV G_DIR="/opt/git"
ENV GOPATH="$E_DIR"
ENV E_BIN="$B_DIR/evilginx3"
ENV E_GIT="$G_DIR/evilginx3"
ENV E_DIR="/opt/evilginx"

RUN mkdir $G_DIR \
    && mkdir $B_DIR \
    && git clone https://github.com/kgretzky/evilginx2.git $E_DIR

WORKDIR $E_DIR
RUN go build -o $E_BIN -mod=vendor main.go \
    && chmod 755 $E_BIN

FROM base as evilginx
ARG USR
ENV USR=${USR}

ENV E_DIR="/opt/evilginx"
ENV E_PHISHLETS="$E_DIR/phislets"
ENV E_REDIRECTORS="$E_DIR/redirectors"
ENV E_EILPUPPET="$E_DIR/evilpuppet"
ENV E_STATIC="$E_DIR/evilpuppet"

COPY --from=build /opt/bin/evilginx3 /opt/bin/evilginx

COPY entrypoint.sh /opt/entrypoint.sh
ENTRYPOINT ["/opt/entrypoint.sh"]
