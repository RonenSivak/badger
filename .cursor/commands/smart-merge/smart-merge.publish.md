---
description: Publish final merge-ready instructions + artifacts
globs:
alwaysApply: false
---

# /smart-merge.publish — Publish 📣

Hard gate:
- must have a PASS in `VERIFICATION.md` (or explicit NOT FOUND with searches + scope).

Write:
`.cursor/smart-merge/<name>/MERGE-READY.md`

Also print to chat:
- final recommended merge commands
- what was verified
- remaining NOT FOUND (if any) + why it’s acceptable (or block merge)
