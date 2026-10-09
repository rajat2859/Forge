# Responsive UI Verification

## Purpose

Every new or modified user-facing interface must be deliberately adapted and verified across relevant viewport sizes. Mobile responsiveness is a primary quality gate, not a secondary check. A layout that looks correct only on desktop or has merely been shrunk to fit a phone is not considered complete.

## When this rule applies

Run responsive checks whenever work changes or can affect:

- pages, sections, components, or templates;
- layout, sizing, spacing, typography, or visibility;
- navigation, menus, dialogs, forms, tables, cards, grids, or interactive controls;
- images, video, embedded content, or other media;
- CSS, styling frameworks, breakpoints, or responsive behavior.

For backend-only changes with no possible user-interface impact, responsive checks are not required.

## Mobile-first quality standard

Treat mobile as a first-class design target. Do not simply compress the desktop layout into a narrow viewport. Adapt the layout intelligently while preserving the supplied design and the project's visual identity.

When appropriate to the design and content:

- Reflow columns and grids, adjust component sizing and spacing, and change content order when it improves the mobile experience.
- Keep typography readable, headings balanced, line lengths comfortable, and content hierarchy clear.
- Make navigation, primary actions, forms, and controls easy to find and operate with touch.
- Use comfortable touch targets and adequate spacing, following platform guidance and the project's design system.
- Check hero sections, image crops, backgrounds, media, and decorative elements at phone sizes.
- Preserve important content and functionality; do not hide content merely to make a layout fit.
- Keep mobile layouts visually coherent and intentional rather than cramped, excessively tall, or inconsistently spaced.

Use supplied mobile designs or specifications when available. If only a desktop design is supplied, adapt it to mobile without inventing a different visual identity. Follow the project's design system and existing styling conventions rather than adding arbitrary overrides.

## Required verification workflow

Before declaring UI work complete:

1. Identify the pages, components, states, and user flows affected by the change.
2. Inspect the project's design specifications, CSS media queries, framework configuration, theme settings, and existing responsive conventions. Determine the actual breakpoints used by the project before choosing test widths.
3. Run the changed interface in a browser and inspect its rendered behavior. Use Agent Browser as the primary browser tool when available; use Playwright as the fallback.
4. Prioritize mobile verification. At minimum, check a narrow mobile width within 320–375 CSS pixels and a typical mobile width within 390–430 CSS pixels, in addition to relevant project-specific breakpoints. Check tablet and desktop too.
5. Test both sides of every breakpoint that can affect the changed interface: at least one width just below the breakpoint, the breakpoint itself, and one width just above it. Check transitions where layout, navigation, visibility, columns, spacing, or component behavior changes.
6. Exercise affected interactive states, including touch-based navigation menus, dropdowns, dialogs, tabs, forms, and expanded or collapsed content where applicable. Check keyboard interaction too when relevant.
7. Inspect the rendered layout for visual quality and usability, not only overflow. Where practical, capture screenshots at representative mobile widths and desktop for review. Screenshots support the checks but do not replace interaction testing.
8. Correct issues introduced by the current change, then repeat the relevant checks. Capture final evidence after fixes where practical.

Do not assume a universal breakpoint set. If the project uses a CSS framework or design system, inspect its actual configuration and use the breakpoints it defines. The values below are common reference points for selecting additional viewport checks, not a replacement for project configuration:

| Context | Common breakpoint or viewport widths |
| --- | --- |
| Narrow mobile | 320px, 360px |
| Typical mobile | 375px, 390px, 414px, 430px |
| Bootstrap-style breakpoints | 576px, 768px, 992px, 1200px, 1400px |
| Tailwind-style breakpoints | 640px, 768px, 1024px, 1280px, 1536px |
| Larger desktop | 1440px, 1600px, 1920px |

Framework defaults may be customized. Confirm the actual values in the project before testing. Do not test every reference width mechanically if it cannot affect the changed interface; prioritize the required mobile coverage, relevant configured breakpoints and transitions, target devices, and representative widths between transitions.

## What to inspect

At each relevant viewport, verify that:

- no unintended horizontal page scrolling or clipped content is present;
- text is readable, wraps correctly, and does not overlap or become truncated unexpectedly;
- headings, buttons, labels, and form fields remain visible and usable;
- navigation adapts correctly and interactive controls can be reached and operated with touch;
- touch targets are comfortable and controls have enough separation to avoid accidental activation;
- columns, grids, cards, and sections reflow in the intended order and alignment;
- images, videos, tables, and embedded content fit their containers without distortion or unintended overflow;
- spacing, alignment, component sizing, and section density remain coherent;
- fixed, sticky, absolute, and overlay elements do not cover important content or controls;
- important content and functionality remain available;
- the interface remains usable with longer realistic text and relevant empty, loading, error, or expanded states.

Do not treat a page as responsive merely because CSS media queries exist or the viewport was resized once. Verify the actual rendered result.

## Scope and non-destructive behavior

Focus fixes on issues caused by the current change. If responsive problems already existed before the work, report them separately rather than silently performing unrelated or destructive cleanup. Do not expand the task to unrelated pages or components without approval.

Do not introduce one-off overrides or duplicate breakpoint rules without checking the existing styling system and project conventions first.

## Completion gate

Responsive testing is a required completion gate for work that affects the user interface.

- Do not mark the task done, complete, finished, or verified while any required responsive check or relevant interaction test remains outstanding.
- If a check fails because of a regression introduced by the current change, fix it and repeat the relevant checks before declaring completion.
- If a pre-existing issue is discovered, document it separately and do not silently expand the scope. It does not by itself block the current task unless the change worsens it or the user approves expanding the scope.
- If a required test is blocked by unavailable tools, an inaccessible environment, or another external limitation, complete every other available check and report the task as blocked or incomplete. Never claim a verified pass or unconditional completion while required testing remains outstanding.
- If a required check cannot reasonably be completed or a failure cannot be resolved, explain the specific blocker and obtain user approval before treating the work as complete. Approval to proceed does not permit claiming that unperformed tests passed.

## Reporting and limitations

Before finishing UI work, report:

- the relevant pages or components checked;
- the viewport widths and breakpoint transitions tested;
- the interactive states tested;
- whether screenshots were captured, where practical;
- responsive issues found and fixed;
- any outstanding checks, blockers, or pre-existing issues.

Never claim that responsive verification passed if the interface was not actually inspected in a browser. Clearly distinguish code inspection from rendered-browser verification.

## Principle

Mobile must be intentionally adapted, visually inspected, and interaction-tested. A UI task is not done while required responsive testing remains outstanding, and verification must never be assumed from the implementation alone.
