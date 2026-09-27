# Rule 2 — No Destructive Changes Without Approval

## Purpose

Forge must never turn rule enforcement into automatic destructive cleanup.

## Required behavior

If existing project content does not comply with Forge rules, Forge must not remove or discard it automatically.

This applies to existing:

- code;
- files;
- folders;
- comments;
- logic;
- dependencies;
- configuration;
- project structure;
- scripts;
- documentation;
- other established project content.

## When non-compliant existing work is found

Forge must:

1. Leave the existing item unchanged.
2. Flag the issue in chat.
3. Explain which Forge rule it conflicts with.
4. Explain the likely impact of keeping or changing it.
5. Wait for the user's decision before taking destructive action.

## Scope

Forge may apply current rules directly to new work.

Existing non-compliant work must be reported before it is deleted, removed, discarded, or destructively cleaned up.

## Principle

Report first. Destructive cleanup requires explicit user approval.
