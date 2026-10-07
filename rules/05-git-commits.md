# Rule 5 — Git Commit Discipline

## Commit Units

A commit must represent one meaningful unit of work.

When a feature, section, component, page, service, or other clearly defined unit of functionality is created or completed, it should be committed as its own logical change.

If an existing feature, section, component, page, service, or other defined unit is later modified, that change should be committed separately from the original implementation.

Do not wait for an entire project, page, or large task to be completed before committing if meaningful independent work has already been completed.

Examples:

- Creating a feature → one commit.
- Fixing or improving that feature later → a separate commit.
- Creating a section → one commit.
- Modifying that section later → a separate commit.
- Fixing a bug in that section → a separate commit.
- Updating unrelated features → separate commits.

## Before Committing

Before creating a commit:

1. Check `git status`.
2. Inspect the relevant `git diff`.
3. Identify the files belonging to the current unit of work.
4. Stage only those related files.
5. Inspect the staged diff before committing.

Never use `git add .` or blindly stage the entire repository.

## Commit Scope

Do not include unrelated changes in a commit.

Do not commit pre-existing user changes that are unrelated to the current work.

If multiple independent changes exist, create separate commits for each meaningful unit rather than combining them.

A commit should be understandable as a single change when viewed independently.

## Commit Messages

Use Conventional Commits.

Examples:

- `feat: add product filtering`
- `fix: correct product filtering logic`
- `feat: add responsive product grid`
- `fix: correct mobile grid spacing`
- `refactor: simplify product filtering`
- `docs: update installation instructions`
- `chore: update development dependencies`

Avoid vague messages such as `updates`, `changes`, `work`, `fix stuff`, `misc`, `final`, or `done`.

The commit message must accurately describe the actual change.

## Sensitive Files

Never commit `.env` files containing secrets, API keys, access tokens, passwords, private keys, credentials, or other sensitive information.

If sensitive information is detected, stop and report it before committing.

## Existing Git History

Do not automatically amend, reset, rebase, squash, or rewrite existing commits.

These operations require explicit user approval.

If the repository is not initialized with Git, do not initialize it automatically. Ask the user first.

If Git is already initialized, preserve the existing repository and workflow.

## Commit Timing

Forge should commit when a meaningful unit of work has been completed, not merely because files were changed.

The goal is a clean, traceable history where each commit answers:

> "What meaningful change was completed here?"

A later modification to an existing feature is a new meaningful change and therefore receives its own commit.
