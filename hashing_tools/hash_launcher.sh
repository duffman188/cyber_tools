#!/bin/bash

# === Hashing Toolkit Launcher ===
# Usage: bash hashing_tools.sh <command> [...args]
# Commands: identify, verify, salt, rainbow

COMMAND="$1"
shift

case "$COMMAND" in

  identify)
    HASH_INPUT="$1"
    echo "[*] Identifying hash type..."
    echo "$HASH_INPUT" | hashid || echo "[!] hashid not installed"
    ;;

  verify)
    FILE="$1"
    KNOWN_HASH="$2"
    ALGO="${3:-sha256sum}"
    echo "[*] Verifying $FILE using $ALGO..."
    CALC_HASH=$(cat "$FILE" | $ALGO | awk '{print $1}')
    if [[ "$CALC_HASH" == "$KNOWN_HASH" ]]; then
      echo "[+] Match! File integrity verified."
    else
      echo "[!] Mismatch! File may be altered."
    fi
    ;;

  salt)
    PASSWORD="$1"
    SALT=$(openssl rand -hex 4)
    HASH=$(echo -n "$SALT$PASSWORD" | sha256sum | awk '{print $1}')
    echo "Salt: $SALT"
    echo "Hash: $HASH"
    ;;

  rainbow)
    HASH="$1"
    ALGO="${2:-sha1sum}"
    WORDLIST="${3:-wordlist.txt}"
    echo "[*] Cracking hash with $WORDLIST..."
    while read -r pwd; do
      TRY=$(echo -n "$pwd" | $ALGO | awk '{print $1}')
      [[ "$TRY" == "$HASH" ]] && echo "[+] Match found: $pwd" && exit 0
    done < "$WORDLIST"
    echo "[-] No match found."
    ;;

  *)
    echo "Usage: bash hashing_tools.sh <command> [...args]"
    echo "Commands:"
    echo "  identify <hash_string>"
    echo "  verify <file> <known_hash> [algorithm]"
    echo "  salt <password>"
    echo "  rainbow <hash> [algorithm] [wordlist.txt]"
    exit 1
    ;;

esac

