---
description: Clarify what to implement (turn request into an Implementation Spec)
globs:
alwaysApply: false
---

# /implement.clarify — Clarification Loop

Goal:
Turn a vague request into a crisp Implementation Spec tied to an existing deep-search run.

Ask only what’s needed. Prefer checklists. Iterate until complete.

## Required inputs (fill all)
1) Deep-search feature folder:
- `.cursor/deep-search/<feature>/` = ?

2) Intent:
- bugfix | add capability | clone feature | refactor with behavior preserved | remove/deprecate

3) Target outcome:
- What should work differently? (1–3 bullets)

4) Acceptance criteria (verifiable):
- tests to add/update
- observable behavior
- error/edge cases

5) Constraints:
- backward compatibility? feature flag? rollout?
- performance/caching concerns?
- forbidden areas (don’t touch X)

6) Scope boundaries:
- what repos/services are in scope (from deep-search checklist)
- what is explicitly OUT of scope

## Output
When done, write a Search-Spec-like block:

- Feature folder:
- Change summary:
- Acceptance criteria:
- In-scope surfaces:
- Out-of-scope:
- Verification commands:
- Risky couplings (from deep-search pitfalls):
