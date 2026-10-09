# Forge

Forge is my portable development-rules layer for AI coding agents.

Install Forge once, invoke it inside a supported coding agent, and let the agent work according to the same development standards across projects.

Forge is not a coding agent. The coding agent is the worker; Forge is the development standards and workflow layer.

## Current version

`0.3.0`

## Supported CLI targets

The installer currently detects and installs Forge for:

| Agent | Forge | Flash Mode |
| --- | --- | --- |
| Claude Code | `/forge` | `/forge-flash <task>` |
| Antigravity CLI | `/forge` | `/forge-flash <task>` |
| Codex | `$forge` | `$forge-flash <task>` |
| OpenCode | `/forge` | `/forge-flash <task>` |

Forge uses the same dynamically discovered rule files for every supported agent.

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
3. Installs the main `forge` skill.
4. Installs the `forge-flash` companion skill.
5. Copies the current `rules/` directory, execution `modes/`, companion commands, and `VERSION` into each installed skill package.
6. Backs up existing Forge installations before replacing them.
7. Prints the correct invocation commands for every installed agent.

Restart any coding-agent session that was already open during installation so it can rediscover Forge.

Re-running the installer currently acts as the update mechanism.

## Use

Start the coding agent from the project you want to work on.

Example with Antigravity:

```bash
agy
```

Then activate normal Forge:

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
3. Enumerate the current Markdown rule files in the installed `rules/` directory.
4. Read every discovered Forge rule file in lexicographic path order.
5. Compare the discovered Forge rules with project rules.
6. Report conflicts in chat without changing either rule set.
7. Let the user decide how conflicts should be handled.
8. Establish the working rules for the session.

The `rules/` directory is the single source of truth. Forge entry points must not hardcode rule filenames, maintain a fixed rule count, or require manual edits when rule files are added, changed, renamed, or removed. If the directory cannot be read or no rule files are found, Forge must stop before modifying the project and explain why.

## Flash Mode

Use Flash Mode for large development tasks that benefit from multiple parallel agents.

Example:

```text
/forge-flash migrate this React app to Next.js with TypeScript
```

Codex:

```text
$forge-flash migrate this React app to Next.js with TypeScript
```

Flash Mode:

1. Performs the normal Forge startup audit.
2. Discovers and reads every current Forge rule file dynamically.
3. Builds a dependency-aware execution plan.
4. Splits independent work into explicit agent-owned workstreams.
5. Passes the complete contents of every discovered Forge rule file, applicable project rules, and resolved conflicts to each delegated agent before it starts.
6. Runs safe workstreams concurrently when the host supports parallel agents.
7. Integrates all worker output centrally.
8. Reviews the combined result.
9. Runs applicable verification such as typecheck, lint, tests, and build.

Every Flash orchestrator, worker, subagent, integration agent, reviewer, and verifier must receive the complete active rule context before starting. Flash must not assume agents inherit the orchestrator's conversation or filesystem access. If the complete context cannot be passed or verified, it must not start that delegated work.

Flash achieves speed through parallel execution, not by skipping rules, analysis, integration, review, or verification.

## Skill structure

```text
Forge/
├── SKILL.md
├── VERSION
├── rules/
│   └── All current Markdown rule files are discovered dynamically
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

`SKILL.md` is the portable Forge controller.

The files in `rules/` are the source of truth and are discovered at runtime.

`modes/flash.md` defines Flash execution behavior.

`commands/forge-flash/SKILL.md` is the dedicated Flash entry point installed as the companion `forge-flash` skill.

## Rule principles

The specific development requirements live in the Markdown files inside `rules/`. Forge does not duplicate their individual names or maintain a separate numbered inventory here. All entry points discover and read the current files directly from that directory.

## Execution modes

### Flash Mode

Flash is a large-task execution mode, not a replacement rule set.

Its hard requirement is that every delegated agent inherits the complete active Forge rule set and applicable project rules.

The orchestrator plans dependencies, assigns non-overlapping ownership where possible, executes safe work in parallel, integrates results, runs a whole-task review, and verifies the final result.

## Planned companion commands

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

For version `0.3.0`, use `/forge-update` to update Forge, or run the one-line installer directly.
