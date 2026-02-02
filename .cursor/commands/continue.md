---
description: Resume a previous session using a session-memory dump (clarify → load → verify → resume → publish)
globs: ".cursor/commands/continue/**/*.md"
alwaysApply: false
---

# /continue — Orchestrator

Resume a previous session using a memory dump created when context was getting too large.

## Enforces (rules)
- [Continue Laws](../rules/continue/continue-laws.mdc)

## Delegates to (sub-commands)
- `/continue.clarify` → `.cursor/commands/continue/continue.clarify.md`
- `/continue.load`    → `.cursor/commands/continue/continue.load.md`
- `/continue.verify`  → `.cursor/commands/continue/continue.verify.md`
- `/continue.resume`  → `.cursor/commands/continue/continue.resume.md`
- `/continue.publish` → `.cursor/commands/continue/continue.publish.md`

---

## Step 0 — Clarify (MANDATORY)

Run `/continue.clarify` to determine:
- which session memory file to load
- what outcome we want *now*

## Step 1 — Load (MANDATORY)

Run `/continue.load` to read:
- the memory dump
- any referenced artifacts (paths listed inside the dump)

## Step 2 — Verify (MANDATORY)

Run `/continue.verify` to ensure:
- the dump is coherent (objective/done/next/constraints/pointers exist)
- pointers are valid or explicitly NOT FOUND
- next steps are actionable

## Step 3 — Resume (MANDATORY)

Run `/continue.resume` to execute the next steps, or route to the correct Badger workflow if the memory indicates we should.

## Step 4 — Publish (MANDATORY)

Run `/continue.publish` to summarize what was loaded and what will happen next.

