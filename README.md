# CrowdStrike Network Remediation Tool

Automated PowerShell utility designed to fix stuck DNS resolver states, corrupt TCP/IP stacks, and unresponsive corporate VPN adapters across enterprise endpoints.

### Execution in CrowdStrike RTR
Deployed remotely via CrowdStrike Falcon Real-Time Response (RTR) console to bypass lost network interface access:

```bash
runscript -CloudFile="Network Reset" -CommandLine=""

### 🛠 What This Script Executes:
1. Flushes the local DNS Resolver Cache (`Clear-DnsClientCache`).
2. Resets Winsock catalog and TCP/IP stack (`netsh winsock reset`, `netsh int ip reset`).
3. Releases and renews IP configuration (`ipconfig /release`, `ipconfig /renew`).
4. Initiates a forced system reboot to re-initialize system network drivers.
