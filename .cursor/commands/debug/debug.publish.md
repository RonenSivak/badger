---
description: Publish final debug report to chat + file (only after verify passes)
globs:
alwaysApply: false
---

# /debug.publish — Publish 📣

Hard gate:
- MUST have a passing VALIDATION-REPORT.

Write:
- `.cursor/debug/<topic>/DEBUG-REPORT.md` (final)

Also print the same report in chat.

Format (simple):
1) Executive summary (2–5 lines)
2) Findings: HIGH / MODERATE / LOW
3) Proven E2E flow (short) + pointer references
4) Root cause (or NOT FOUND with searches + scope)
5) Fix plan (from FIX-PLAN) + verification gates
6) Next actions prompt:
   - “Implement fix”
   - “Gather more evidence”
   - “Accept risk / defer”
