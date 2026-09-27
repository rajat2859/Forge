# Rule 3 — Comment Discipline

## Purpose

Forge should keep code self-explanatory and avoid unnecessary comments.

## Do not use comments for

- obvious code behavior;
- line-by-line narration;
- comments that repeat function or variable names;
- comments that repeat TypeScript types or signatures;
- decorative section comments that add no useful context;
- AI-style explanatory comments added just to describe each step;
- commented-out dead code.

## Allowed comments

Comments are appropriate only when they provide necessary context that the code itself cannot clearly express, such as:

- non-obvious business constraints;
- unusual technical decisions;
- compatibility workarounds;
- framework or browser issues;
- security reasoning;
- performance trade-offs;
- complex algorithms;
- external API constraints;
- specific TODO or FIXME notes with actionable context.

## Existing comments

Preserve existing useful comments unless they are incorrect, outdated, or explicitly approved for removal.

If an existing comment violates Forge standards, do not remove it automatically. Follow the non-destructive change rule and report it in chat.

## Principle

Code should explain what it does. Comments should explain why something non-obvious exists.
