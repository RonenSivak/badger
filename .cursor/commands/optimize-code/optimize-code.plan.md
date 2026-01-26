---
description: Create ordered optimization plan with quick wins first
globs:
alwaysApply: false
---

# /optimize-code.plan — Refactor Planning

Create an ordered list of refactors based on analysis. Produce `OPTIMIZATION-PLAN.md`.

## Input
- `ANALYSIS-REPORT.md` (from analyze)
- `OPTIMIZATION-SPEC.md` (for constraints)

## Planning Rules

1. **Quick wins first** — Low risk, high clarity improvement
2. **One refactor per item** — Atomic, testable changes
3. **Dependencies ordered** — If B depends on A, A comes first
4. **Risk assessment** — Flag anything that might break behavior

## Refactor Categories

### Quick Wins (do first)
- Remove dead code
- Rename unclear identifiers
- Add guard clauses / early returns
- Replace manual loops with built-ins
- Extract obvious helper functions

### Medium Effort
- Introduce discriminated unions
- Extract components/hooks
- Simplify conditionals
- Add type guards

### Deep Clean (do last, if time allows)
- Restructure for testability (DI)
- Split large files/modules
- Introduce Result types for errors
- Major architectural changes

## Output

Create `.cursor/optimize-code/<target>/OPTIMIZATION-PLAN.md`:

```markdown
# OPTIMIZATION-PLAN

## Summary
- Quick wins: X items
- Medium effort: X items
- Deep clean: X items
- Estimated changes: X

## Ordered Refactors

### Quick Wins
| # | Refactor | Location | Risk | Principle |
|---|----------|----------|------|-----------|
| 1 | <action> | <line/function> | Low | #X |

### Medium Effort
| # | Refactor | Location | Risk | Principle |
|---|----------|----------|------|-----------|
| X | <action> | <line/function> | Med | #X |

### Deep Clean (optional)
| # | Refactor | Location | Risk | Principle |
|---|----------|----------|------|-----------|
| X | <action> | <line/function> | High | #X |

## Constraints Check
- [ ] All refactors preserve public API (if required)
- [ ] Scope matches spec (quick-wins only / full)
```

## Next Step
When complete, instruct: "Run `/optimize-code.execute`."
