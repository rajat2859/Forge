# Forge

**Portable development rules for AI coding agents.**

Forge gives supported coding agents a consistent set of development standards and workflows across projects. Your coding agent does the work; Forge defines how that work should be approached, checked, and completed.

## Contents

- [Quick start](#quick-start)
- [Command reference](#command-reference)
- [Supported agents](#supported-agents)
- [How Forge works](#how-forge-works)
- [Rules and project instructions](#rules-and-project-instructions)
- [Repository structure](#repository-structure)
- [Troubleshooting](#troubleshooting)

## Quick start

1. Install Forge using the command for your operating system in the [Command reference](#command-reference).
2. Restart any coding-agent session that was already open.
3. Open your target project in a supported coding agent.
4. Run the standard Forge command listed for your agent in the [Command reference](#command-reference).
5. Describe your development task.

Forge audits the project's instructions, loads the current Forge rules, identifies conflicts, and establishes the working rules before development begins.

## Command reference

All installation, activation, Flash Mode, and update commands are collected here. Use the command that matches your operating system or coding agent.

### Install Forge

Choose your operating system and copy the full command from the code block.

**Windows PowerShell**

Run this in PowerShell:

```powershell
irm https://raw.githubusercontent.com/rajat2859/Forge/main/install/install.ps1 | iex
```

**macOS, Linux, or WSL**

Run this in your terminal:

```bash
curl -fsSL https://raw.githubusercontent.com/rajat2859/Forge/main/install/install.sh | bash
```

The installer detects supported coding-agent CLIs available in your `PATH`, downloads Forge, and installs its skills, rules, and execution modes. Existing installations are backed up before replacement.

### Agent commands

Copy the command for the coding agent you use.

| Agent | Standard command | Flash Mode command |
| --- | --- | --- |
| Claude Code | `/forge` | `/forge-flash <task>` |
| Antigravity CLI | `/forge` | `/forge-flash <task>` |
| Codex | `$forge` | `$forge-flash <task>` |
| OpenCode | `/forge` | `/forge-flash <task>` |
| Supported agent | `/forge-update` | Update Forge |

Replace `<task>` with the work you want Forge to perform. For example:

```text
/forge-flash migrate this React app to Next.js with TypeScript
```

For Codex, use the `$forge-flash` form:

```text
$forge-flash migrate this React app to Next.js with TypeScript
```

### Update Forge directly

Re-run the installer to update Forge. Choose the command for your operating system.

**Windows PowerShell**

```powershell
irm https://raw.githubusercontent.com/rajat2859/Forge/main/install/install.ps1 | iex
```

**macOS, Linux, or WSL**

```bash
curl -fsSL https://raw.githubusercontent.com/rajat2859/Forge/main/install/install.sh | bash
```

After updating, restart the coding-agent session so it loads the updated skills. The installer downloads from the repository's `main` branch, so changes on an unmerged pull request are not included yet.

## Supported agents

| Agent | Standard mode | Flash Mode |
| --- | --- | --- |
| Claude Code | Supported | Supported |
| Antigravity CLI | Supported | Supported |
| Codex | Supported | Supported |
| OpenCode | Supported | Supported |

The installer detects supported command-line agents available in your `PATH`. If an agent is not detected, make sure its CLI is installed and accessible from the terminal, then run the installer again.

## How Forge works

Forge is a **standards and workflow layer**, not a separate coding agent.

1. **Inspect the project.** Identify the workspace and locate applicable project instructions.
2. **Load Forge rules.** Discover every Markdown rule file directly inside the installed `rules/` directory and read each file in lexicographic path order.
3. **Resolve instruction conflicts.** Follow compatible instructions together. If Forge and project instructions conflict, explain the conflict and let the user decide how to proceed.
4. **Work within the rules.** Apply the complete active rule set throughout the session.
5. **Verify before completion.** Perform the checks required by the applicable rules and report anything that remains unverified.

Forge does not silently edit, remove, or weaken project instructions to resolve a conflict.

## Rules and project instructions

### The `rules/` directory is the source of truth

Forge discovers the current Markdown rule files directly inside `rules/` at runtime. It does not rely on a hardcoded filename list, a fixed rule count, or a manually maintained rule inventory.

- **Add a rule:** the new Markdown file becomes part of the discovered rule set.
- **Update a rule:** Forge reads and applies its current contents.
- **Remove or rename a rule:** the discovered set reflects the directory's current contents.
- **Missing or unreadable rules:** Forge must stop before modifying the project and explain the problem.

Entry points must read the full contents of every discovered rule. Flash must pass the full active rule context to all delegated workers, reviewers, and verifiers before they begin.

### Project instructions still matter

Forge checks applicable project instruction files and follows them alongside Forge rules when they are compatible. When instructions conflict, Forge reports the conflict before affected work proceeds and leaves the resolution to the user.

## Repository structure

```text
Forge/
├── SKILL.md
├── VERSION
├── rules/
│   └── Current Markdown rules, discovered dynamically
├── modes/
│   └── flash.md
├── commands/
│   ├── forge-flash/
│   │   └── SKILL.md
│   └── forge-update/
│       └── SKILL.md
├── install/
│   ├── install.ps1
│   └── install.sh
└── README.md
```

| Path | Purpose |
| --- | --- |
| `SKILL.md` | Main Forge controller and startup workflow |
| `rules/` | Source of truth for development standards |
| `modes/flash.md` | Parallel execution behavior for Flash Mode |
| `commands/forge-flash/` | Dedicated Flash companion skill |
| `commands/forge-update/` | Update companion skill |
| `install/` | Platform-specific installers |
| `VERSION` | Forge package version |

## Troubleshooting

**The installer does not detect my agent**

- Confirm the agent's CLI is installed.
- Confirm its command is available in the same terminal where you run the installer.
- Run the installer again after correcting your `PATH`.

**The new Forge rules are not active**

- Confirm the installation completed successfully.
- Restart the coding-agent session.
- Activate Forge again so it reads the installed rules.

**Forge cannot read its rules**

Forge must not continue with project modifications if the installed `rules/` directory is missing, unreadable, or empty. Check the installation and reinstall if needed.

---

Forge aims to make development standards consistent across supported agents while keeping project-specific instructions, user decisions, and verification in control.
