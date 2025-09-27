#!/bin/bash
if [[ -z "$1" || -z "$2" ]]; then
    echo "Usage: $0 <target_ip | port> <mode> [port]"
    echo "Modes:"
    echo "  scan <target>           — Scan common ports"
    echo "  connect <target> <port> — Connect to a specific port"
    echo "  listen <port>           — Start listener for reverse shell"
    exit 1
fi

MODE="$2"

case "$MODE" in
    scan)
        TARGET="$1"
        echo "[*] Scanning common ports on $TARGET with netcat..."
        nc -n -zv "$TARGET" 1-1024 2>&1 | tee netcat_scan_"$TARGET".txt
        ;;
    connect)
        TARGET="$1"
        PORT="$3"
        if [[ -z "$PORT" ]]; then
            echo "[!] Port required for connect mode"
            exit 1
        fi
        echo "[*] Connecting to $TARGET:$PORT..."
        nc "$TARGET" "$PORT"
        ;;
    listen)
        PORT="$1"
        echo "[*] Listening on port $PORT..."
        nc -lvnp "$PORT"
        ;;
    *)
        echo "[!] Invalid mode: $MODE"
        exit 1
        ;;
esac

