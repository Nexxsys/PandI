#!/bin/bash

if [ -z "$1" ]
then
	echo "Correct usage is ./recon.sh <IP>"
	exit 1
else
	echo "Target IP $1"
fi

echo "Running nmap..."

nmap -sV $1 > scan_results.txt

echo "Scan completed - Results written to scan_results.txt"

if grep 445 scan_results.txt | grep -iq open
then
	enum4linux -U -S $1 >> scan_results.txt
	echo "Samba Found! Enumeration Completed."
	echo "Results added to scan_results.txt."
	echo "To view the results, cat the file."
else
	echo "No Open SMB share ports found."
fi


