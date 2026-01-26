---
description: Apply refactors one-by-one with verification between each
globs:
alwaysApply: false
---

# /optimize-code.execute — Apply Refactors

Apply each refactor from the plan, verifying after each change.

## Input
- `OPTIMIZATION-PLAN.md` (from plan)

## Execution Rules (from optimize-code-laws.mdc)

1. **One refactor at a time** — Never batch multiple changes
2. **Verify after each** — Tests must pass, types must compile
3. **Preserve behavior** — No functional changes, only structural
4. **Document as you go** — Note what was changed

## Execution Loop

```
FOR each refactor in OPTIMIZATION-PLAN:
  1. Read the target code
  2. Apply the refactor
  3. Run: type-check (tsc --noEmit or equivalent)
  4. Run: tests (if available)
  5. IF tests fail:
     - Revert
     - Note issue
     - Continue to next refactor
  6. Mark refactor as DONE
```

## Refactor Techniques Reference

See `.cursor/rules/optimize-code/ts-simplification-principles.mdc` for:
- Guard clause patterns
- Discriminated union examples
- Extract function patterns
- Built-in method replacements

## Progress Tracking

Update `OPTIMIZATION-PLAN.md` in-place:
- [x] Completed refactors
- [ ] Pending refactors
- [SKIP] Skipped (with reason)

## Gate
- Tests MUST pass after each refactor
- Type-check MUST pass after each refactor
- If a refactor breaks tests, REVERT and SKIP

## Next Step
When all refactors applied (or skipped), instruct: "Run `/optimize-code.verify`."
