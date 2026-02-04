---
name: optimizing-code
description: "Systematically simplify TypeScript/React code with staged refactors and verification. Use when asked to simplify code, reduce complexity, remove duplication, or improve maintainability."
---

# Optimizing Code

Systematically simplify TypeScript code following best practices.

## Quick Start
1. Clarify scope, goals, constraints
2. Analyze for violations and measure metrics
3. Plan refactors (quick wins first)
4. Execute one-by-one with verification
5. Verify all passes (tests/types/lint)
6. Publish before/after metrics

## Workflow Checklist
Copy and track your progress:
```
- [ ] Scope and goals clarified
- [ ] Baseline metrics measured
- [ ] Violations identified
- [ ] Refactor plan created (ordered)
- [ ] Refactors executed (one at a time)
- [ ] Tests pass after each change
- [ ] Final verification passed
- [ ] Summary published with metrics
```

## When to Use
- Code review suggests "simplify this"
- File is hard to read or maintain
- High cyclomatic complexity
- Many `any` types
- Deep nesting / arrowhead pattern
- Duplicated logic

## Core Principles

### TypeScript
- Eliminate `any` types
- Use proper type inference
- Prefer interfaces over type aliases for objects
- Use discriminated unions for state
- Avoid excessive generics

### React
- Extract reusable hooks
- Avoid prop drilling
- Use proper memoization (don't over-memo)
- Keep components focused
- Separate concerns (UI vs logic)

### General
- Single responsibility
- Early returns over nested conditions
- Meaningful names over comments
- DRY but not at all costs
- Prefer composition over inheritance

## Key Rules
- One refactor at a time
- Tests must pass after each change
- Never introduce new `any`
- Quick wins before deep cleans
- Preserve external API unless explicitly changing

## Metrics to Track
- Lines of code
- Cyclomatic complexity
- `any` type count
- Nesting depth
- Function length

## Verification Gates
- [ ] Tests pass
- [ ] TypeScript compiles
- [ ] Linter passes
- [ ] No regression in metrics

## Artifacts
- `OPTIMIZATION-SPEC.md` - Scope and goals
- `ANALYSIS-REPORT.md` - Violations and metrics
- `OPTIMIZATION-PLAN.md` - Ordered refactors
- Before/after comparison

## Detailed Principles
See guides for detailed principles:
- [optimization-principles.md](../../guides/optimization-principles.md)
