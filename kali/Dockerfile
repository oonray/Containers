FROM base as kali
ARG USR
ARG ARCH
ARG PUID
ARG PGID

ENV USR=${USR}

USER root
RUN apt-get update && \
apt-get install -y \
kali-linux-core kali-system-cli \
mitmproxy python3-impacket python3-scapy \
proxychains socat nmap responder peass netexec gobuster  \
arp-scan iputils-arping bind9-dnsutils \
binwalk binwalk3 bulk-extractor cewl clang commix creddump7 \
crunch cryptcat curlftpfs dmitry dns2tcp dnschef dnsenum \
dnsrecon dos2unix enum4linux evil-winrm exe2hexbat \
exiv2 expect exploitdb ffuf gdisk gobuster gpp-decrypt \
hash-identifier hashcat hashcat-utils hashdeep hashid hotpatch hydra \
ifenslave impacket-scripts iodine john libimage-exiftool-perl minicom multimac \
nbtscan ncrack ncurses-hexedit netdiscover netmask netsed ngrep nikto onesixtyone \
passing-the-hash pdf-parser pdfid peass pipal pixiewps plocate powershell \
powersploit proxychains4 proxytunnel ptunnel pwnat qsslcaudit rebind rsmangler \
samdump2 sbd smbmap snmp snmpcheck snmpd sqlmap ssldump sslh sslscan sslsplit \
sslyze statsprocessor stunnel4 swaks tcpick tcpreplay telnet testdisk tftp-hpa thc-ipv6 \
thc-pptp-bruter traceroute udptunnel unix-privesc-check upx-ucl vboot-kernel-utils \
vboot-utils neovim vlan voiphopper vpnc wce webshells wfuzz whatweb whois windows-binaries \
wpscan

USER $USR

ENTRYPOINT ["/opt/entrypoint.sh"]
