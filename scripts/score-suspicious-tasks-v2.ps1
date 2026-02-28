<#
.SYNOPSIS
Advanced heuristic scoring for scheduled-task persistence.

.DESCRIPTION
Detects:
- Script engines
- ExecutionPolicy abuse
- Hidden execution
- Remote payloads
- Obfuscation (Base64, hex, caret-escape)
- Non-Microsoft persistence paths
#>

Write-Host "SilentLoaderHunter :: Advanced Task Scoring" -ForegroundColor Cyan
Write-Host ""

$Raw = schtasks /query /fo LIST /v
$Blocks = $Raw -split "TaskName:"

foreach ($B in $Blocks) {
    if ($B.Trim() -eq "") { continue }

    $Score = 0
    $Indicators = @()

    if ($B -match "powershell|cmd\.exe|wscript|cscript") {
        $Score += 2; $Indicators += "ScriptEngine"
    }
    if ($B -match "bypass") {
        $Score += 5; $Indicators += "ExecPolicyBypass"
    }
    if ($B -match "hidden") {
        $Score += 4; $Indicators += "HiddenWindow"
    }
    if ($B -match "iex|invoke-expression") {
        $Score += 5; $Indicators += "DynamicExecution"
    }
    if ($B -match "http|https") {
        $Score += 3; $Indicators += "RemotePayload"
    }

    # Obfuscation heuristics
    if ($B -match "[A-Za-z0-9+/]{40,}={0,2}") {
        $Score += 6; $Indicators += "Base64Like"
    }
    if ($B -match "0x[0-9a-fA-F]{2}") {
        $Score += 4; $Indicators += "HexEncoding"
    }
    if ($B -match "\^") {
        $Score += 3; $Indicators += "CMDObfuscation"
    }

    if ($B -notmatch "\\Microsoft\\") {
        $Score += 2; $Indicators += "NonMicrosoftPath"
    }

    if ($Score -gt 0) {
        $Name = ($B -split "`n")[0].Trim()

        if ($Score -ge 15) { $Risk="CRITICAL"; $C="Red" }
        elseif ($Score -ge 10) { $Risk="HIGH"; $C="DarkRed" }
        elseif ($Score -ge 5) { $Risk="MEDIUM"; $C="Yellow" }
        else { $Risk="LOW"; $C="Gray" }

        Write-Host "$Name :: Score=$Score :: $Risk" -ForegroundColor $C
        Write-Host "  Indicators: $($Indicators -join ', ')" -ForegroundColor DarkGray
    }
}
