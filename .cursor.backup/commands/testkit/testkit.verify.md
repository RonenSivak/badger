---
description: Verify BDD compliance + correctness + run lint/tsc/tests with an auto-repair loop
globs:
alwaysApply: false
---

# /testkit.verify — Validate ✅🔁

Hard Gate:
- Must run `/testkit.preflight` first and record `PREFLIGHT.md`.

## Verify = Run + Repair Loop (MANDATORY)
1) Run the full check suite (repo canonical):
- lint
- typecheck/tsc
- tests

2) If any fails:
- DO NOT publish
- enter Repair Loop:
  - fix the failure (types, imports, missing builders, bad testkit usage, wrong paths)
  - rerun ONLY the failed command
  - repeat until PASS or you hit an external blocker

3) External blocker handling:
If the command cannot be run due to environment constraints:
- mark as `NOT RUN`
- include the reason
- include the exact command that must be run by the dev
- include scope (workspace/package)

## Output (MANDATORY)
Write `.cursor/testkit/<feature>/VALIDATION-REPORT.md`:
- commands run (exact)
- PASS/FAIL per command
- if repaired: list failures + fixes + rerun results
- if NOT RUN: reason + required command + scope
