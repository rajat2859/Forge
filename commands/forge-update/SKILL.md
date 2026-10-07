---
name: forge-update
description: Update the installed Forge skill and companion skills from the latest Forge package on GitHub.
---

# Forge Update

Use this command to update an installed Forge package.

## Update

### Windows PowerShell

```powershell
irm https://raw.githubusercontent.com/rajat2859/Forge/main/install/install.ps1 | iex
```

### macOS / Linux / WSL

```bash
curl -fsSL https://raw.githubusercontent.com/rajat2859/Forge/main/install/install.sh | bash
```

The installer detects supported agents, downloads the latest Forge package, backs up existing Forge installations, and installs the updated Forge and companion skills.

## After Updating

Restart the coding-agent session so it loads the updated Forge version.

Do not assume the current session has reloaded the new version until the session is restarted.
