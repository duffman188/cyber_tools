#!/bin/bash

# === CFC Toolkit Launcher ===
# Efficient wrapper for your global hacking tools

# Color output helpers
GREEN="\033[0;32m"
RED="\033[0;31m"
YELLOW="\033[1;33m"
BLUE="\033[1;34m"
NC="\033[0m" # No Color

BANNER="
${GREEN}
  ____ _ ____   ___  ____      _            _       
 / ___(_) ___| / _ \\/ ___|__ _| | ___ _ __ | |_ ___ 
| |   | \\___ \\| | | | |   / _\` | |/ _ \\ '_ \\| __/ __|
| |___| |___) | |_| | |__| (_| | |  __/ | | | |_\\__ \\
 \\____|_|____/ \\___/ \\____\\__,_|_|\\___|_| |_|\\__|___/

             Crack This 8itch
${NC}
"

clear
echo -e "$BANNER"
echo -e "${YELLOW}[+] Toolkit loaded — $(date)${NC}"
sleep 1

while true; do
    clear
    echo -e "$BANNER"
    echo -e "\n${BLUE}┌──────────────────────────────────────────────┐"
    echo -e "│           ${GREEN}[ CFC Launcher Menu ]${BLUE}            │"
    echo -e "└──────────────────────────────────────────────┘${NC}"
    echo -e "${YELLOW}1)${NC} Recon chain (nmap + web tools)"
    echo -e "${YELLOW}2)${NC} Brute-force SSH (hydra)"
    echo -e "${YELLOW}3)${NC} Packet capture (tshark)"
    echo -e "${YELLOW}4)${NC} Generate + listen for reverse shell"
    echo -e "${YELLOW}5)${NC} Crack hashes (john + rockyou)"
    echo -e "${YELLOW}6)${NC} Exit"
    echo

    read -p $'\033[1;33mChoose an option:\033[0m ' OPTION

    case "$OPTION" in
        1)
            read -p $'\033[1;33mTarget IP:\033[0m ' IP
            "$HOME/hacking_tools/run_nmap.sh" "$IP"
            "$HOME/hacking_tools/run_dirsearch.sh" "$IP"
            "$HOME/hacking_tools/run_nikto.sh" "$IP"
            "$HOME/hacking_tools/run_sqlmap.sh" "http://$IP/index.php?id=1"
            read -p $'\n\033[1;34m[Press Enter to return to menu]\033[0m'
            ;;
        2)
            read -p $'\033[1;33mTarget IP:\033[0m ' IP
            "$HOME/hacking_tools/run_hydra.sh" "$IP"
            read -p $'\n\033[1;34m[Press Enter to return to menu]\033[0m'
            ;;
        3)
            read -p $'\033[1;33mInterface or Target IP:\033[0m ' INT
            "$HOME/hacking_tools/run_wireshark.sh" "$INT"
            read -p $'\n\033[1;34m[Press Enter to return to menu]\033[0m'
            ;;
        4)
            read -p $'\033[1;33mYour IP (attacker):\033[0m ' LHOST
            read -p $'\033[1;33mPort to listen on:\033[0m ' LPORT
            read -p $'\033[1;33mShell type (bash, python, php):\033[0m ' SHELL
            "$HOME/hacking_tools/run_reverse_shell.sh" "$LHOST" "$LPORT" "$SHELL"
            read -p $'\n\033[1;34m[Press Enter to return to menu]\033[0m'
            ;;
        5)
            read -p $'\033[1;33mPath to hash file:\033[0m ' HASHFILE
            "$HOME/hacking_tools/run_john.sh" "$HASHFILE"
            read -p $'\n\033[1;34m[Press Enter to return to menu]\033[0m'
            ;;
        6)
            echo -e "\n${RED}[*] Exiting. Good luck!${NC}"
            exit 0
            ;;
        *)
            echo -e "\n${RED}[!] Invalid option.${NC}"
            read -p $'\n\033[1;34m[Press Enter to return to menu]\033[0m'
            ;;
    esac
done

