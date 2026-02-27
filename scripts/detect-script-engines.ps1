<#
.SYNOPSIS
Detect scheduled tasks that execute scripting engines.

.DESCRIPTION
Scans all scheduled tasks and lists those that execute:
- PowerShell
- CMD
- WScript
- CScript

Useful for identifying persistence-based loaders.
#>

Write-Host "SilentLoaderHunter - Script Engine Detection" -ForegroundColor Cyan
Write-Host "Scanning scheduled tasks..." -ForegroundColor Yellow
Write-Host ""

Get-ScheduledTask | Where-Object {
    $_.Actions.Execute -like "*powershell*" -or
    $_.Actions.Execute -like "*cmd*" -or
    $_.Actions.Execute -like "*wscript*" -or
    $_.Actions.Execute -like "*cscript*"
} | Select-Object TaskName, TaskPath, State