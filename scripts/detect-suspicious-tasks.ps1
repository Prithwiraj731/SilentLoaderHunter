<#
.SYNOPSIS
Filter non-standard scheduled tasks.

.DESCRIPTION
Lists tasks excluding common vendors such as:
- Microsoft
- Windows
- ASUS
- Google

Helps surface custom or potentially malicious tasks.
#>

Write-Host "SilentLoaderHunter - Suspicious Task Filter" -ForegroundColor Cyan
Write-Host "Filtering non-standard tasks..." -ForegroundColor Yellow
Write-Host ""

Get-ScheduledTask | Where-Object {
    $_.TaskPath -notlike "\Microsoft*" -and
    $_.TaskName -notlike "*Microsoft*" -and
    $_.TaskName -notlike "*Windows*" -and
    $_.TaskName -notlike "*ASUS*" -and
    $_.TaskName -notlike "*Google*" -and
    $_.TaskName -notlike "*Edge*"
} | Select-Object TaskName, TaskPath, State