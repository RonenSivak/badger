---
description: Publish PR-ready summary to chat + file (only after verify passes)
globs:
alwaysApply: false
---

# /deep-implement.publish — Publish (Chat + File)

Hard gate:
If VALIDATION-REPORT.md has failures → STOP.

## Outputs
1) Print in chat:
- what changed
- why
- how verified (commands + key proofs)
- risks/rollout notes

2) Write:
- `.cursor/deep-implement/<task>/PR-SUMMARY.md`

Template:
- Title
- Context (link to deep-search folder)
- Change list (bullets)
- Verification (bullets)
- Risk & rollout
- Follow-ups
