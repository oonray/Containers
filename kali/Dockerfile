FROM kalilinux/kali-rolling:latest

ENV USR kali
ENV GOPATH="/home/$USR/.go"
ENV GOROOT="/usr/local/go"
ENV PATH="$PATH:$GOROOT/bin:$GOPATH/bin"

ENV CONF_DIR="/opt/conf"
ENV T_DIR="$CONF_DIR/tmux"
ENV T_CONF="$CONF_DIR/tmux/tmux.conf"

ENV Z_DIR="$CONF_DIR/zsh"
ENV Z_CONF="$Z_DIR/zshrc"

ENV C_DIR="$CONF_DIR/colors"
ENV C_CONF="$C_DIR/dircolors"

ENV PUID=1000
ENV PGID=1000

COPY --from=golang:latest ${GOROOT} ${GOROOT}
COPY --from=oonray/tmux:latest /opt /opt
COPY --from=oonray/ssh:latest /opt /opt

RUN apt-get update && \
apt-get install -y kali-tools-passwords \
kali-tools-fuzzing kali-linux-core kali-system-cli \
python3 python3-pip python3-venv \
python3-impacket python3-scapy

RUN apt-get install -y \
mitmproxy net-tools dnsutils netcat-traditional \
git proxychains socat nmap \
responder peass netexec gobuster  \
7zip arp-scan arping | iputils-arping bind9-dnsutils \
binwalk binwalk3 bulk-extractor cewl \
cifs-utils clang commix creddump7 \
crunch cryptcat cryptsetup cryptsetup-initramfs cryptsetup-nuke-password \
curlftpfs dirb dmitry dns2tcp dnschef dnsenum dnsrecon dos2unix enum4linux \
evil-winrm exe2hexbat exiv2 expect exploitdb ffuf gdisk gobuster gpp-decrypt \
hash-identifier hashcat hashcat-utils hashdeep hashid hotpatch hydra i2c-tools \
ifenslave impacket-scripts iodine john libimage-exiftool-perl minicom multimac \
nbtscan ncrack ncurses-hexedit netdiscover netmask netsed ngrep nikto onesixtyone \
passing-the-hash pdf-parser pdfid peass pipal pipx pixiewps plocate|mlocate powershell \
powersploit proxychains4 proxytunnel ptunnel pwnat qsslcaudit rebind rsmangler \
samdump2 sbd screen set smbmap snmp snmpcheck snmpd sqlmap ssldump sslh sslscan sslsplit \
sslyze statsprocessor stunnel4 swaks tcpick tcpreplay telnet testdisk tftp-hpa thc-ipv6 \
thc-pptp-bruter traceroute udptunnel unix-privesc-check unrar|unar upx-ucl vboot-kernel-utils \
vboot-utils neovim vlan voiphopper vpnc wce webshells wfuzz whatweb whois windows-binaries \
wordlists wpscan xxd

RUN useradd -u 1000 -s /usr/bin/zsh -m $USR
RUN echo "$USR ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/$USR

USER kali
WORKDIR /home/kali

RUN mkdir -p ~/.config
RUN --mount=type=bind,from=oonray/tmux:latest \
cp $T_CONF ~/.tmux.conf && \
cp $Z_CONF ~/.zshrc && \
cp -r $Z_DIR/.oh-my-zsh ~/.oh-my-zsh && \
cp $C_CONF ~/.config/dircolors

#
#Cleanup
#
USER root
RUN rm -rf /tmp/* && \
chown -R $USR /home/$USR && \
apt-get autoremove && apt-get clean

ENTRYPOINT ["/opt/entrypoint.sh"]
