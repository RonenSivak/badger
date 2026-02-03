---
description: Implement UI from Figma URL or semantic description using Wix Design System
globs:
alwaysApply: false
---

# /implement-ui — Orchestrator

Create UI components from Figma designs or semantic descriptions using Wix Design System (WDS).

## Input Modes

| Mode | Input | Verification |
|------|-------|--------------|
| **Figma** | Figma URL with node-id | Visual screenshot comparison |
| **Semantic** | Natural language | Requirements checklist |

## Required MCPs

- `wix-design-system-mcp` (always)
- `cursor-ide-browser` (Figma mode verification)
- `octocode` (pattern search)

## Enforces

- `.cursor/rules/implement-ui/implement-ui-laws.mdc`
- `.cursor/rules/implement-ui/wds-mandate.mdc`
- `.cursor/rules/shared/010-octocode-mandate.mdc`
- `.cursor/rules/shared/001-proof-discipline.mdc`

## Delegates To

- `/implement-ui.clarify`
- `/implement-ui.analyze`
- `/implement-ui.plan`
- `/implement-ui.implement`
- `/implement-ui.verify`
- `/implement-ui.publish`

---

## Step 0 — Clarify (MANDATORY)

Run `/implement-ui.clarify` until UI-SPEC is complete.

Outputs:
- `.cursor/implement-ui/<task>/UI-SPEC.md`

---

## Step 1 — Analyze (MANDATORY)

Run `/implement-ui.analyze`.

- Figma mode: Extract design specs from URL
- Semantic mode: Parse requirements into UI tasks

---

## Step 2 — Plan (MANDATORY)

Run `/implement-ui.plan`.

Outputs:
- `.cursor/implement-ui/<task>/COMPONENT-MAP.md`

Gate: Must map all UI elements to WDS components (or flag as custom).

---

## Step 3 — Implement (ITERATIVE)

Run `/implement-ui.implement`.

Rules:
- Use WDS components from COMPONENT-MAP
- Follow WDS dos/don'ts
- Keep components small and composable
- Type all props with TypeScript

---

## Step 4 — Verify (MANDATORY before publish)

Run `/implement-ui.verify`.

Outputs:
- `.cursor/implement-ui/<task>/VERIFICATION-REPORT.md`

If failing: fix + re-run verify.

---

## Step 5 — Publish (MANDATORY)

Run `/implement-ui.publish`.

- Prints summary in chat
- Lists files created/modified
- Shows how to use the component
