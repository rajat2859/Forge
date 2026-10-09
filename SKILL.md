---
name: forge
description: Personal development standards and workflow for software engineering. Use for repository work, coding, refactoring, reviews, architecture changes, debugging, or whenever the user invokes Forge. When explicitly activated, perform the Forge startup audit before development and continue applying Forge standards throughout the development session.
---

# Forge

Forge is a development standards and workflow layer. It does not replace the coding agent; it defines how the agent should work.

## Activation

When Forge is explicitly invoked:

1. Treat Forge as active for the current development session.
2. Before modifying the project, perform the startup audit below.
3. Discover and read every applicable Markdown rule file directly inside the installed `rules/` directory.
4. Apply the complete discovered Forge rule set to subsequent development work in the session.
5. Do not invent additional Forge rules. Normal engineering judgment may be used where Forge is silent, but it must not be presented as a Forge requirement.

## Dynamic Forge rule discovery

The `rules/` directory is the single source of truth for Forge rules. Never maintain a hardcoded list of rule filenames, a fixed rule count, or a manually synchronized inventory in an entry point.

When loading Forge rules:

1. Inspect the current contents of `rules/`.
2. Discover every regular Markdown rule file directly inside that directory.
3. Sort discovered file paths lexicographically for a stable reading order.
4. Read the complete contents of every discovered rule file before beginning development.
5. Apply every discovered rule; do not skip a file because its name or topic is unfamiliar.
6. If the directory is missing, unreadable, or contains no rule files, stop before modifying the project and tell the user why the rules could not be loaded.
7. Do not rely on cached rule lists from a previous session when the current directory can be inspected.

Adding a rule file makes it part of the active Forge rule set. Removing a rule file removes it from the discovered set. Updating a rule file changes the content that must be read and applied. No entry point should need editing solely because a rule was added, removed, renamed, or changed.

Use the host's filesystem or file-reading tools to enumerate and read the actual files. If a host cannot enumerate the directory directly, use its available file-listing capability to discover the files, then read every discovered file. Do not guess filenames.

## Startup audit

Before development begins:

1. Identify the repository or workspace root.
2. Inspect the project for development instructions and rule files.
3. Check likely instruction sources first, including:
   - `RULES.md`
   - `AGENTS.md`
   - `AGENTS.override.md`
   - `CLAUDE.md`
   - `CONTRIBUTING.md`
   - relevant instruction sections in `README.md`
   - instruction-oriented Markdown files
   - `ai-instructions/`
   - `docs/`
   - `.github/`
   - other files that clearly define coding, architecture, workflow, Git, or agent instructions
4. Read relevant project instructions before changing code.
5. Compare project instructions with the complete discovered Forge rule set.
6. If they are compatible, follow both.
7. If they conflict, report the conflict in chat before affected work proceeds.
8. Do not edit, delete, weaken, discard, or silently override project rules because of a conflict.
9. Let the user decide how a conflict should be resolved for the session.

Do not indiscriminately load every documentation file. Find files that plausibly contain working instructions and inspect the relevant material.

## Conflict report

For each material conflict, explain:

- the project rule;
- the applicable Forge rule;
- the conflict;
- the practical effect of each option.

Do not silently choose a winner.

## Update

The `/forge-update` command updates the installed Forge package using the repository installer. After updating, restart the coding-agent session so the new version is loaded.

## Execution modes

Execution modes may change how Forge carries out work, but they never replace or weaken the discovered Forge rules.

Available mode:

- `modes/flash.md` — dependency-aware parallel execution for large tasks.

Flash Mode is explicit only. When it is activated, every orchestrator, worker, subagent, integration agent, reviewer, and verifier must inherit the complete active Forge rule set, applicable project rules, and user-approved conflict resolutions.

The dedicated entry point is `/forge-flash <task>` on Claude Code, Antigravity CLI, and OpenCode, and `$forge-flash <task>` on Codex.

## Session behavior

After the startup audit is complete:

- apply all discovered Forge rules to development work;
- continue respecting applicable project rules;
- surface new rule conflicts when they become relevant;
- do not treat pre-existing non-compliance as permission to clean it up;
- keep the user in control of destructive or rule-conflicting decisions.

If the platform reloads skills per turn, use Forge whenever the current task is software-development work so these standards remain applicable.

## Completion check

Before considering a Forge-governed change complete, confirm that:

- every applicable discovered Forge rule and project instruction was followed or any conflict was resolved with the user;
- no destructive cleanup occurred merely to enforce Forge;
- meaningful completed work is committed according to the applicable Git commit rules;
- unrelated changes are not included in the commit;
- sensitive files or credentials are not committed;
- commit messages follow any applicable commit-format rule.
