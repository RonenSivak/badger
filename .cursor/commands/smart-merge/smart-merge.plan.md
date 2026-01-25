---
description: Produce an explicit MERGE-PLAN.md (commands + checkpoints)
globs:
alwaysApply: false
---

# /smart-merge.plan — Plan 🗺️

Read `MERGE-SPEC.md`, produce:
`.cursor/smart-merge/<name>/MERGE-PLAN.md`

## Pre-Plan Checks (MCP-S)
Before planning, verify:
- [ ] `search_builds` — both source and target branches have passing builds
- [ ] `code_owners_for_path` — identify owners for likely conflict areas

Plan must include:
- exact git commands
- scratch branch name
- when to use merge vs rebase (per spec)
- conflict strategy (file ordering, ownership via MCP-S, patterns)
- verification commands (lint/tsc/tests)
- impact scan targets (exports/contracts/config keys)

Quality:
- steps must be copy/paste-ready
- include rollback steps
