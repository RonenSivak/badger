---
description: Systematically simplify TypeScript code following best practices
globs:
alwaysApply: false
---

# /optimize-code — Orchestrator

Simplify TypeScript code by applying 12 core principles and 30+ refactoring techniques from the "Best Practices for Simplifying TypeScript Code" guide.

## Workflow

```
clarify → analyze → plan → execute → verify → publish
```

## Step 1 — Clarify (MANDATORY)
Run `/optimize-code.clarify` to gather:
- Target files/directories
- Optimization goals (readability, type-safety, performance)
- Constraints (preserve API, time budget)

Output: `OPTIMIZATION-SPEC.md`

## Step 2 — Analyze (MANDATORY)
Run `/optimize-code.analyze` to:
- Scan for violations of 12 core principles
- Measure baseline metrics (lines, complexity, any-count)
- Identify pain points

Output: `ANALYSIS-REPORT.md`

## Step 3 — Plan (MANDATORY)
Run `/optimize-code.plan` to:
- Create ordered refactor list
- Flag quick wins vs deep cleans
- Estimate risk per refactor

Output: `OPTIMIZATION-PLAN.md`

## Step 4 — Execute (MANDATORY)
Run `/optimize-code.execute` to:
- Apply refactors one-by-one
- Verify tests pass after each change
- Loop until plan complete

## Step 5 — Verify (MANDATORY)
Run `/optimize-code.verify` to:
- Run full test suite
- Type-check
- Measure improvement metrics

## Step 6 — Publish (MANDATORY)
Run `/optimize-code.publish` to:
- Output before/after comparison
- List applied changes
- Provide recommendations

## Rules Enforced
- `.cursor/rules/optimize-code/optimize-code-laws.mdc`
- `.cursor/rules/optimize-code/ts-core-principles.mdc`
- `.cursor/rules/optimize-code/react-principles.mdc`
- `.cursor/rules/optimize-code/react-query-principles.mdc`
- `.cursor/rules/optimize-code/react-hook-form-principles.mdc`

## Example Usage
```
/optimize-code src/components/MyComponent.tsx
/optimize-code src/utils/
```
