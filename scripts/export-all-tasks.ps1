<#
.SYNOPSIS
Export all scheduled tasks (verbose) to a timestamped text file.

.DESCRIPTION
Replicates:
    schtasks /query /fo LIST /v

Exports full scheduled task details for forensic analysis.

Includes:
- Timestamped file naming
- Optional custom output directory
- Admin privilege check
- Error handling

.EXAMPLE
.\export-all-tasks.ps1

.EXAMPLE
.\export-all-tasks.ps1 -OutputDirectory "C:\Forensics"
#>

param(
    [string]$OutputDirectory = "."
)

Write-Host "SilentLoaderHunter - Full Scheduled Task Export" -ForegroundColor Cyan
Write-Host ""

# Check for Administrator privileges
$IsAdmin = ([Security.Principal.WindowsPrincipal] `
    [Security.Principal.WindowsIdentity]::GetCurrent()
).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)

if (-not $IsAdmin) {
    Write-Host "⚠ Please run PowerShell as Administrator." -ForegroundColor Red
    exit
}

# Ensure output directory exists
if (-not (Test-Path $OutputDirectory)) {
    try {
        New-Item -ItemType Directory -Path $OutputDirectory -Force | Out-Null
    }
    catch {
        Write-Host "Failed to create output directory." -ForegroundColor Red
        exit
    }
}

# Generate timestamped filename
$Timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$OutputPath = Join-Path $OutputDirectory "tasks_export_$Timestamp.txt"

Write-Host "Exporting scheduled tasks..." -ForegroundColor Yellow
Write-Host "Output file: $OutputPath"
Write-Host ""

try {
    schtasks /query /fo LIST /v | Out-File $OutputPath -Encoding UTF8
    Write-Host "✔ Export completed successfully." -ForegroundColor Green
}
catch {
    Write-Host "✖ Failed to export scheduled tasks." -ForegroundColor Red
}


<# How To Use
🔹 Basic Usage

Run PowerShell as Administrator:

.\scripts\export-all-tasks.ps1

It will generate:

tasks_export_YYYYMMDD_HHMMSS.txt

Example:

tasks_export_20260228_234501.txt
🔹 Export to Custom Folder
.\scripts\export-all-tasks.ps1 -OutputDirectory "C:\Forensics"

Now the file will be saved inside C:\Forensics. #>