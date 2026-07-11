#!/bin/bash

# Default target

DOMAIN=${1:-altschoolafrica.com}

# Timestamp

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

# Output directory

OUTPUT_DIR="scan_${DOMAIN}_${TIMESTAMP}"

mkdir -p "$OUTPUT_DIR"

echo "[+] Starting reconnaissance scan against $DOMAIN"
echo "[+] Results will be stored in $OUTPUT_DIR"

# Function to verify required tools

check_tool() {
if ! command -v "$1" &>/dev/null; then
echo "[!] $1 not found. Skipping."
return 1
fi
return 0
}

echo ""
echo "[*] Running WHOIS..."

if check_tool whois; then
whois "$DOMAIN" > "$OUTPUT_DIR/whois_report.txt" 2>&1
fi

echo "[*] Running NSLOOKUP..."

if check_tool nslookup; then
nslookup "$DOMAIN" > "$OUTPUT_DIR/dns_report.txt" 2>&1
fi

echo "[*] Running AMASS..."

if check_tool amass; then
    if amass enum -passive -d "$DOMAIN" > "$OUTPUT_DIR/amass_report.txt" 2>&1; then
      echo "[+] Amass completed"
    else
        echo "[!] Amass failed or timed out - using fallback methods" >> "$OUTPUT_DIR/amass_report.txt"
    fi

fi

echo "[*] Running GOBUSTER..."

if check_tool gobuster; then
gobuster dns --domain "$DOMAIN" --wordlist /usr/share/seclists/Discovery/DNS/subdomains-top1million-5000.txt > "$OUTPUT_DIR/gobuster_report.txt" 2>&1
fi

echo "[*] Running TESTSSL..."

if check_tool testssl.sh; then
testssl.sh "$DOMAIN" > "$OUTPUT_DIR/tls_report.txt" 2>&1
elif check_tool testssl; then
testssl "$DOMAIN" > "$OUTPUT_DIR/tls_report.txt" 2>&1
fi

echo ""
echo "[+] Scan completed"
echo "[+] Reports saved in: $OUTPUT_DIR"
