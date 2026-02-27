<#
.SYNOPSIS
Check PowerShell execution policy configuration.

.DESCRIPTION
Displays execution policies at all scopes to identify:
- ExecutionPolicy Bypass abuse
- Machine-level overrides
- Suspicious policy enforcement
#>

Write-Host "SilentLoaderHunter - Execution Policy Check" -ForegroundColor Cyan
Write-Host ""

Get-ExecutionPolicy -List | Format-Table -AutoSize