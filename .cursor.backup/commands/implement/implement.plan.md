---
description: Produce an implementation plan with verifiable gates
globs:
alwaysApply: false
---

# /implement.plan — Plan Mode

Rule:
No coding before plan is approved by the agent itself (self-check) and is verifiable.

## Inputs
- IMPLEMENTATION-SPEC.md
- SCOPE.md

## Plan format (must match)
1) Summary (what we’re changing)
2) Files & surfaces to touch (grouped by repo/package)
3) Step-by-step plan (small diffs)
4) Verification gates per step
5) Rollback plan (how to revert safely)
6) Risk register (top 3 couplings) + mitigation

## Verification gates (must include)
- compile/typecheck
- lint (if exists)
- unit/integration tests
- “connectivity proof”: imports/calls/bindings for any new/edited edge
- if touching SDK/clients: prove generator source + runtime transport using `/octocode/research`

## Output
Write:
- `.cursor/implement/<task>/PLAN.md`
