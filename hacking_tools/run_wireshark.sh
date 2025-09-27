#!/bin/bash
if [[ -z "$1" ]]; then
    echo "Usage: $0 <interface or target_ip>"
    exit 1
fi

echo "[*] Starting packet capture for $1..."

# Use /tmp to avoid permission errors
PCAP_FILE="/tmp/capture_$1.pcap"

if ip link show "$1" > /dev/null 2>&1; then
    sudo tshark -i "$1" -w "$PCAP_FILE"
else
    sudo tshark -i any -f "host $1" -w "$PCAP_FILE"
fi

echo "[+] Saved capture to $PCAP_FILE"

