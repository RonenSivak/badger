---
description: Verify correctness and connectivity before publish
globs:
alwaysApply: false
---

# /implement.verify — Validation

Goal:
Catch “sounds right” mistakes by proving connections and running checks.

## Inputs
- PLAN.md
- EVIDENCE.md
- deep-search TRACE-LEDGER (baseline)

## What to verify
1) Connectivity proof for each new/changed edge:
- import → usage
- call site → implementation
- route/RPC binding → handler
- config key → reader
If cross-repo: must have Octocode proof.

2) Tooling checks (use what exists in repo):
- typecheck/build
- lint
- tests relevant to change
- any required local scripts

3) Drift check vs deep-search:
- if you introduced a new dependency/surface, update:
  - deep-search trace ledger OR the implementation spec checklist

## Output (file)
Write:
- `.cursor/implement/<task>/VALIDATION-REPORT.md`

Format:
- Passed checks
- Failed checks + fixes needed
- Broken edges (with exact repo/path+lines)
- Remaining NOT FOUND (with searches + scope)
