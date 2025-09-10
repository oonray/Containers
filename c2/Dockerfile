# MY tmux config
FROM oonray/tmux:latest AS tmux

ENV USR=sliver
ENV GOROOT="/usr/local/go"
ENV CONF_DIR="/opt/conf"
ENV T_CONF="$CONF_DIR/tmux/tmux.conf"
ENV Z_CONF="$CONF_DIR/zsh/zshrc"
ENV C_CONF="$CONF_DIR/colors/dircolors"

#
# https://github.com/BishopFox/sliver/blob/master/Dockerfile
#
# Modified to fit my needs
## Compiles Sliver for use
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

# Install METASPLOITE
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

RUN groupadd -g 999 sliver \
    && useradd -r -u 999 -s /usr/bin/zsh -g sliver sliver \
    && mkdir -p /home/sliver/ \
    && chown -R sliver:sliver /home/sliver \
    && su -l sliver -c 'mkdir -p ~/.msf4/ && touch ~/.msf4/initial_setup_complete'

COPY --from=base /opt/sliver-server  /opt/sliver-server

USER sliver
RUN /opt/sliver-server unpack --force

COPY --from=tmux --chown=sliver:sliver ${T_CONF} ~/.tmux.conf
COPY --from=tmux --chown=sliver:sliver ${Z_CONF} ~/.zshrc
COPY --from=tmux --chown=sliver:sliver ${CONF_DIR}/zsh/.oh-my-zsh ~/.oh-my-zsh
COPY --from=tmux --chown=sliver:sliver $C_CONF ~/.config/dircolors
COPY --from=tmux --chown=sliver:sliver /root/.ssh/authorized_keys ~/.ssh/authorized_keys

COPY entrypoint.sh /opt/entrypoint.sh
RUN chmod +x /opt/entrypoint.sh

WORKDIR /home/sliver/
VOLUME [ "/home/sliver/.sliver" ]
ENTRYPOINT [ "/opt/entrypoint.sh" ]
