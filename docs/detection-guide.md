# Detection Guide

## Method 1 — Emergency Quick Detection (CMD)

Run as Administrator:
schtasks /query /fo LIST /v > tasks.txt & findstr /i "powershell bypass hidden irm http https" tasks.txt

Review `tasks.txt` for suspicious entries.

---

## Method 2 — PowerShell Script Detection

Run:
.\scripts\detect-script-engines.ps1

This lists scheduled tasks executing script engines.

---

## Method 3 — Suspicious Task Filtering

Run:
.\scripts\detect-suspicious-tasks.ps1

This filters out common vendor tasks and surfaces unusual ones.

---

## What To Look For

- Non-Microsoft task paths
- Tasks with random names
- Tasks triggered at startup or logon
- PowerShell running with hidden window
- Remote URLs in arguments

---

## Forensic Export

To export all tasks:
.\scripts\export-all-tasks.ps1

Analyze the exported file for suspicious flags.
