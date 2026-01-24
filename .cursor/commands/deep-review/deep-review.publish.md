---
description: Publish the final review to chat + write the final packet (only after verify passes)
globs:
alwaysApply: false
---

# /deep-review.publish — Publish Final

Pre-req:
- VERIFICATION.md exists and is PASS (or explicitly lists remaining NOT FOUND with searches + scope)

Do:
1) Produce final chat output:
   - Summary
   - Top risks + proofs
   - Required changes before merge
   - Test gaps
   - Verification status (commands run + result)
   - Remaining NOT FOUND (if any)

2) Write `.cursor/deep-review/<target>/REVIEW-PACKET.md` (final)
3) Keep it high-signal, reviewer-ready.
