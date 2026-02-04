# Optimizing Code Kit

Systematically simplify TypeScript and React code following best practices.

## What It Does

- Analyzes code against 12 TypeScript + 10 React principles
- Identifies violations and pain points with metrics
- Creates ordered refactor plan (quick wins first)
- Applies changes one-by-one with verification
- Suggests React Query when beneficial (asks permission first)

## Prerequisites

- TypeScript/React project
- Tests that can verify behavior preservation

## Quick Start

```
Help me optimize src/components/MyComponent.tsx
Simplify and refactor src/hooks/
Clean up packages/my-app/src/
```

## Workflow

1. **Clarify** — Define scope, goals, constraints
2. **Analyze** — Scan for violations, measure metrics
3. **Plan** — Order refactors (quick wins → deep clean)
4. **Execute** — Apply one-by-one with test verification
5. **Verify** — Confirm all tests/types/lint pass
6. **Publish** — Summary with before/after metrics

## Structure

| Type | Location | Purpose |
|------|----------|---------|
| Skill | `.cursor/skills/optimizing-code/SKILL.md` | Main entry point |
| Guide | `.cursor/guides/optimization-principles.md` | Detailed principles |

## Generated During Runs

| File | Created By |
|------|------------|
| `OPTIMIZATION-SPEC.md` | clarify |
| `ANALYSIS-REPORT.md` | analyze |
| `OPTIMIZATION-PLAN.md` | plan |

## Principles Covered

### TypeScript (12)
1. Single Responsibility
2. Clear Naming
3. Immutability
4. Guard Clauses
5. No Flag Parameters
6. Leverage Types
7. Use Built-ins
8. DRY Carefully
9. Composition
10. Separation of Concerns
11. Error Handling
12. Simple Tests

### React (10)
1. SRP Components
2. State Colocation
3. Limit Prop Drilling
4. Composition Over Conditionals
5. Custom Hooks
6. Minimal Props
7. TypeScript Safety
8. YAGNI/KISS
9. Readability
10. Design for Testing

### React Query
- Only suggests when patterns would benefit
- Checks React version FIRST to determine compatibility
- Asks permission before installing

### React Hook Form
- Detects manual form state
- Suggests when forms have 3+ fields with manual state
- Asks permission before installing
