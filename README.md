# Forge

**Portable development rules for AI coding agents.**

Forge gives supported coding agents a consistent set of development standards and workflows across projects. Your coding agent does the work; Forge defines how that work should be approached, checked, and completed.

## Contents

- [Quick start](#quick-start)
- [Supported agents](#supported-agents)
- [How Forge works](#how-forge-works)
- [Use Forge](#use-forge)
- [Flash Mode](#flash-mode)
- [Rules and project instructions](#rules-and-project-instructions)
- [Update Forge](#update-forge)
- [Repository structure](#repository-structure)
- [Troubleshooting](#troubleshooting)

## Quick start

### 1. Install Forge

**Windows PowerShell**

```powershell
irm https://raw.githubusercontent.com/rajat2859/Forge/main/install/install.ps1 | iex
```

**macOS, Linux, or WSL**

```bash
curl -fsSL https://raw.githubusercontent.com/rajat2859/Forge/main/install/install.sh | bash
```

The installer detects supported coding-agent CLIs in your `PATH`, downloads Forge, and installs its main skill, Flash companion, update command, rules, and execution modes. Existing installations are backed up before replacement.

### 2. Restart your coding agent

Restart any agent session that was open during installation so it can discover the installed skills.

### 3. Activate Forge

Run the appropriate command from the project you want to work on:

```text
/forge
```

Codex uses:

```text
$forge
```

Forge audits the project's instructions, loads the current Forge rules, identifies conflicts, and establishes the working rules for the session before development begins.

## Supported agents

| Agent | Standard mode | Flash Mode |
| --- | --- | --- |
| Claude Code | `/forge` | `/forge-flash <task>` |
| Antigravity CLI | `/forge` | `/forge-flash <task>` |
| Codex | `$forge` | `$forge-flash <task>` |
| OpenCode | `/forge` | `/forge-flash <task>` |

The installer detects the supported command-line agents available in your `PATH`. If an agent is not detected, make sure its CLI is installed and accessible from the terminal, then run the installer again.

## How Forge works

Forge is a **standards and workflow layer**, not a separate coding agent.

1. **Inspect the project.** Identify the workspace and locate applicable project instructions.
2. **Load Forge rules.** Discover every Markdown rule file directly inside the installed `rules/` directory and read each file in lexicographic path order.
3. **Resolve instruction conflicts.** Follow compatible instructions together. If Forge and project instructions conflict, explain the conflict and let the user decide how to proceed.
4. **Work within the rules.** Apply the complete active rule set throughout the session.
5. **Verify before completion.** Perform the checks required by the applicable rules and report anything that remains unverified.

Forge does not silently edit, remove, or weaken project instructions to resolve a conflict.

## Use Forge

### Standard development

Start your coding agent in the target project and invoke Forge:

| Agent | Command |
| --- | --- |
| Claude Code | `/forge` |
| Antigravity CLI | `/forge` |
| Codex | `$forge` |
| OpenCode | `/forge` |

Then describe the development task as you normally would.

### Flash Mode

Use Flash for larger tasks that benefit from parallel work:

```text
/forge-flash migrate this React app to Next.js with TypeScript
```

For Codex:

```text
$forge-flash migrate this React app to Next.js with TypeScript
```

Flash Mode:

1. Performs the normal Forge startup audit.
2. Discovers and reads the complete current Forge rule set.
3. Builds a dependency-aware plan and separates work into agent-owned workstreams.
4. Passes every discovered Forge rule, applicable project instruction, and user-approved conflict resolution to each delegated agent before work starts.
5. Runs independent work in parallel when the host supports it.
6. Integrates the results, reviews the combined changes, and runs applicable verification.

**Parallel work does not bypass rules or verification.** If Flash cannot pass or verify the complete active rule context for a delegated agent, it must not start that work.

## Rules and project instructions

### The `rules/` directory is the source of truth

Forge discovers the current Markdown rule files directly inside `rules/` at runtime. It does not rely on a hardcoded filename list, a fixed rule count, or a manually maintained rule inventory.

That means:

- **Add a rule:** the new Markdown file becomes part of the discovered rule set.
- **Update a rule:** Forge reads and applies its current contents.
- **Remove or rename a rule:** the discovered set reflects the directory's current contents.
- **Missing or unreadable rules:** Forge must stop before modifying the project and explain the problem.

Entry points must read the full contents of every discovered rule. Flash must pass the full active rule context to all delegated workers, reviewers, and verifiers before they begin.

### Project instructions still matter

Forge checks applicable project instruction files and follows them alongside Forge rules when they are compatible. When instructions conflict, Forge reports the conflict before affected work proceeds and leaves the resolution to the user.

## Update Forge

Re-run the installer to update the installed Forge package. The installer backs up existing installations before replacing them.

**Windows PowerShell**

```powershell
irm https://raw.githubusercontent.com/rajat2859/Forge/main/install/install.ps1 | iex
```

**macOS, Linux, or WSL**

```bash
curl -fsSL https://raw.githubusercontent.com/rajat2859/Forge/main/install/install.sh | bash
```

You can also invoke `/forge-update` from a supported agent. After updating, restart the coding-agent session so it loads the updated skills.

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
