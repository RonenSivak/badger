---
description: Verify connectivity + run validation commands; must include key consumers from Consumer Matrix
globs:
alwaysApply: false
---

# /review.verify — Connectivity + Consumer Verification

Inputs:
- REVIEW-PACKET.draft.md
- trace-ledger.md
- CONSUMER-MATRIX.md

A) Connectivity verification (MANDATORY)
- verify edges connect by import/call/binding evidence
- ensure Octocode proof exists for cross-repo dependencies

B) Consumer Verification (MANDATORY if Consumer Matrix non-empty)
For each "High risk" consumer in CONSUMER-MATRIX.md:
- run its minimal verification set (typecheck/lint/tests) OR document why it cannot be run
- if cannot run, require stronger static proof (Octocode: usage sites + guards + fallback behavior)

C) Repo verification (MANDATORY)
Run standard commands (install immutable/frozen, lint, typecheck, tests).
Fix failures and re-run until green or blocked.

Write: `.cursor/review/<target>/VERIFICATION.md`
- Verified edges count
- Consumers verified (commands + result)
- Broken claims fixed
- Remaining NOT FOUND (with searches + scope)
