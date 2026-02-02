---
description: Resume execution based on the verified resume plan or route to the appropriate Badger workflow
globs:
alwaysApply: false
---

# /continue.resume — Resume

Goal: continue work from the verified resume plan, without re-introducing lost context.

## Inputs

- `.cursor/continue/<topic>/RESUME-PLAN.md`

## Steps (MANDATORY)

1) If RESUME-PLAN is `NEEDS-CLARIFICATION`:
- ask the minimal clarifying questions
- update the resume plan before doing work

2) If RESUME-PLAN is PASS:
- execute the next steps in order
- if the plan indicates a canonical Badger workflow should be used (e.g. “run /deep-search” / “run /rnd”), delegate to that orchestrator rather than improvising

3) Maintain constraints from the dump:
- if an MCP was SKIPPED earlier, keep degraded-mode constraints (NOT FOUND discipline)
- do not silently change strategy

