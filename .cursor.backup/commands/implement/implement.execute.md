---
description: Execute the plan in small diffs, escalate to Octocode for non-local symbols
globs:
alwaysApply: false
---

# /implement.execute — Implementation Loop

Rules:
- Make the smallest safe change per iteration.
- If plan changes, update PLAN.md immediately.
- Any non-local symbol or cross-repo claim → `/octocode/research`.

## Loop
For each step in PLAN.md:
1) Implement step
2) Add/adjust tests (if needed for acceptance)
3) Update evidence notes:
- `.cursor/implement/<task>/EVIDENCE.md`
  - repo/path + lines + snippet for each new claim/edge

## Escalation trigger (mandatory)
If you can’t prove a symbol/edge in the current workspace within 2 hops:
- run `/octocode/research`
- paste query + result pointers into EVIDENCE.md

## Output
Keep changes minimal. Don’t do drive-by refactors.
