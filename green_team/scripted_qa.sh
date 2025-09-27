#!/bin/bash
URL="$1"
echo "[*] Testing $URL..."
curl -s -o /dev/null -w "%{http_code}" "$URL/login"
curl -s -o /dev/null -w "%{http_code}" "$URL/dashboard"

