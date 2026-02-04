---
description: Verify the loaded memory is coherent and produce an actionable resume plan
globs:
alwaysApply: false
---

# /continue.verify — Verify + Resume Plan

Goal: ensure the memory dump provides a trustworthy execution plan, and identify any missing prerequisites before resuming.

## Inputs

- `.cursor/continue/<topic>/LOADED-MEMORY.md`

## Checks (MANDATORY)

1) Required sections exist (or are explicitly empty):
- objective
- done
- next
- constraints
- pointers

2) Next steps are actionable:
- each step has a concrete action (file/path/command)
- flag ambiguous steps (needs clarification)

3) Constraints are explicit:
- if MCPs are required for the resumed work and appear missing/not active, you MUST prompt the user before proceeding (same policy as `/rnd.preflight`).

## Output (MANDATORY)

Write `.cursor/continue/<topic>/RESUME-PLAN.md`:
- PASS/NEEDS-CLARIFICATION
- next-step checklist (ordered)
- risks/assumptions (ideally none)
- missing prerequisites (if any)

