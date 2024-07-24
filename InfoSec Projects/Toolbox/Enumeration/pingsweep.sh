#!/bin/bash

# Function to validate CIDR notation
validate_cidr() {
    local cidr=$1
    if [[ $cidr =~ ^([0-9]{1,3}\.){3}0\/(24)$ ]]; then
        return 0
    else
        return 1
    fi
}

if [ -z "$1" ]; then
    echo "Correct usage is ./ping_sweep.sh <CIDR>"
    exit 1
else
    if validate_cidr $1; then
        echo "Valid CIDR notation: $1"
    else
        echo "Invalid CIDR notation. Please use the format xxx.xxx.xxx.0/24"
        exit 1
    fi
fi

echo "Running nmap ping sweep..."

# Run nmap and store results in sweep_results.txt while also displaying them on the screen
nmap -n -vv -sn $1 -oG - --reason | grep -i 'up' | tee sweep_results.txt

echo "Ping sweep completed - Results written to sweep_results.txt"
