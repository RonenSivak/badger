---
description: Produce a fix plan (no code yet) with verification gates and rollback
globs:
alwaysApply: false
---

# /debug.fixplan — Fix Plan 🧩

Output:
- `.cursor/debug/<topic>/FIX-PLAN.md`

Rules:
- Do NOT implement code here.
- Provide:
  1) Proposed fix (smallest safe change)
  2) Why it addresses the winning hypothesis (proof pointers)
  3) Change surface checklist (repos/packages touched)
  4) Verification gates (exact commands/tests; must be objective)
  5) Rollback plan (what to revert/disable/flag)

If the fix affects contracts/SDKs:
- include the contract chain steps (source IDL → generated → runtime binding).
