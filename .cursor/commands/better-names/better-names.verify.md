---
description: Verify rename correctness via type-check, tests, and lint
globs:
alwaysApply: false
---

# /better-names.verify — Verification

Verify the rename was successful and nothing is broken.

## Verification Checks

### 1. TypeScript Compilation

```bash
npx tsc --noEmit | tail -20
```

Expected: No errors related to renamed symbol.

### 2. Test Suite

```bash
npm test -- --testPathPattern="<affected-files>" | tail -50
```

Expected: All tests pass.

### 3. ESLint

```bash
npx eslint <affected-files> | tail -20
```

Expected: No naming rule violations.

### 4. Orphaned String References

```bash
# Search for old name in strings
rg "<oldName>" --type ts --type json | tail -20
```

Expected: No matches (except intentional ones like translation keys for different purposes).

### 5. Semantic Integrity Check

Verify:
- [ ] All inheritance chains intact
- [ ] All interface implementations intact
- [ ] All type aliases resolve
- [ ] All generic constraints valid

## Output

```
## VERIFICATION RESULT

| Check | Status |
|-------|--------|
| TypeScript compilation | ✓ PASS / ✗ FAIL |
| Tests | ✓ PASS / ✗ FAIL |
| ESLint | ✓ PASS / ✗ FAIL |
| Orphaned references | ✓ PASS / ✗ FAIL |
| Semantic integrity | ✓ PASS / ✗ FAIL |

Overall: PASS / FAIL
```

## If FAIL

1. Identify the failure cause
2. Fix the issue
3. Re-run verification

## Next Step

If PASS: run `/better-names.publish`.
If FAIL: fix issues, re-verify.
