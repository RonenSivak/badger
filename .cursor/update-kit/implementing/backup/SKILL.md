---
name: implementing
description: "Implement changes using deep-search artifacts as the source of truth. Use when you have a deep-search report and need to implement a feature, fix, or clone safely with proof and validation."
---

# Implementing

Use an existing deep-search run as the source of truth to implement changes with proof + validation.

## Prerequisites
A deep-search folder must exist: `.cursor/deep-search/<feature>/`
- `ARCHITECTURE-REPORT.md` (or draft)
- `trace-ledger.md`
- Change surface identified

## Quick Start
1. Clarify the implementation request
2. Load deep-search artifacts into context
3. Write an implementation plan with verifiable gates
4. Execute in small diffs
5. Verify connectivity + tests/checks
6. Publish PR-ready summary

## Workflow Checklist
Copy and track your progress:
```
- [ ] Implementation spec clarified
- [ ] Deep-search artifacts loaded
- [ ] Plan written with verification gates
- [ ] Implementation executed (small diffs)
- [ ] Verification passed (tests/tsc/lint)
- [ ] PR summary published
```

## Step Details

### 1. Clarify
Ask: "What would you like to implement, based on an existing deep-search report?"
Until Implementation Spec is complete (scope, acceptance criteria, boundaries).

### 2. Load
Create working artifacts:
- `.cursor/implement/<task>/IMPLEMENTATION-SPEC.md`
- `.cursor/implement/<task>/SCOPE.md`

### 3. Plan
Create plan with:
- Verification commands
- Acceptance criteria
- Files to modify
- Edge cases
Output: `.cursor/implement/<task>/PLAN.md`

### 4. Execute
- Keep diffs small
- Update plan if reality changes
- Use Octocode for non-local symbols

### 5. Verify
Run verification gates:
- [ ] Tests pass (new + existing)
- [ ] TypeScript compiles
- [ ] Linter passes
- [ ] Connected edges proven
Output: `.cursor/implement/<task>/VALIDATION-REPORT.md`

### 6. Publish
- Print PR-ready summary in chat
- Write `.cursor/implement/<task>/PR-SUMMARY.md`
- Update deep-search artifacts if needed

## Hard-fail Conditions
- Publishing without passing verification
- Non-local symbols without Octocode proof
- Implementing without loading deep-search context

## Detailed Guidance
- See [verify-checklist.md](../../guides/verify-checklist.md) for verification
- See [octocode-patterns.md](../../guides/octocode-patterns.md) for cross-repo resolution
