---
description: Scan code for violations, measure metrics, identify pain points
globs:
alwaysApply: false
---

# /optimize-code.analyze — Code Analysis

Scan target code against the 12 core principles. Produce `ANALYSIS-REPORT.md`.

## Input
- `OPTIMIZATION-SPEC.md` (from clarify)

## Analysis Checklist

### Metrics to Measure
- [ ] Total lines of code
- [ ] Function count
- [ ] Max function length (lines)
- [ ] Cyclomatic complexity (estimate)
- [ ] `any` type count
- [ ] Nesting depth (max levels)

### TypeScript Principle Violations to Detect

| # | Principle | What to Look For |
|---|-----------|------------------|
| 1 | Single Responsibility | Functions doing multiple things, "and" in names |
| 2 | Clear Naming | Vague names (`data`, `obj`, `handle`), acronyms |
| 3 | Immutability | Mutations, `.push()`, reassignments |
| 4 | Reduce Nesting | Deep if/else, arrowhead pattern |
| 5 | No Flag Params | Boolean parameters, mode switches |
| 6 | Leverage Types | `any`, missing discriminated unions |
| 7 | Use Built-ins | Manual loops instead of `.map`/`.filter` |
| 8 | DRY Carefully | Duplicated code blocks |
| 9 | Composition | Deep inheritance, class hierarchies |
| 10 | Separation | Mixed concerns (UI + data + logic) |
| 11 | Error Handling | Nested try/catch, swallowed errors |
| 12 | Simple Tests | (if test file exists) Multiple assertions per test |

### React-Specific Violations (for .tsx files)

| # | Principle | What to Look For |
|---|-----------|------------------|
| R1 | SRP Components | Component doing fetch + state + complex UI |
| R2 | State Colocation | Global store for local UI state |
| R3 | Prop Drilling | Props passed through 3+ levels unused |
| R4 | Conditional Bloat | Large if/else blocks in JSX |
| R5 | Hook Duplication | Same useEffect pattern in multiple components |
| R6 | Props Overload | 10+ props, many optional/related |
| R7 | Missing Types | Props typed as `any` or missing interface |
| R8 | Over-engineering | Redux for simple state, factories for one use |
| R9 | Clever JSX | Complex ternaries/logic inside JSX return |
| R10 | Missing Boundaries | No ErrorBoundary, side effects in render |

## Output

Create `.cursor/optimize-code/<target>/ANALYSIS-REPORT.md`:

```markdown
# ANALYSIS-REPORT

## Baseline Metrics
| Metric | Value |
|--------|-------|
| Lines | X |
| Functions | X |
| Max function length | X |
| any count | X |
| Max nesting | X |

## Violations Found

### High Priority
- [ ] <violation + location + principle #>

### Medium Priority
- [ ] <violation + location + principle #>

### Low Priority
- [ ] <violation + location + principle #>

## Pain Points
1. <description>
2. <description>

## Quick Wins Identified
- <quick fix that can be done immediately>
```

## Gate
- MUST identify at least one pain point OR explicitly state "No issues found - code follows principles"

## Next Step
When complete, instruct: "Run `/optimize-code.plan`."
