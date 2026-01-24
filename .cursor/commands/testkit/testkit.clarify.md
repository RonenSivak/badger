---
description: Clarify what tests to write and constraints (BDD driver/builder/WDS)
globs:
alwaysApply: false
---

# /testkit.clarify — Clarify Loop 🧠

Collect a “Test Spec” (keep iterating until complete):

## A) Target
- Component/module under test:
- File paths (if known):
- Public behavior to test (bullets):

## B) Test matrix
- Happy paths:
- Edge cases:
- Error/empty states:
- Table-driven cases (if any):

## C) Constraints (hard)
- Must use: Driver pattern (given/when/get)
- Must use: WDS testkits (no `@testing-library/react` events)
- Must use: Builders (no inline literals)
- If Ambassador builders exist → MUST use them

## D) Output
Write:
`.cursor/testkit/<feature>/TEST-SPEC.md`

If anything missing, ask 1–3 questions max per turn.
