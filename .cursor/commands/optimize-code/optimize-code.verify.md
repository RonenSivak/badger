---
description: Run tests, type-check, lint, and measure improvement
globs:
alwaysApply: false
---

# /optimize-code.verify — Final Verification

Verify all changes and measure improvement.

## Input
- `ANALYSIS-REPORT.md` (baseline metrics)
- `OPTIMIZATION-PLAN.md` (what was done)
- Modified source files

## Verification Checklist

### 1. Type Check
```bash
npx tsc --noEmit
# or project-specific command
```
- [ ] No type errors

### 2. Lint Check
```bash
npm run lint
# or: npx eslint <target>
```
- [ ] No new lint errors

### 3. Test Suite
```bash
npm test
# or project-specific command
```
- [ ] All tests pass
- [ ] No coverage regression

### 4. Measure Final Metrics

Re-measure the same metrics from analyze:
| Metric | Before | After | Change |
|--------|--------|-------|--------|
| Lines | X | Y | -Z |
| Functions | X | Y | +/-Z |
| Max function length | X | Y | -Z |
| any count | X | Y | -Z |
| Max nesting | X | Y | -Z |

## Gate Requirements

All must pass:
- [ ] Type-check passes
- [ ] Lint passes (or no new errors)
- [ ] Tests pass
- [ ] No behavior changes (manual sanity check if needed)

## Verification Result

```
VERIFY: PASS / FAIL

If FAIL:
- Issue: <description>
- Action: <fix or revert>
```

## Next Step
When PASS, instruct: "Run `/optimize-code.publish`."
