<#
.SYNOPSIS
    Automated Network Stack & DNS Reset Utility via CrowdStrike RTR.
.DESCRIPTION
    Remediates stuck DNS resolver cache, corrupt IP stacks, and unresponsive VPN network 
    adapters on enterprise endpoints. Clears DNS cache, resets Winsock/TCP/IP, and 
    schedules an automated system reboot.
.NOTES
    Author: Namit Rajput
    Execution: CrowdStrike Falcon Real-Time Response (RTR)
#>

Write-Host "Starting Enterprise Network Stack Remediation..." -ForegroundColor Yellow

try {
    # 1. Clear Local DNS Cache
    Write-Host "[1/4] Flushing DNS Resolver Cache..." -ForegroundColor Cyan
    Clear-DnsClientCache
    
    # 2. Reset Winsock & TCP/IP Stack
    Write-Host "[2/4] Resetting Winsock & IP Interfaces..." -ForegroundColor Cyan
    Start-Process netsh -ArgumentList "winsock reset" -NoNewWindow -Wait
    Start-Process netsh -ArgumentList "int ip reset" -NoNewWindow -Wait

    # 3. Release and Renew IP Lease
    Write-Host "[3/4] Renewing Network Adapter Lease..." -ForegroundColor Cyan
    Start-Process ipconfig -ArgumentList "/release" -NoNewWindow -Wait
    Start-Process ipconfig -ArgumentList "/renew" -NoNewWindow -Wait

    # 4. Schedule Forced Reboot in 10 Seconds
    Write-Host "[4/4] Scheduling System Reboot in 10 Seconds..." -ForegroundColor Red
    Start-Process shutdown -ArgumentList "/r /t 10 /c ""Network Stack Reset complete. Restarting system...""" -NoNewWindow

    Write-Host "REMEDIATION COMPLETE: Reboot initiated." -ForegroundColor Green
}
catch {
    Write-Error "Failed to complete Network Stack Reset: $_"
}
