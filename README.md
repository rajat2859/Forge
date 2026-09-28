# Forge

Forge is my portable development-rules layer for AI coding agents.

Install Forge once, invoke it inside a supported coding agent, and let the agent work according to the same development standards across projects.

Forge is not a coding agent. The coding agent is the worker; Forge is the development standards and workflow layer.

## Current version

`0.2.0`

## Supported CLI targets

The installer currently detects and installs Forge for:

| Agent | Forge | Flash Mode |
| --- | --- | --- |
| Claude Code | `/forge` | `/forge-flash <task>` |
| Antigravity CLI | `/forge` | `/forge-flash <task>` |
| Codex | `$forge` | `$forge-flash <task>` |
| OpenCode | `/forge` | `/forge-flash <task>` |

Forge uses the same rule files for every supported agent.

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
5. Copies the approved `rules/`, execution `modes/`, and `VERSION` into each installed skill package.
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
3. Load the approved Forge rules.
4. Compare Forge rules with project rules.
5. Report conflicts in chat without changing either rule set.
6. Let the user decide how conflicts should be handled.
7. Establish the working rules for the session.
8. Begin development.

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
2. Loads all four approved Forge rules.
3. Builds a dependency-aware execution plan.
4. Splits independent work into explicit agent-owned workstreams.
5. Runs safe workstreams concurrently when the host supports parallel agents.
6. Integrates all worker output centrally.
7. Reviews the combined result.
8. Runs applicable verification such as typecheck, lint, tests, and build.

**Every Flash orchestrator, worker, subagent, integration agent, reviewer, and verifier must follow all four Forge rules, applicable project rules, and session conflict resolutions.**

Flash achieves speed through parallel execution, not by skipping rules, analysis, integration, review, or verification.

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
├── modes/
│   └── flash.md
├── commands/
│   └── forge-flash/
│       └── SKILL.md
├── install/
│   ├── install.ps1
│   └── install.sh
└── README.md
```

`SKILL.md` is the portable Forge controller.

The files in `rules/` are the approved development rules and remain the source of truth.

`modes/flash.md` defines Flash execution behavior.

`commands/forge-flash/SKILL.md` is the dedicated Flash entry point installed as the companion `forge-flash` skill.

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

For version `0.2.0`, use the one-line installer to install or update Forge.
