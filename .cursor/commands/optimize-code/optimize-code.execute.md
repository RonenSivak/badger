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

See rules files for patterns:
- `.cursor/rules/optimize-code/ts-core-principles.mdc` - Guard clauses, discriminated unions
- `.cursor/rules/optimize-code/react-principles.mdc` - Component patterns, hooks
- `.cursor/rules/optimize-code/react-query-principles.mdc` - Query/mutation patterns

## Installing New Dependencies (if approved by user)

If user approved installing React Query:

### 1. Check React Version (CRITICAL)
```bash
# From package.json
grep '"react":' package.json
# Or from lockfile (more accurate in monorepos)
grep -A1 '"react@' yarn.lock | head -5
```

### 2. Determine Compatible Version
| React | React Query | Command |
|-------|-------------|---------|
| 16.x | v4 | `yarn add @tanstack/react-query@^4` |
| 17.x | v4 | `yarn add @tanstack/react-query@^4` |
| 18+ | v5 | `yarn add @tanstack/react-query@^5` |

**v5 requires React 18+. Using v5 with React 16/17 will fail.**

### 3. Check for Existing Transitive Dep
```bash
grep "@tanstack/react-query" yarn.lock || grep "react-query" yarn.lock
```
If found, prefer that major version to avoid peer dependency conflicts.

### 4. Install
```bash
# For monorepos, install at package level:
yarn workspace <package-name> add @tanstack/react-query@^4
# Or at root if shared:
yarn add @tanstack/react-query@^4 -W
```

### 5. Set Up QueryClient (if new)
- Create provider wrapper
- Add to app entry point

### 6. Migrate Patterns
One hook at a time, verifying tests after each

## Installing React Hook Form (if approved by user)

### 1. Check React Version
```bash
grep '"react":' package.json
```
RHF v7 works with React 16.8+. No version conflict concerns.

### 2. Check for Existing
```bash
grep "react-hook-form" yarn.lock
```

### 3. Install
```bash
# For monorepos:
yarn workspace <package-name> add react-hook-form
# Or at root:
yarn add react-hook-form
```

### 4. Optional: Add Schema Validation
```bash
# If using Zod:
yarn add @hookform/resolvers zod
# If using Yup:
yarn add @hookform/resolvers yup
```

### 5. Migrate Forms
One form at a time:
1. Replace `useState` fields with `useForm`
2. Replace `onChange` handlers with `register()`
3. Move validation to `register()` rules or schema
4. Verify form still works after each migration

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
