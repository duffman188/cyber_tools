#!/bin/bash

# === Green Team Checker ===
# Lightweight tool to simulate basic usability and service checks

TARGET="$1"
LOG="green_check_$(date +%F_%H-%M).log"

if [[ -z "$TARGET" ]]; then
    echo "Usage: $0 <target_ip_or_url>"
    exit 1
fi

function log_and_echo() {
    echo -e "$1" | tee -a "$LOG"
}

log_and_echo "\n=== Green Team Check — Target: $TARGET ==="

# Check if site is reachable
log_and_echo "\n[*] Checking if target is reachable..."
curl -s -o /dev/null -w "%{http_code}" "$TARGET" | grep -qE '200|302'
if [[ $? -eq 0 ]]; then
    log_and_echo "[+] Target is online."
else
    log_and_echo "[!] Target appears down or unresponsive."
fi

# Test login page response
log_and_echo "\n[*] Checking login page..."
LOGIN_URL="$TARGET/login"
STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$LOGIN_URL")
log_and_echo "[+] HTTP status code for /login: $STATUS"

# Test dashboard page
DASHBOARD_URL="$TARGET/dashboard"
STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$DASHBOARD_URL")
log_and_echo "[+] HTTP status code for /dashboard: $STATUS"

# Ask manual feedback for usability
echo
read -p "[?] Were you able to log in successfully? (y/n): " LOGIN_OK
read -p "[?] Did the dashboard load correctly? (y/n): " DASH_OK
read -p "[?] Any visual bugs or missing elements? (y/n): " BUGS_FOUND

log_and_echo "\n--- Manual Feedback ---"
log_and_echo "Login OK: $LOGIN_OK"
log_and_echo "Dashboard OK: $DASH_OK"
log_and_echo "Visual issues: $BUGS_FOUND"

log_and_echo "\n[✓] Green check completed. Results saved to $LOG"

