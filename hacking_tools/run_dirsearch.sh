#!/bin/bash
if [[ -z "$1" ]]; then
    echo "Usage: $0 <target_ip>"
    exit 1
fi

echo "[*] Running dirsearch on http://$1..."
dirsearch -u "http://$1" -e php,html,txt -x 403,404 -t 20 -o dirsearch_"$1".txt

