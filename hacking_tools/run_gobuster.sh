#!/bin/bash
if [[ -z "$1" ]]; then
    echo "Usage: $0 <target_ip> [port]"
    exit 1
fi

TARGET="$1"
PORT="${2:-80}"
WORDLIST="/usr/share/wordlists/dirb/common.txt"

if [[ ! -f "$WORDLIST" ]]; then
    echo "[!] Wordlist not found: $WORDLIST"
    echo "Try installing: sudo apt install dirb"
    exit 1
fi

URL="http://$TARGET:$PORT"
OUTFILE="gobuster_${TARGET}_$PORT.txt"

echo "[*] Starting Gobuster scan on $URL..."

gobuster dir -u "$URL" -w "$WORDLIST" -t 50 -o "$OUTFILE"

echo "[+] Gobuster scan complete. Results saved to $OUTFILE"

