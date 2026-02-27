<#
.SYNOPSIS
Block outbound connection to a malicious IP address.

.DESCRIPTION
Creates a Windows Firewall rule blocking outbound traffic
to a specified remote IP address.

Requires Administrator privileges.
#>

param(
    [Parameter(Mandatory = $true)]
    [string]$IPAddress
)

Write-Host "SilentLoaderHunter - Firewall Block" -ForegroundColor Cyan
Write-Host "Blocking outbound traffic to $IPAddress" -ForegroundColor Yellow
Write-Host ""

try {
    New-NetFirewallRule `
        -DisplayName "SilentLoaderHunter Block $IPAddress" `
        -Direction Outbound `
        -RemoteAddress $IPAddress `
        -Action Block `
        -Protocol Any

    Write-Host "Firewall rule created successfully." -ForegroundColor Green
}
catch {
    Write-Host "Failed to create firewall rule. Run PowerShell as Administrator." -ForegroundColor Red
}


# Usage:

.\block-malicious-ip.ps1 -IPAddress "192.168.1.100"