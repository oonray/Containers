ARG IMAGE=oonray/kali
ARG USR=sliver
ARG GH_USR=oonray
ARG ENTRY=/opt/entrypoint.sh
ARG B_VER=0.25.0
ARG ARCH=amd64 #amd64 arm64 i386
ARG PUID=999
ARG PGID=999

FROM golang:latest AS base

RUN apt-get update --fix-missing && apt-get -y install \
    git build-essential zlib1g zlib1g-dev wget zip unzip

RUN groupadd -g 999 sliver && useradd -r -u 999 -g sliver sliver
RUN mkdir -p /home/sliver/ && chown -R sliver:sliver /home/sliver

ADD https://github.com/BishopFox/sliver.git /go/src/github.com/bishopfox/sliver/
WORKDIR /go/src/github.com/bishopfox/sliver
RUN make clean-all
RUN make
RUN cp -vv sliver-server /opt/sliver-server

FROM debian:latest AS production

RUN apt-get update --fix-missing \
    && apt-get -y upgrade \
    && apt-get -y install \
    libxml2 libxml2-dev libxslt-dev locate gnupg \
    libreadline6-dev libcurl4-openssl-dev git-core \
    libssl-dev libyaml-dev openssl autoconf libtool \
    ncurses-dev bison curl xsel postgresql \
    postgresql-contrib postgresql-client libpq-dev \
    curl libapr1 libaprutil1 libsvn1 \
    libpcap-dev libsqlite3-dev libgmp3-dev \
    nasm dumb-init tmux zsh

# Install METASPLOIT
RUN curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall \
    && chmod 755 msfinstall \
    && ./msfinstall \
    && mkdir -p ~/.msf4/ \
    && touch ~/.msf4/initial_setup_complete  \
    && mkdir -p /opt/metasploit-framework/modules/post/multi/gather/ \
    && curl -Lo \
    /opt/metasploit-framework/modules/post/multi/gather/peass.rb \
    https://raw.githubusercontent.com/carlospolop/PEASS-ng/master/metasploit/peass.rb  \
    && msfupdate

# Install EMPIRE
RUN git clone --recursive https://github.com/BC-SECURITY/Empire.git /opt/Empire
WORKDIR /opt/Empire
RUN chmod 755 ./setup/install.sh \
&& ./setup/install.sh

RUN apt-get remove -y curl gnupg \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN groupadd -g 999 $USR \
    && useradd -r -u 999 -s /usr/bin/zsh -g $USR $USR \
    && mkdir -p /home/$USR/ \
    && chown -R $USR:$USR /home/$USR \
    && su -l $USR -c 'mkdir -p ~/.msf4/ && touch ~/.msf4/initial_setup_complete'

COPY --from=base /opt/sliver-server /opt/sliver-server

USER $USR
RUN /opt/sliver-server unpack --force
WORKDIR /home/$USR
RUN mkdir -p /home/$USR/.config

COPY --from=tmux --chown=$USR:$USR ${T_CONF} /home/$USR/.tmux.conf
COPY --from=tmux --chown=$USR:$USR ${Z_CONF} /home/$USR/.zshrc
COPY --from=tmux --chown=$USR:$USR ${CONF_DIR}/zsh/.oh-my-zsh /home/$USR/.oh-my-zsh
COPY --from=tmux --chown=$USR:$USR $C_CONF /home/$USR/.config/dircolors

COPY entrypoint.sh /opt/entrypoint.sh
RUN chmod +x /opt/entrypoint.sh

WORKDIR /home/$USR/
VOLUME [ "/home/sliver/.sliver" ]
ENTRYPOINT [ "/opt/entrypoint.sh" ]
