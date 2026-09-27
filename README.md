# Forge

Forge is my portable development-rules layer for AI coding agents.

The goal is simple: install Forge into a supported coding agent, activate it with `/forge`, and have the agent work according to my development standards without repeating those instructions for every task.

Forge is intended to remain agent-independent. Claude Code, Antigravity, Codex, OpenCode, and future adapters should all consume the same Forge rules rather than maintaining separate copies.

## Status

Forge is currently being designed. The rule system is being defined before installer and agent adapters are implemented.

## Target command interface

### In-agent commands

| Command | Purpose |
| --- | --- |
| `/forge` | Activate Forge for the current session. Discover project instructions, load Forge rules, compare them, and report conflicts before development begins. |
| `/forge-status` | Show whether Forge is active, the detected project stack, loaded rule groups, discovered project instruction files, and unresolved conflicts. |
| `/forge-rules` | Show a concise summary of the Forge rules active for the current session. |
| `/forge-conflicts` | Show unresolved conflicts between Forge rules, project rules, and existing project conventions. |
| `/forge-recheck` | Re-scan project instructions and configuration after relevant project files change. |
| `/forge-off` | Disable Forge behavior for the current session. |

### Terminal commands

These are part of the planned installer/management interface and are not implemented yet.

| Command | Purpose |
| --- | --- |
| `forge install` | Install Forge into supported coding agents. |
| `forge update` | Update the local Forge installation from the GitHub source. |
| `forge version` | Show the installed Forge version. |
| `forge doctor` | Check whether Forge and supported agent integrations are configured correctly. |

## Forge startup flow

When `/forge` is activated, the intended startup sequence is:

1. Inspect the repository for project-specific rules and instructions.
2. Read relevant instruction files before development begins.
3. Load Forge rules.
4. Compare Forge rules with project rules.
5. Report conflicts in chat without modifying the project rules.
6. Resolve conflicts with the user before affected work proceeds.
7. Establish the working rules for the session.
8. Begin development.

## Approved rule hierarchy

### Startup

1. **Discover project rules first and report conflicts**
   - Project-specific rules and instructions must be discovered before development begins.
   - Project rule files must not be edited, discarded, or silently overridden because they conflict with Forge.
   - Conflicts must be surfaced in chat and resolved with the user.

### Global safety

2. **No destructive changes without approval**
   - Existing code, files, dependencies, configuration, comments, logic, or structure must not be removed merely because they do not comply with Forge.
   - Non-compliant existing work must be flagged in chat first.
   - Destructive cleanup requires explicit user approval.

### Code quality

3. **Comment discipline**
   - Do not add comments that narrate obvious code.
   - Avoid redundant, AI-style, line-by-line, decorative, or commented-out dead code.
   - Comments should exist only when they provide necessary context that the code itself cannot clearly express.

4. **Clear, responsibility-based naming**
   - Components, sections, functions, variables, files, folders, services, and APIs should be named according to what they represent or do.
   - Avoid vague, generic, numbered, misleading, or unnecessarily abbreviated names when a meaningful name is possible.

## Rules

Detailed approved rules live in the `rules/` directory:

- `rules/01-project-rules.md`
- `rules/02-non-destructive-changes.md`
- `rules/03-comments.md`
- `rules/04-naming.md`

## Design principle

Forge is not a coding agent. Forge defines how a coding agent is expected to work.

The coding agent is the worker. Forge is the development standards and workflow layer.
