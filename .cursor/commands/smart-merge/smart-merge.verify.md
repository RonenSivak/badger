---
description: Verify build correctness + blast-radius scan before merge
globs:
alwaysApply: false
---

# /smart-merge.verify — Verify ✅

Goal: prove the merge is safe.

Write:
`.cursor/smart-merge/<name>/VERIFICATION.md`

Must include:
1) **Required checks** (from MERGE-SPEC): lint / typecheck / tests.
2) **Connectivity check**: changed exports/config/contracts → find all consumers.
   - local consumers: repo search + callsites
   - non-local consumers: MUST use `/octocode/research` and record proof
3) **Regression scan**: look for “same pattern” implementations and ensure merge aligns.

Output:
- PASS/FAIL
- failing commands + logs summary
- list of impacted symbols + confirmed consumers
