---
description: Output summary report with before/after comparison
globs:
alwaysApply: false
---

# /optimize-code.publish — Summary Report

Generate final summary of the optimization session.

## Input
- `OPTIMIZATION-SPEC.md` (goals)
- `ANALYSIS-REPORT.md` (before)
- `OPTIMIZATION-PLAN.md` (what was planned vs done)
- Verify results (after)

## Output Format

Print to chat:

```markdown
## Optimization Complete

### Target
<file or directory>

### Goals Achieved
- [x] Readability improved
- [x] Type safety improved
- [ ] Performance (not targeted)

### Metrics Improvement
| Metric | Before | After | Improvement |
|--------|--------|-------|-------------|
| Lines | X | Y | -Z (-N%) |
| any count | X | Y | -Z |
| Max nesting | X | Y | -Z levels |
| Max function length | X | Y | -Z lines |

### Changes Applied
1. <refactor description>
2. <refactor description>
...

### Skipped (if any)
- <refactor>: <reason>

### Recommendations
- <future improvement suggestion>
- <related files that could benefit>
```

## Cleanup (Optional)

If user confirms, delete working files:
- `.cursor/optimize-code/<target>/OPTIMIZATION-SPEC.md`
- `.cursor/optimize-code/<target>/ANALYSIS-REPORT.md`
- `.cursor/optimize-code/<target>/OPTIMIZATION-PLAN.md`

Or keep for reference.

## Done
Optimization complete. No further steps.
