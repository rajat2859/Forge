# Responsive UI Verification

## Purpose

Every new or modified user-facing interface must be checked at relevant viewport sizes. A layout that looks correct only at one screen width is not considered verified.

## When this rule applies

Run responsive checks whenever work changes or can affect:

- pages, sections, components, or templates;
- layout, sizing, spacing, typography, or visibility;
- navigation, menus, dialogs, forms, tables, cards, grids, or interactive controls;
- images, video, embedded content, or other media;
- CSS, styling frameworks, breakpoints, or responsive behavior.

For backend-only changes with no possible user-interface impact, responsive checks are not required.

## Required verification workflow

Before declaring UI work complete:

1. Identify the pages, components, states, and user flows affected by the change.
2. Inspect the project's design specifications, CSS media queries, framework configuration, theme settings, and existing responsive conventions. Determine the actual breakpoints used by the project before choosing test widths.
3. Run the changed interface in a browser and inspect its rendered behavior. Use Agent Browser as the primary browser tool when available; use Playwright as the fallback.
4. Test relevant mobile, tablet, laptop, and desktop widths. Use the project's specified target devices and viewport sizes when available.
5. Test both sides of every breakpoint that can affect the changed interface: at least one width just below the breakpoint, the breakpoint itself, and one width just above it. Check transitions where layout, navigation, visibility, columns, spacing, or component behavior changes.
6. Exercise affected interactive states, including navigation menus, dropdowns, dialogs, tabs, forms, and expanded or collapsed content where applicable.
7. Correct issues introduced by the current change, then repeat the relevant checks.

Do not assume a universal breakpoint set. If the project uses a CSS framework or design system, inspect its actual configuration and use the breakpoints it defines. The values below are common reference points for selecting additional viewport checks, not a replacement for project configuration:

| Context | Common breakpoint or viewport widths |
| --- | --- |
| Narrow mobile | 320px, 360px |
| Typical mobile | 375px, 390px, 414px, 430px |
| Bootstrap-style breakpoints | 576px, 768px, 992px, 1200px, 1400px |
| Tailwind-style breakpoints | 640px, 768px, 1024px, 1280px, 1536px |
| Larger desktop | 1440px, 1600px, 1920px |

Framework defaults may be customized. Confirm the actual values in the project before testing. Do not test every reference width mechanically if it cannot affect the changed interface; prioritize all relevant configured breakpoints, their transitions, the project's target devices, and representative widths between transitions.

## What to inspect

At each relevant viewport, verify that:

- no unintended horizontal page scrolling or clipped content is present;
- text is readable, wraps correctly, and does not overlap or become truncated unexpectedly;
- headings, buttons, labels, and form fields remain visible and usable;
- navigation adapts correctly and interactive controls can be reached and operated;
- columns, grids, cards, and sections reflow in the intended order and alignment;
- images, videos, tables, and embedded content fit their containers without distortion or unintended overflow;
- spacing, alignment, and component sizing remain coherent;
- fixed, sticky, absolute, and overlay elements do not cover important content or controls;
- touch targets and spacing remain usable on touch-sized screens;
- the interface remains usable with longer realistic text and relevant empty, loading, error, or expanded states.

Do not treat a page as responsive merely because CSS media queries exist or the viewport was resized once. Verify the actual rendered result.

## Scope and non-destructive behavior

Focus fixes on issues caused by the current change. If responsive problems already existed before the work, report them separately rather than silently performing unrelated or destructive cleanup. Follow the non-destructive change rule before removing or substantially rewriting existing content.

Do not introduce one-off overrides or duplicate breakpoint rules without checking the existing styling system and project conventions first.

## Reporting and limitations

Before finishing UI work, report:

- the relevant pages or components checked;
- the viewport widths and breakpoint transitions tested;
- the interactive states tested;
- responsive issues found and fixed;
- any checks that could not be performed and why.

Never claim that responsive verification passed if the interface was not actually inspected in a browser. If browser testing is unavailable, state that limitation clearly and distinguish code inspection from rendered-browser verification.

## Principle

Responsive behavior is verified in the browser across relevant screen sizes and breakpoint transitions; it is not assumed from the implementation.
