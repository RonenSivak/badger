---
description: Implement a change using deep-search outputs (clarify → load → plan → execute → verify → publish)
globs:
alwaysApply: false
---

# /deep-implement — Orchestrator

Purpose:
- Use an EXISTING deep-search run as the source of truth
- Implement a change (or clone a feature) with proof + validation

Requires:
- A deep-search folder: `.cursor/deep-search/<feature>/`
  - `ARCHITECTURE-REPORT.md` (or draft)
  - `TRACE-LEDGER.md` (or `trace-ledger.md`)
  - `CHANGE-SURFACE.md` (or checklist section in report)

Workflow:
1) Clarify request until "Implementation Spec" is crisp
2) Load deep-search artifacts into working context
3) Write an implementation plan with verifiable gates
4) Execute in small diffs
5) Verify connectivity + tests/checks
6) Publish PR-ready summary + updated artifacts

Enforces:
- `.cursor/rules/deep-implement/deep-implement-laws.mdc`

Delegates to:
- `/deep-implement.clarify`
- `/deep-implement.load`
- `/deep-implement.plan`
- `/deep-implement.execute`
- `/deep-implement.verify`
- `/deep-implement.publish`

## Step 0 — Clarify (MANDATORY)
Say: “What would you like to implement, based on an existing deep-search report?”
Run `/deep-implement.clarify` until Implementation Spec is complete.

## Step 1 — Load deep-search outputs (MANDATORY)
Run `/deep-implement.load` and create:
- `.cursor/deep-implement/<task>/IMPLEMENTATION-SPEC.md`
- `.cursor/deep-implement/<task>/SCOPE.md`

## Step 2 — Plan (MANDATORY)
Run `/deep-implement.plan` and create:
- `.cursor/deep-implement/<task>/PLAN.md`
Gate: plan must include verification commands + acceptance criteria.

## Step 3 — Execute (ITERATIVE)
Run `/deep-implement.execute`.
Rules:
- keep diffs small
- update plan if reality changes
- if you hit non-local symbols, use `/octocode/research`

## Step 4 — Verify (MANDATORY before publish)
Run `/deep-implement.verify` and create:
- `.cursor/deep-implement/<task>/VALIDATION-REPORT.md`
If failing: fix + re-run verify.

## Step 5 — Publish (MANDATORY)
Run `/deep-implement.publish`:
- prints PR-ready summary in chat
- writes `.cursor/deep-implement/<task>/PR-SUMMARY.md`
- updates deep-search artifacts if needed (ledger/checklist)
