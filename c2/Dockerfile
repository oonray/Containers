FROM golang:latest AS sliver

RUN apt-get update --fix-missing && apt-get -y install \
    git build-essential zlib1g zlib1g-dev wget zip unzip

RUN groupadd -g 999 sliver && useradd -r -u 999 -g sliver sliver
RUN mkdir -p /home/sliver/ && chown -R sliver:sliver /home/sliver

ADD https://github.com/BishopFox/sliver.git /go/src/github.com/bishopfox/sliver/

WORKDIR /go/src/github.com/bishopfox/sliver

RUN make clean-all
RUN make
RUN cp -vv sliver-server /opt/sliver-server

FROM base AS c2
ARG USR
ENV USR=${USR}

USER root
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
    && mkdir -p /opt/metasploit-framework/modules/post/multi/gather/ \
    && curl -Lo \
    /opt/metasploit-framework/modules/post/multi/gather/peass.rb \
    https://raw.githubusercontent.com/carlospolop/PEASS-ng/master/metasploit/peass.rb  \
    && msfupdate

USER $USR

# Install EMPIRE
RUN sudo git clone --recursive https://github.com/BC-SECURITY/Empire.git /opt/Empire
WORKDIR /opt/Empire
RUN sudo chmod 755 ./setup/install.sh \
&& ./setup/install.sh

USER root
RUN apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir -p /home/$USR/.sliver \
    && mkdir -p /home/$USR/.msf4/ \
    && touch /home/$USR/.msf4/initial_setup_complete \
    && chown -R $USR:$USR /home/$USR 

COPY --from=sliver /opt/sliver-server /usr/bin/sliver-server

COPY entrypoint.sh /opt/entrypoint.sh
RUN chmod +x /opt/entrypoint.sh \
    && chmod +x /usr/bin/sliver-server

USER $USR
WORKDIR /home/$USR/
RUN sliver-server unpack --force

ENTRYPOINT [ "/opt/entrypoint.sh" ]
