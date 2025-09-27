#!/bin/bash
if [[ -z "$1" ]]; then
    echo "Usage: $0 <hash_file> [wordlist]"
    exit 1
fi

HASH_FILE="$1"
WORDLIST="${2:-/usr/share/wordlists/rockyou.txt}"
OUTFILE="john_$(basename "$HASH_FILE").cracked"

# Check files
if [[ ! -f "$HASH_FILE" ]]; then
    echo "[!] Hash file not found: $HASH_FILE"
    exit 1
fi

if [[ ! -f "$WORDLIST" ]]; then
    echo "[!] Wordlist not found: $WORDLIST"
    exit 1
fi

echo "[*] Cracking hashes in $HASH_FILE using $WORDLIST..."

john --wordlist="$WORDLIST" "$HASH_FILE"

echo "[*] Dumping cracked passwords to $OUTFILE..."
john --show "$HASH_FILE" > "$OUTFILE"

echo "[+] Done. Cracked passwords saved to $OUTFILE"

