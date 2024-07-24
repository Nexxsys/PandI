#!/bin/bash

# Script Requirements:
# curl
# dnsrecon
# enum4linux
# feroxbuster
# gobuster
# impacket-scripts
# nbtscan
# nikto
# nmap
# onesixtyone
# oscanner
# redis-tools
# smbclient
# smbmap
# snmpwalk
# sslscan
# svwar
# tnscmd10g
# whatweb
# wkhtmltopdf
#
# Command to install the requirements:
# sudo apt install seclists curl dnsrecon enum4linux feroxbuster gobuster impacket-scripts nbtscan nikto nmap onesixtyone oscanner redis-tools smbclient smbmap snmp sslscan sipvicious tnscmd10g whatweb wkhtmltopdf
# sudo apt install python3-venv
# python3 -m pip install --user pipx
# python3 -m pipx ensurepath

target="$1"

autorecon $1 --nmap-append="--min-rate=2500" --exclude-tags="top-100-udp-ports" --dirbuster.threads=30 -vv