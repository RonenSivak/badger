---
description: Turn the proven trace into hypotheses + minimal experiments
globs:
alwaysApply: false
---

# /deep-debug.hypothesize — Hypothesis Tree 🌲

Input:
- DEBUG-SPEC
- E2E-TRACE
- trace-ledger (resolved symbols)

Output:
- `.cursor/deep-debug/<topic>/HYPOTHESES.md`

Rules:
- 3–7 hypotheses max.
- Each hypothesis must include:
  - what proven hop(s) it explains (link to trace-ledger pointers)
  - what evidence supports it
  - a minimal experiment to falsify it
  - expected outcome if true/false

Prefer experiments that:
- touch fewer repos
- validate at boundaries (network/persist/throw/render)
- produce objective signals (tests/tsc/lint/log evidence)
