<#
.SYNOPSIS
Score scheduled tasks based on suspicious indicators.

.DESCRIPTION
Assigns risk scores based on:
- PowerShell usage
- ExecutionPolicy Bypass
- Hidden window
- Remote URLs
- IEX usage
- Non-Microsoft path
#>

Write-Host "SilentLoaderHunter - Suspicious Task Scoring" -ForegroundColor Cyan
Write-Host ""

$Tasks = schtasks /query /fo LIST /v

$TaskBlocks = $Tasks -split "TaskName:"

foreach ($Block in $TaskBlocks) {

    if ($Block.Trim() -eq "") { continue }

    $Score = 0

    if ($Block -match "powershell") { $Score += 2 }
    if ($Block -match "bypass") { $Score += 5 }
    if ($Block -match "hidden") { $Score += 4 }
    if ($Block -match "iex") { $Score += 5 }
    if ($Block -match "http") { $Score += 3 }

    if ($Block -notmatch "\\Microsoft\\") { $Score += 2 }

    if ($Score -gt 0) {

        $TaskNameLine = ($Block -split "`n" | Select-String "^\s*\S" | Select -First 1).Line.Trim()

        if ($Score -ge 12) {
            $Risk = "CRITICAL"
            $Color = "Red"
        }
        elseif ($Score -ge 8) {
            $Risk = "HIGH"
            $Color = "DarkRed"
        }
        elseif ($Score -ge 4) {
            $Risk = "MEDIUM"
            $Color = "Yellow"
        }
        else {
            $Risk = "LOW"
            $Color = "Gray"
        }

        Write-Host "$TaskNameLine — Score: $Score — Risk: $Risk" -ForegroundColor $Color
    }
}
