ARG VERSION
FROM debian:latest
USER root
WORKDIR /opt

RUN ./config/setup.sh --force --silent
RUN curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall \
    && chmod 755 msfinstall \
    && ./msfinstall

RUN mkdir -p ~/.msf4/ && touch ~/.msf4/initial_setup_complete

RUN git clone https://github.com/BishopFox/sliver.git && \
cd sliver && \
make clean-all \
    && make \
    && cp -vv sliver-server /opt/sliver-server \
    && /opt/sliver-server unpack --force

RUN git clone --recursive https://github.com/BC-SECURITY/Empire.git
WORKDIR /opt/Empire
RUN sudo ./setup/install.sh
WORKDIR /opt

RUN mkdir -p /opt/metasploit-framework/modules/post/multi/gather/ && \
curl -Lo /opt/metasploit-framework/modules/post/multi/gather/peass.rb https://raw.githubusercontent.com/carlospolop/PEASS-ng/master/metasploit/peass.rb  &&\
msfupdate

WORKDIR /opt
COPY entry.sh entry.sh
RUN chmod +x entry.sh
CMD ["/bin/bash","/opt/entry.sh"]
