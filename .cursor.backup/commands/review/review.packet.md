---
description: Draft a review packet with proof pointers (file/lines/snippets)
globs:
alwaysApply: false
---

# /review.packet — Review Packet Draft (FILE-ONLY)

Inputs:
- REVIEW-SPEC.md
- SCAN.md
- trace-ledger.md

Write: `.cursor/review/<target>/REVIEW-PACKET.draft.md`

Format:
1) Summary (what changed)
2) E2E impact (what flows change, who consumes it)
3) Major risks (each with repo/path + lines + snippet)
4) Correctness notes (invariants, edge cases, backward compat)
5) Tests (existing coverage + missing cases)
6) Suggested fixes (minimal patches)
7) NOT FOUND (with searches + scope)

Rule:
- Every non-trivial statement gets a code pointer.
- Do NOT publish to chat in this step.
