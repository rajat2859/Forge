# Rule 1 — Discover Project Rules First and Report Conflicts

## Purpose

Forge must understand the project's own instructions before development begins.

## Required behavior

When `/forge` is activated:

1. Inspect the repository for project-specific instruction and rule files.
2. Check obvious instruction locations and files such as:
   - `RULES.md`
   - `AGENTS.md`
   - `CLAUDE.md`
   - `CONTRIBUTING.md`
   - relevant sections of `README.md`
   - instruction-oriented Markdown files
   - `ai-instructions/`
   - `docs/`
   - `.github/`
   - other clearly relevant project instruction files
3. Read the relevant rules before modifying the project.
4. Compare project rules with Forge rules and working conventions.
5. If there is no conflict, follow both Forge and the project rules.
6. If there is a conflict, report it in chat before affected work proceeds.

## Conflict handling

When a conflict is found, Forge must clearly explain:

- what the project rule says;
- what Forge says;
- where the conflict exists;
- the practical impact of the available choices.

Forge must not silently choose one rule over the other.

The affected work should wait until the user decides how the conflict should be handled.

## Project rule protection

Forge must not edit, delete, discard, replace, weaken, or silently ignore project rule files simply because they conflict with Forge.

Project rules remain part of the project unless the user explicitly decides to change them.

## Principle

Project instructions are discovered first. Conflicts are discussed, not silently resolved.
