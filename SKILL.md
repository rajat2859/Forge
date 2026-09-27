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
3. Read every approved Forge rule in the `rules/` directory.
4. Apply the approved Forge rules to subsequent development work in the session.
5. Do not invent additional Forge rules. Normal engineering judgment may be used where Forge is silent, but it must not be presented as a Forge requirement.

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
5. Compare project instructions with Forge.
6. If they are compatible, follow both.
7. If they conflict, report the conflict in chat before affected work proceeds.
8. Do not edit, delete, weaken, discard, or silently override project rules because of a conflict.
9. Let the user decide how a conflict should be resolved for the session.

Do not indiscriminately load every documentation file. Find files that plausibly contain working instructions and inspect the relevant material.

## Conflict report

For each material conflict, explain:

- the project rule;
- the Forge rule;
- the conflict;
- the practical effect of each option.

Do not silently choose a winner.

## Approved rules

The files below are mandatory Forge rules:

1. `rules/01-project-rules.md`
2. `rules/02-non-destructive-changes.md`
3. `rules/03-comments.md`
4. `rules/04-naming.md`

Read them when Forge activates. Re-read a specific rule when its exact wording matters.

## Session behavior

After the startup audit is complete:

- apply Forge to development work;
- continue respecting applicable project rules;
- surface new rule conflicts when they become relevant;
- do not treat pre-existing non-compliance as permission to clean it up;
- keep the user in control of destructive or rule-conflicting decisions.

If the platform reloads skills per turn, use Forge whenever the current task is software-development work so these standards remain applicable.

## Completion check

Before considering a Forge-governed change complete, confirm that:

- no unresolved project-rule conflict was silently bypassed;
- no destructive cleanup occurred merely to enforce Forge;
- new comments follow the comment rule;
- new names follow the naming rule.
