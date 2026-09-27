# Forge

Forge is my portable development-rules layer for AI coding agents.

Install Forge once, invoke it inside a supported coding agent, and let the agent work according to the same development standards across projects.

Forge is not a coding agent. The coding agent is the worker; Forge is the development standards and workflow layer.

## Current version

`0.1.0`

## Supported CLI targets

The installer currently detects and installs Forge for:

| Agent | Installed to | Invoke |
| --- | --- | --- |
| Claude Code | `~/.claude/skills/forge/` | `/forge` |
| Antigravity CLI | `~/.gemini/antigravity-cli/skills/forge/` | `/forge` |
| Codex | `$CODEX_HOME/skills/forge/` or `~/.codex/skills/forge/` | `$forge` |
| OpenCode | `~/.config/opencode/skills/forge/` | `/forge` |

Forge uses the same `SKILL.md` and rule files for every supported agent.

## Install

### Windows PowerShell

```powershell
irm https://raw.githubusercontent.com/rajat2859/Forge/main/install/install.ps1 | iex
```

### macOS / Linux / WSL

```bash
curl -fsSL https://raw.githubusercontent.com/rajat2859/Forge/main/install/install.sh | bash
```

The installer:

1. Detects supported coding-agent CLIs available in `PATH`.
2. Downloads the latest Forge package from this repository.
3. Installs `SKILL.md`, `rules/`, and `VERSION` into each detected agent's global skill directory.
4. Backs up an existing Forge installation before replacing it.
5. Prints the correct invocation command for every installed agent.

Restart any coding-agent session that was already open during installation so it can rediscover Forge.

Re-running the installer currently acts as the update mechanism.

## Use

Start the coding agent from the project you want to work on.

Example with Antigravity:

```bash
agy
```

Then activate Forge:

```text
/forge
```

Claude Code and OpenCode also use `/forge`.

Codex uses:

```text
$forge
```

When Forge activates, it should first:

1. Find project-specific rules and instruction files.
2. Read the relevant project instructions.
3. Load the approved Forge rules.
4. Compare Forge rules with project rules.
5. Report conflicts in chat without changing either rule set.
6. Let the user decide how conflicts should be handled.
7. Establish the working rules for the session.
8. Begin development.

## Skill structure

```text
Forge/
├── SKILL.md
├── VERSION
├── rules/
│   ├── 01-project-rules.md
│   ├── 02-non-destructive-changes.md
│   ├── 03-comments.md
│   └── 04-naming.md
├── install/
│   ├── install.ps1
│   └── install.sh
└── README.md
```

`SKILL.md` is the portable Forge controller.

The files in `rules/` are the approved development rules and remain the source of truth.

## Approved rule hierarchy

### Startup

1. **Discover project rules first and report conflicts**
   - Discover project-specific rules and instructions before development begins.
   - Do not edit, discard, or silently override project rule files because they conflict with Forge.
   - Surface conflicts in chat and resolve them with the user.

### Global safety

2. **No destructive changes without approval**
   - Do not remove existing code, files, dependencies, configuration, comments, logic, or structure merely because they do not comply with Forge.
   - Flag existing non-compliance in chat first.
   - Destructive cleanup requires explicit user approval.

### Code quality

3. **Comment discipline**
   - Do not add comments that narrate obvious code.
   - Avoid redundant, AI-style, line-by-line, decorative, or commented-out dead code.
   - Use comments only when they provide necessary context the code itself cannot clearly express.

4. **Clear, responsibility-based naming**
   - Name components, sections, functions, variables, files, folders, services, and APIs according to what they represent or do.
   - Avoid vague, generic, numbered, misleading, or unnecessarily abbreviated names when a meaningful name is possible.

## Planned companion commands

The primary Forge skill is implemented now. These companion commands remain planned:

| Command | Purpose |
| --- | --- |
| `/forge-status` | Show Forge state, detected stack, discovered project rules, and unresolved conflicts. |
| `/forge-rules` | Show a concise summary of active Forge rules. |
| `/forge-conflicts` | Show unresolved Forge/project-rule conflicts. |
| `/forge-recheck` | Re-scan project rules and configuration. |
| `/forge-off` | Stop treating Forge as active for the current session. |

Planned terminal management commands:

| Command | Purpose |
| --- | --- |
| `forge install` | Install Forge into supported agents. |
| `forge update` | Update installed Forge copies. |
| `forge version` | Show the installed Forge version. |
| `forge doctor` | Diagnose Forge and agent integration. |

For version `0.1.0`, use the one-line installer to install or update Forge.
