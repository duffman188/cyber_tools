#!/bin/bash
if [[ -z "$1" ]]; then
    echo "Usage: $0 <target_ip> [port] [https]"
    exit 1
fi

TARGET="$1"
PORT="${2:-80}"  # Default to port 80
PROTO="http"

# If user specifies "https" or port is 443, use HTTPS
if [[ "$3" == "https" || "$PORT" == "443" ]]; then
    PROTO="https"
fi

echo "[*] Starting Nikto scan on $PROTO://$TARGET:$PORT..."

OUTPUT_FILE="nikto_${TARGET}_$PORT.txt"
nikto -h "$PROTO://$TARGET:$PORT" -output "$OUTPUT_FILE"

echo "[+] Nikto scan complete. Results saved to $OUTPUT_FILE"

