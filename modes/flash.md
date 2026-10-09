# Flash Mode — Dependency-Aware Parallel Execution

## Purpose

Flash Mode accelerates large development tasks by decomposing them into independent workstreams and executing safe workstreams concurrently with multiple agents.

Flash Mode changes how work is executed. It does not change, weaken, replace, bypass, or selectively apply the active Forge rules.

## Activation

Flash Mode is explicit only.

Supported invocation:

- Claude Code: `/forge-flash <task>`
- Antigravity CLI: `/forge-flash <task>`
- OpenCode: `/forge-flash <task>`
- Codex: `$forge-flash <task>`

If Flash Mode is requested from an already active Forge session, refresh the discovered rule directory before planning the task and apply the current complete rule set.

## Mandatory rule inheritance

Before any parallel work begins, the orchestrator must:

1. Inspect the current installed `rules/` directory.
2. Discover every regular Markdown rule file directly inside it.
3. Sort discovered paths lexicographically.
4. Read the complete contents of every discovered rule file.
5. Stop before modifying the project if the directory is missing, unreadable, or contains no rule files.
6. Complete the normal project-rule discovery and conflict audit.

The `rules/` directory is the single source of truth. Do not hardcode rule filenames, a fixed rule count, or a static list of approved rules in Flash Mode. Every file currently discovered in the directory belongs to the active rule set; additions, changes, renames, and removals are reflected on the next discovery.

Every orchestrator, worker, subagent, integration agent, reviewer, verifier, or other delegated agent created by Flash Mode must receive, before starting work:

- the full contents of every currently discovered Forge rule file;
- all applicable project-specific rules discovered during the startup audit;
- every user-approved conflict resolution for the current session;
- the overall task objective;
- the delegated agent's exact scope, ownership, dependencies, and constraints.

Pass the rule contents in the delegated agent's initial instructions or context. Do not merely tell agents to follow Forge, provide only a filename list, or assume shared conversation/filesystem context. If the host uses shared context, verify that the complete rules are available before work begins. If the complete context cannot be passed or verified, do not delegate that work; report the limitation and keep the work within the capabilities that preserve the rules.

No Flash agent may be treated as exempt from Forge because it has a narrow, temporary, review-only, or verification-only role.

## Startup

Flash Mode must perform the normal Forge startup audit before development begins.

It must:

1. identify the repository or workspace root;
2. discover project-specific instruction and rule files;
3. read relevant project instructions;
4. discover and read the complete current Forge rule set;
5. compare project instructions with Forge;
6. report material conflicts in chat;
7. wait for the user's decision where a conflict affects the requested work;
8. establish the active rules for the session.

Parallel execution must not begin while a material rule conflict affecting the task remains unresolved.

## Task analysis

Before spawning workers, the orchestrator must understand the complete task and build a dependency-aware execution plan.

The plan should identify:

- required outcomes;
- major workstreams;
- dependencies between workstreams;
- files or areas likely to be touched;
- workstreams that can safely run concurrently;
- workstreams that must wait for other work;
- integration points;
- verification required before completion.

Flash Mode must not create agents merely to appear parallel.

If the task is too small or too tightly coupled for safe parallelism, keep the work serial and state that safe parallelization was not useful.

## Agent ownership

Each delegated agent must receive explicit responsibility.

At minimum, the assignment should define:

- the agent's objective;
- files, folders, modules, or responsibility area it owns;
- dependencies it must wait for;
- interfaces or contracts it must preserve;
- work it must not modify;
- the complete active Forge and project rules.

Prefer non-overlapping write ownership.

Two agents should not modify the same files concurrently unless the orchestrator explicitly coordinates the overlap.

Cross-cutting changes should remain under orchestrator or integration-agent control when that reduces conflicts.

## Dependency-aware execution

Independent workstreams should execute concurrently when the host agent supports safe parallel delegation.

Dependent work should run in waves.

Example:

```text
Wave 1
├─ Agent A: independent workstream
├─ Agent B: independent workstream
└─ Agent C: independent workstream

Wave 2
└─ Agent D: depends on A, B, or C

Wave 3
└─ Integration and review
```

Use the maximum safe concurrency supported by the host environment without introducing unnecessary overlap, coordination risk, or quality loss.

## Host capability

Use the host coding agent's native subagent, worker, task, delegation, or parallel-agent capabilities when available.

If the host does not support true parallel agents:

- do not pretend multiple agents were used;
- do not falsely report parallel execution;
- execute the dependency plan as effectively as the host allows;
- preserve the same integration, review, and verification requirements.

## Integration

Parallel worker output is not the final result.

After worker tasks complete, an integration phase must:

1. inspect all worker results;
2. reconcile interfaces and shared assumptions;
3. detect conflicting or overlapping changes;
4. resolve integration issues;
5. ensure the combined architecture remains coherent;
6. confirm the combined work follows the complete active Forge and project rules.

The integration agent or orchestrator must not blindly accept worker output.

## Review

After integration, perform a whole-task review.

The reviewer must evaluate the combined result for:

- incomplete requirements;
- regressions;
- rule violations;
- inconsistent architecture;
- duplicated or conflicting logic;
- broken imports or references;
- mismatched interfaces;
- missed edge cases;
- accidental destructive changes;
- unnecessary comments;
- unclear new naming.

The reviewer follows the same complete active Forge and project rule set as every other Flash agent.

## Verification

Before Flash Mode declares the task complete, run the relevant project checks where available, such as:

- type checking;
- linting;
- automated tests;
- build;
- targeted runtime or integration checks.

Do not skip verification merely to make Flash Mode faster.

## Completion

Flash Mode may consider the task complete only after:

- required worker tasks are complete;
- outputs are integrated;
- the combined result has been reviewed;
- applicable verification has passed or failures are clearly reported;
- no unresolved Forge/project-rule conflict was silently bypassed;
- every delegated agent received the complete active rule context before work began.

## Principle

Flash Mode achieves speed through safe parallel execution, not by skipping analysis, rules, project instructions, integration, review, or verification.
