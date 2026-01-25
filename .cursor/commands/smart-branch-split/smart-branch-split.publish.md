---
description: Publish the split outcome (chat summary + final files), only after verify passes
globs:
alwaysApply: false
---

# /smart-branch-split.publish — Summary + Artifacts

Precondition:
`VALIDATION-REPORT.md` exists and all branches are PASS (unless spec explicitly allows exceptions).

Write/Update:
- `.cursor/smart-branch-split/<topic>/FINAL-SUMMARY.md`

Print to chat:
- branches created (names + intent)
- ordering notes (stacked vs independent)
- any remaining NOT READY branches and why
- next actions:
  - open PRs in order
  - recommended reviewers per bucket (if known)
  - how to re-run verify quickly

Do not dump huge logs in chat — keep logs in files.
