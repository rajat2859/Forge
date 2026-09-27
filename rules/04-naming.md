# Rule 4 — Clear, Responsibility-Based Naming

## Purpose

Names should communicate intent without requiring the developer to inspect the implementation.

## Required behavior

Use clear, specific, responsibility-based names for:

- components;
- sections;
- functions;
- variables;
- booleans;
- event handlers;
- files;
- folders;
- services;
- API handlers and routes;
- utilities and helpers.

## Naming expectations

Prefer names that describe what something represents or does.

Examples:

- `HeroSection` instead of `Section1`
- `ProductGrid` instead of `Content`
- `calculateOrderTotal` instead of `process`
- `isAuthenticated` instead of `userFlag`
- `handleMenuToggle` instead of `handler`
- `paymentService` instead of `manager`

Avoid vague or generic names such as:

- `data`
- `result`
- `value`
- `temp`
- `stuff`
- `process`
- `handle`
- `section1`
- `component2`

unless the surrounding scope makes the shorter name genuinely clear.

## Naming principles

- Prefer intent over implementation details.
- Prefer clear words over unnecessary abbreviations.
- Do not make names verbose without reason.
- Boolean names should read naturally, often using prefixes such as `is`, `has`, `can`, or `should`.
- File and folder names should reflect their responsibility.
- UI section names should reflect the actual section purpose when known.

## Existing naming

If existing code uses unclear or non-compliant names, do not rename it automatically just to satisfy Forge.

Flag the issue and follow the non-destructive change rule before making broad or potentially disruptive renames.

## Principle

A good name should explain responsibility without needing an explanatory comment.
