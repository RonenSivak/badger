---
description: Publish review results to chat + final files (simple triage + next actions)
globs:
alwaysApply: false
---

# /review.publish — SIMPLE Output + Files

Pre-req:
- `/review.verify` PASS

Inputs:
- CONFORMANCE.md
- CONSUMER-MATRIX.md
- VERIFICATION.md
- REVIEW-PACKET.md (final)

Chat output format (MANDATORY):
1) Issues Found
- HIGH: bullet list (each with 1-line fix)
- MODERATE: bullet list
- LOW: bullet list

2) What I did (short)
- conformance scan (N golden examples)
- impact sweep (N consumers)
- verification results (what ran, what passed)
- remaining NOT FOUND (if any)

3) What do you want to do next?
Options:
[A] Fix HIGH now
[B] Fix HIGH + MODERATE
[C] Ignore item(s) with rationale (I’ll record it)
[D] Escalate to owner/team
[E] Add guardrails (flag/compat layer) + tests
[F] Re-run with wider scope (more repos/services)

Files:
- Write FINAL packet to `.cursor/review/<target>/REVIEW-PACKET.md`
- Keep all supporting artifacts
