---
description: Create a new Cursor workflow kit (clarify → plan → scaffold → verify → publish)
globs:
alwaysApply: false
---

# /create-kit — Orchestrator

Create a **new reusable Cursor workflow kit** (commands + rules + skills) in this repo.

This command runs a 5-step loop:
1) Clarify
2) Plan
3) Scaffold files
4) Verify wiring + frontmatter + references
5) Publish (README + “how to use”)

Delegates to:
- `/create-kit.clarify`  → `.cursor/commands/create-kit.clarify.mdc`
- `/create-kit.plan`     → `.cursor/commands/create-kit.plan.mdc`
- `/create-kit.scaffold` → `.cursor/commands/create-kit.scaffold.mdc`
- `/create-kit.verify`   → `.cursor/commands/create-kit.verify.mdc`
- `/create-kit.publish`  → `.cursor/commands/create-kit.publish.mdc`

Rules enforced:
- `.cursor/rules/create-kit-laws.mdc`
- `.cursor/rules/mdc-frontmatter-guard.mdc`

## Step 1 — Clarify (MANDATORY)
Run `/create-kit.clarify` until a “KIT SPEC” is complete.

## Step 2 — Plan (MANDATORY)
Run `/create-kit.plan` to produce:
- `.cursor/kits/<kit-name>/KIT-SPEC.md`
- `.cursor/kits/<kit-name>/FILE-MAP.md`

## Step 3 — Scaffold (MANDATORY)
Run `/create-kit.scaffold` to generate all files listed in FILE-MAP.

## Step 4 — Verify (MANDATORY)
Run `/create-kit.verify`.
If verify fails: fix + re-run verify until pass.

## Step 5 — Publish (MANDATORY)
Run `/create-kit.publish`:
- writes `.cursor/kits/<kit-name>/README.md`
- prints a short “How to use” snippet in chat

Hard-fail:
- publishing without verify pass
- missing frontmatter
- orphan command/rule references
