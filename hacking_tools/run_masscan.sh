#!/bin/bash
if [[ -z "$1" ]]; then
    echo "Usage: $0 <target_ip or subnet> [ports]"
    echo "Example: $0 10.10.10.0/24 1-1000"
    exit 1
fi

TARGET="$1"
PORTS="${2:-1-65535}"  # Default to scanning all ports

echo "[*] Starting masscan on $TARGET (ports: $PORTS)..."

OUTPUT="masscan_${TARGET//\//_}_$(date +%F_%H%M).txt"

sudo masscan -p"$PORTS" "$TARGET" --rate=1000 -oL "$OUTPUT"

echo "[+] Masscan complete. Results saved to $OUTPUT"

