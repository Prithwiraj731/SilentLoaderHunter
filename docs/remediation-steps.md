# Remediation Guide

## Step 1 — Identify the Malicious Task

Use detection methods to locate suspicious task.

---

## Step 2 — Delete the Task

1. Open Task Scheduler (`taskschd.msc`)
2. Locate suspicious task
3. Right-click → Delete

---

## Step 3 — Restart System

Reboot and observe if suspicious behavior stops.

---

## Step 4 — Harden PowerShell

Run:
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser

---

## Step 5 — Run Defender Offline Scan

Use Microsoft Defender Offline Scan to ensure no secondary payload exists.

---

## Optional — Block Malicious IP
.\scripts\block-malicious-ip.ps1 -IPAddress "X.X.X.X"

---

## After Cleanup Checklist

- No CMD flashing
- No hidden PowerShell tasks
- Execution policy secured
- Firewall rule applied
- Defender reports clean system
