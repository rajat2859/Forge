---
name: forge-flash
description: Forge execution mode for large software-development tasks that benefit from dependency-aware parallel agents. Runs the normal Forge startup audit, dynamically discovers and reads every Forge rule, passes the complete active rule set to every delegated agent, parallelizes independent workstreams, integrates results, reviews the combined change, and verifies completion.
---

# Forge Flash

Forge Flash is the parallel execution entry point for Forge.

Use it for large development tasks that can be decomposed into independent or partially independent workstreams.

## Required startup

Before development:

1. Identify the repository or workspace root.
2. Discover all regular Markdown rule files directly inside the installed `rules/` directory.
3. Sort the discovered rule paths lexicographically and read the complete contents of every file.
4. If the directory is missing, unreadable, or contains no rule files, stop before modifying the project and explain the problem.
5. Read `modes/flash.md`.
6. Perform the normal Forge project-rule discovery and conflict audit.
7. Establish the complete active Forge and project rule context before delegating work.

Do not hardcode rule filenames or counts in this entry point. The current contents of `rules/` determine the active Forge rule set.

## Hard inheritance requirement

Before any delegated agent begins work, the orchestrator must pass it the complete active context:

- the full contents of every discovered Forge rule file;
- applicable project rules and instructions;
- user-approved conflict resolutions for the session;
- the overall task objective;
- the delegated agent's exact scope, ownership, and constraints.

Include the actual rule contents in each delegated agent's initial instructions or context. Do not assume that an agent can access the orchestrator's conversation, inherits its files automatically, or will independently discover the same installed rules. If the host has a reliable shared-context mechanism, verify that the agent receives the complete content before it starts. If the context cannot be passed or verified, do not start that delegated work; report the limitation and continue only in a way that preserves the rule requirements.

Every orchestrator, worker, subagent, integration agent, reviewer, and verifier must receive the complete discovered rule set. When a rule is added, changed, renamed, or removed, discover the current directory contents again before a new Flash task and pass that current set to all delegated agents.

Flash Mode never weakens, replaces, or selectively applies Forge rules.

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
