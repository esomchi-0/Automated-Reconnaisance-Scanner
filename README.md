Automated Reconnaissance Scanner

Overview

This project automates reconnaissance activities using Bash scripting.

The scanner performs:

- WHOIS enumeration
- DNS inspection
- Passive subdomain discovery using Amass
- DNS brute-force enumeration using Gobuster
- TLS/SSL analysis using testssl.sh

 Features

- Default target support
- Custom domain argument support
- Timestamped output folders
- Tool dependency checking
- Graceful error handling

 Usage

```bash
./recon_scanner.sh
```

or

```bash
./recon_scanner.sh example.com
```
 Example Output

```
scan_altschoolafrica.com_20260710_145500/

├── whois_report.txt
├── dns_report.txt
├── amass_report.txt
├── gobuster_report.txt
└── tls_report.txt
```

 Tools Used

- Bash
- Whois
- Nslookup
- Amass
- Gobuster
- TestSSL.sh
- Kali Linux

 Skills Demonstrated

- Bash scripting
- Reconnaissance automation
- DNS enumeration
- SSL/TLS assessment
- Error handling
