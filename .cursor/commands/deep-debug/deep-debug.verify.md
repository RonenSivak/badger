---
description: Validate that all report claims connect by code (imports/calls/bindings) + required checks
globs:
alwaysApply: false
---

# /deep-debug.verify — Verify ✅

Goal: write `.cursor/deep-debug/<topic>/VALIDATION-REPORT.md`

Connectivity checks (must be proven):
- import → usage
- call site → implementation
- route/RPC binding → handler
- cross-repo claim → Octocode proof (def+impl+boundary)

Outcome:
- VERIFIED EDGES list
- BROKEN CLAIMS list (with exact failing pointers)
- NOT FOUND list (with exact searches + scope)
- Required checks status:
  - unit tests (relevant subsets)
  - tsc/typecheck
  - lint
  - any repo-specific CI gates (if known)

Gate:
If verify fails → do not publish. Iterate resolve/hypothesize/fixplan until verify passes or is NOT FOUND-justified.
