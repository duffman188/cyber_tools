#!/bin/bash
REMOTE="$1"
PORT="${2:-9999}"
echo "[*] Starting chisel tunnel to $REMOTE:$PORT"
./chisel client $REMOTE:$PORT R:1080:socks &

