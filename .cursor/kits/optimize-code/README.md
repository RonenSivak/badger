# /optimize-code Kit

Systematically simplify TypeScript and React code following best practices from comprehensive guides.

## What It Does

- Analyzes code against 12 TypeScript + 10 React principles
- Identifies violations and pain points with metrics
- Creates ordered refactor plan (quick wins first)
- Applies changes one-by-one with verification
- Suggests React Query when beneficial (asks permission first)

## Prerequisites

- TypeScript/React project
- Tests that can verify behavior preservation

## Install

Copy to your project:
```
.cursor/commands/optimize-code.md
.cursor/commands/optimize-code/
.cursor/rules/optimize-code/
.cursor/skills/optimize-code/
```

## Quick Start

```
/optimize-code <file-or-directory>
```

Examples:
```
/optimize-code src/components/MyComponent.tsx
/optimize-code src/hooks/
/optimize-code packages/my-app/src/
```

## Workflow

1. **Clarify** — Define scope, goals, constraints
2. **Analyze** — Scan for violations, measure metrics
3. **Plan** — Order refactors (quick wins → deep clean)
4. **Execute** — Apply one-by-one with test verification
5. **Verify** — Confirm all tests/types/lint pass
6. **Publish** — Summary with before/after metrics

## Files

### Commands
| File | Purpose |
|------|---------|
| `optimize-code.md` | Orchestrator |
| `optimize-code.clarify.md` | Scope definition |
| `optimize-code.analyze.md` | Violation detection |
| `optimize-code.plan.md` | Refactor ordering |
| `optimize-code.execute.md` | Apply changes |
| `optimize-code.verify.md` | Final verification |
| `optimize-code.publish.md` | Summary report |

### Rules
| File | Purpose |
|------|---------|
| `optimize-code-laws.mdc` | Workflow gates |
| `ts-core-principles.mdc` | 12 TypeScript principles |
| `react-principles.mdc` | 10 React principles |
| `react-query-principles.mdc` | TanStack Query patterns |

### Skills
| File | Purpose |
|------|---------|
| `SKILL.md` | Quick reference |

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
- React 16/17 → installs v4, React 18+ → installs v5
- Asks permission before installing
- Checks lockfile for existing transitive deps to avoid conflicts
