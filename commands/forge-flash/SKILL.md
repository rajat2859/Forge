---
name: forge-flash
description: Forge execution mode for large software-development tasks that benefit from dependency-aware parallel agents. Runs the normal Forge startup audit, applies every approved Forge rule to every delegated agent, parallelizes independent workstreams, integrates results, reviews the combined change, and verifies completion.
---

# Forge Flash

Forge Flash is the parallel execution entry point for Forge.

Use it for large development tasks that can be decomposed into independent or partially independent workstreams.

## Required startup

Before development:

1. Identify the repository or workspace root.
2. Read `rules/01-project-rules.md`.
3. Read `rules/02-non-destructive-changes.md`.
4. Read `rules/03-comments.md`.
5. Read `rules/04-naming.md`.
6. Read `rules/05-git-commits.md`.
7. Read `modes/flash.md`.
8. Perform the normal Forge project-rule discovery and conflict audit.
9. Establish the complete active rule set before delegating work.

## Hard inheritance requirement

Every orchestrator, worker, subagent, integration agent, reviewer, and verifier created during Forge Flash must receive and obey:

- all five approved Forge rules;
- applicable project rules;
- user-approved conflict resolutions for the session;
- the overall task objective;
- its exact delegated scope.

Flash Mode never weakens or replaces Forge rules.

## Execution

Follow `modes/flash.md` as the source of truth for:

- task decomposition;
- dependency planning;
- parallel worker ownership;
- safe concurrency;
- integration;
- whole-task review;
- verification;
- completion.

If the host does not support true parallel agents, do not pretend that it does. Preserve the Flash workflow as far as the host supports it.
