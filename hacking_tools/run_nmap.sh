#!/bin/bash

if [[ -z "$1" ]]; then

echo "Usage <target_ip>"

exit 1
fi


echo "[*] Running full TCP scan on $1..."

nmap -sC -sV -p- -T4 "$1" -oN namp_"$1".txt
