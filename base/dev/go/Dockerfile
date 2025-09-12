ARG GO_VERSION=latest
ARG GO_VERSION_TINY=latest

FROM golang:$GO_VERSION AS go
FROM tinygo/tinygo:$GO_VERSION_TINY AS tiny

FROM base AS golang
ARG USR
ARG GOROOT="/usr/local/go"
ARG GOROOT_TINY="/usr/local/tinygo"

ENV GOROOT=${GOROOT}
ENV GOROOT_TINY=${GOROOT_TINY}}

USER root

COPY --from=go ${GOROOT} ${GOROOT}
COPY --from=tiny ${GOROOT_TINY} ${GOROOT_TINY}

ENV PATH="$PATH:$GOROOT/bin:$GOROOT_TINY/bin"

RUN apt-get install -y apt-utils make
USER $USR
