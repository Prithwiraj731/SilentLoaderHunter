<#
.SYNOPSIS
Export scheduled task XML details.

.DESCRIPTION
Exports full task configuration for forensic inspection.
Useful for analyzing:
- Hidden arguments
- PowerShell execution flags
- Remote URLs
#>

param(
    [Parameter(Mandatory = $true)]
    [string]$TaskName
)

Write-Host "SilentLoaderHunter - Export Task Details" -ForegroundColor Cyan
Write-Host "Exporting task: $TaskName" -ForegroundColor Yellow
Write-Host ""

try {
    Export-ScheduledTask -TaskName $TaskName | Out-File "$TaskName.xml"
    Write-Host "Task exported successfully to $TaskName.xml" -ForegroundColor Green
}
catch {
    Write-Host "Error exporting task. Ensure the task name is correct." -ForegroundColor Red
}

# Usage example:

.\export-task-details.ps1 -TaskName "SuspiciousTask"