#!/bin/bash

if [[ -z "$1" ]]; then
echo "Usage $0 <target_ip>"
exit 1

fi

echo "[*] running enum4linux on $1..."

enum4linux -a "$1" | tee enum4linux_"$1".txt


