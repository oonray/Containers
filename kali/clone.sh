#!/bin/bash

cd /opt/git
git clone --recurse https://github.com/samratashok/nishang.git  &&\
git clone --recurse https://github.com/SecureAuthCorp/impacket.git &&\
git clone --recurse https://github.com/danielmiessler/SecLists.git &&\
git clone --recurse https://github.com/lgandx/Responder.git &&\
git clone --recurse https://github.com/sherlock-project/sherlock.git &&\
git clone --recurse https://github.com/PowerShellMafia/PowerSploit.git
