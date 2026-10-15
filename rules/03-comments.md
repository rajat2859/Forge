# Rule 3 — Comment Discipline

## Purpose

Keep code self-explanatory. Do not use comments to narrate code or explain obvious implementation steps.

## New and modified code

- Do not add explanatory comments that describe what a line, statement, function, component, or block does when its implementation and naming are clear.
- Do not add line-by-line narration, step-by-step explanations, AI-style summaries, or comments that restate identifiers, types, signatures, or nearby code.
- Short labels are allowed when they help identify a section or function. Keep labels brief and descriptive; do not explain the implementation.
- Examples of allowed short labels:
  - `// Testimonial Section`
  - `// URL Checker`
- Do not add decorative banners or commented-out code.
- Apply this rule to all new or modified code, including refactors, debugging, and feature work.
- Prefer clear structure, small functions, and specific names over explanatory comments.

## Existing comments

When encountering existing comments:

1. Keep useful context comments that explain a non-obvious constraint or decision.
2. Report unnecessary explanatory comments and their locations.
3. Ask for approval before removing or rewriting existing comments, unless the user explicitly requested their removal within the relevant scope.

## Allowed comments

Use comments only for:
- Brief section or function labels.
- Important context not clear from the code, such as business constraints, unusual technical decisions, compatibility workarounds, security requirements, performance trade-offs, complex algorithm rationale, external API constraints, or actionable TODO/FIXME notes.

Keep labels short. Do not write paragraphs or explain how the code works.

## Review checklist

Before completing a change, verify that:
- no unnecessary explanatory comments were added;
- short labels are brief and descriptive;
- useful context comments were preserved;
- existing comments were not silently removed unless the user approved their removal.

## Principle

Code explains what it does. Comments provide only short labels or essential non-obvious context.
