ARG GO_VERSION=latest
ARG GO_VERSION_TINY=latest

FROM golang:$GO_VERSION AS go
FROM tinygo/tinygo:$GO_VERSION_TINY AS tiny

FROM base AS golang
ENV GO_VERSION=${GO_VERSION}
ENV GO_VERSION_TINY=${GO_VERSION_TINY}

ENV GOROOT="/usr/local/go"
ENV GOROOT_TINY="/usr/local/tinygo"

ENV PATH="$PATH:$GOROOT/bin:$GOROOT_TINY/bin"

COPY --from=go ${GOROOT} ${GOROOT}
COPY --from=tiny /tinygo ${GOROOT_TINY}

RUN apt-get install -y apt-utils make
