---
description: Publish a concise summary of what was loaded and what will happen next
globs:
alwaysApply: false
---

# /continue.publish — Publish

Goal: output a compact summary so the user can confirm we resumed the correct session.

## Inputs

- `.cursor/continue/<topic>/CONTINUE-SPEC.md`
- `.cursor/continue/<topic>/LOADED-MEMORY.md`
- `.cursor/continue/<topic>/RESUME-PLAN.md`

## Output (MANDATORY)

Print in chat:
- selected memory file
- current objective
- top 3 next steps
- any constraints (missing/skipped MCPs)

