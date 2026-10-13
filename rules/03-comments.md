# Rule 3 — Comment Discipline

## Purpose

Keep code self-explanatory. Comments must not narrate code or explain obvious implementation steps.

## New and modified code

- Do not add comments that describe what a line, statement, function, component, or block of code does when the code is understandable from its implementation and naming.
- Do not add line-by-line narration, step-by-step explanations, AI-style summaries, or comments that merely restate identifiers, types, signatures, or nearby code.
- Do not add decorative section headers or commented-out code.
- Apply this standard to every new or modified code area, including code generated during refactoring, debugging, or feature work.
- Do not add explanatory comments just to make generated code look more documented. Prefer clear structure, small functions, and specific names.

## Existing comments

When encountering existing comments that only explain what the code does, repeat nearby code, or provide unnecessary narration:

1. Identify them as non-compliant with this rule.
2. Report the relevant locations and why the comments are unnecessary.
3. Ask for the user's approval before removing or rewriting them.
4. Leave them unchanged until approval is given.

Do not treat a request to write or modify code as automatic approval to perform broad comment cleanup. If the user explicitly asks to remove explanatory comments, remove the non-compliant comments within the requested scope.

## Allowed comments

Comments are appropriate when they explain important context that is not clear from the code itself, including:

- non-obvious business constraints;
- the reasoning behind an unusual technical decision;
- compatibility workarounds or framework/browser issues;
- security requirements or threat assumptions;
- meaningful performance trade-offs;
- complex algorithms whose rationale is not evident from the implementation;
- external API constraints;
- actionable TODO/FIXME notes with specific context.

Prefer explaining why a constraint or decision exists rather than narrating the mechanics of the code.

## Review checklist

Before completing a change, inspect the changed code for comments and verify that:

- no unnecessary explanatory comments were introduced;
- existing useful comments were preserved;
- existing non-compliant comments were reported instead of silently removed, unless the user approved their removal.

## Principle

Code should explain what it does. Comments should explain only the non-obvious why.
