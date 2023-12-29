#!/bin/bash

cd /usr/src/farzin
git clone https://github.com/ssrlive/shadowsocksr.git
python3 /usr/src/farzin/shadowsocksr/shadowsocks/server.py -c /usr/src/farzin/config.json
