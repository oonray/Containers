FROM oonray/tmux:latest AS tmux
FROM kalilinux/kali-rolling:latest

ENV APPIMAGE_EXTRACT_AND_RUN=1

ENV USR=kali
ENV GOROOT="/usr/local/go"
ENV CONF_DIR="/opt/conf"
ENV T_CONF="$CONF_DIR/tmux/tmux.conf"
ENV Z_CONF="$CONF_DIR/zsh/zshrc"
ENV C_CONF="$CONF_DIR/colors/dircolors"

RUN apt-get update && \
apt-get install -y kali-tools-passwords \
kali-linux-core kali-system-cli \
python3 python3-pip python3-venv \
python3-impacket python3-scapy \
openssh-client openssh-server dumb-init ssh-import-id \
tmux tmuxinator zsh git jq curl sudo zip tar

RUN apt-get install -y \
mitmproxy net-tools dnsutils netcat-traditional \
git proxychains socat nmap responder peass netexec gobuster  \
7zip arp-scan arping | iputils-arping bind9-dnsutils \
binwalk binwalk3 bulk-extractor cewl cifs-utils clang commix creddump7 \
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

COPY --from=tmux /opt/deb/bar.deb /tmp/bat.deb
RUN apt install -y /tmp/bat.deb && \
rm /tmp/bat.deb

COPY --from=golang:latest ${GOROOT} ${GOROOT}
COPY --from=tmux /etc/ssh/sshd_config /etc/ssh/sshd_config
COPY --from=tmux /opt/entrypoint.sh /opt/entrypoint.sh

RUN useradd -u 1000 -s /usr/bin/zsh -m $USR
RUN echo "$USR ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/$USR

USER kali
WORKDIR /home/kali
RUN mkdir -p ~/.config

COPY --from=tmux --chown=kali:kali ${T_CONF} ~/.tmux.conf
COPY --from=tmux --chown=kali:kali ${Z_CONF} ~/.zshrc
COPY --from=tmux --chown=kali:kali ${CONF_DIR}/zsh/.oh-my-zsh ~/.oh-my-zsh
COPY --from=tmux --chown=kali:kali $C_CONF ~/.config/dircolors
COPY --from=tmux --chown=kali:kali /root/.ssh/authorized_keys ~/.ssh/authorized_keys

ENV PUID=1000
ENV PGID=1000

#
#Cleanup
#
USER root
RUN chown -R $USR /home/$USR && \
apt-get autoremove && \
apt-get clean

ENTRYPOINT ["/opt/entrypoint.sh"]
