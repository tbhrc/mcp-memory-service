# AOS Brain GitHub Mirror

This folder is the GitHub-controlled mirror for the AOS Brain.

## Cloud source path

```text
OneDrive / AOS / 0_brain
```

Known SharePoint backend path:

```text
tbhrc-my.sharepoint.com/personal/info_talentbridgedubai_com/Documents/AOS/0_brain
```

## Purpose

This repo provides version control, repeatable setup, and agent-readable configuration for the AOS Brain.

OneDrive remains the human-facing synced folder. GitHub is the versioned engineering/source-control mirror.

## Sync model

```text
OneDrive / AOS / 0_brain
        <->
GitHub / tbhrc/mcp-memory-service / aos_brain
```

## What belongs here

- Seed memories
- Brain operating rules
- Claude/Codex config fragments
- Install and runtime notes
- Sync scripts
- Acceptance tests

## What does not belong here

- API keys
- passwords
- OAuth secrets
- live memory database files
- private client records unless intentionally sanitized
- large cache/model files
- runtime logs

## Local sync command

From the cloned repo:

```powershell
.\aos_brain\scripts\sync-onedrive-to-github.ps1 -AosBrainPath "$env:OneDriveCommercial\AOS\0_brain"
```

Then commit and push:

```powershell
git add aos_brain
git commit -m "Sync AOS brain from OneDrive"
git push
```
