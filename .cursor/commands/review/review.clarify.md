---
description: Clarify what to review + constraints; produce Review Spec
globs:
alwaysApply: false
---

# /review.clarify — Clarification Loop

Ask:
1) “What should I review?” (pick one)
   - PR link / PR number
   - branch name
   - commit range
   - diff already open in editor

2) “What’s the goal?”
   - merge safety
   - architecture correctness
   - regression risk
   - readiness for release
   - test coverage gaps

3) “Any constraints?”
   - files/packages to focus or ignore
   - performance/security concerns
   - backward compatibility requirements

Stop when you can write **Review Spec**:

Write: `.cursor/review/<target>/REVIEW-SPEC.md`

Template:
- Target:
- Goal:
- Scope includes:
- Out of scope:
- Must-answer questions:
- Mandatory verification commands (if known):
- Breadcrumbs (endpoints/types/config keys/error codes):
