---
description: Verify each split branch (isolation + tsc + lint + test + build + git cherry accounting), writes VALIDATION-REPORT.md
globs:
alwaysApply: false
---

# /smart-branch-split.verify — Isolation + Build Verification

Inputs:
- `SPLIT-SPEC.md`
- `SPLIT-PLAN.md`
- `BRANCH-MAP.md`
- `ANALYSIS.md` (for original commit count)

**Hard rule: No publishing unless ALL verification checks pass.**

---

## Phase 1: Discover Verification Commands

Before running checks, discover what commands are available.

### Step 1.1: Detect Workspace Type
```bash
ls package.json turbo.json nx.json lerna.json 2>/dev/null
```

### Step 1.2: Extract Available Scripts
For each affected package:
```bash
cat <package-path>/package.json | jq '.scripts | keys'
```

### Step 1.3: Build Verification Command List

| Check Type | Common Script Names |
|------------|---------------------|
| **TypeScript** | `tsc`, `typecheck`, `type-check`, `types` |
| **Lint** | `lint`, `eslint`, `lint:fix` |
| **Test** | `test`, `test:unit`, `jest` |
| **Build** | `build`, `compile`, `bundle` |

Record in `VERIFICATION-COMMANDS.md`.

---

## Phase 2: Isolation Checks (per branch)

For EACH branch in `BRANCH-MAP.md`:

### 2.1: Diff Scope Verification
```bash
git checkout <branch>
git diff --name-only <BASE>..<branch>
```
- **PASS**: All files match bucket's declared scope
- **FAIL**: Files outside declared scope found

### 2.2: Base Verification
```bash
git merge-base <BASE> <branch>
```
- **PASS**: Branch is cleanly based on `<BASE>`
- **FAIL**: Branch has unexpected ancestry

### 2.3: Cross-Branch Import Dependencies
Check if branch imports code from other split branches:
```bash
# For TypeScript/JavaScript
grep -r "from '\.\./.*<other-bucket-dir>" --include="*.ts" --include="*.tsx"
```
- **PASS**: No cross-branch dependencies
- **WARN**: Dependencies exist → document as stacking requirement

---

## Phase 3: Git Cherry Accounting (NEW)

Verify all commits from source branch are accounted for.

```bash
# List commits in source not in any split branch
git cherry <combined-branches> <backup-branch>
```

Or compare counts:
```bash
# Original commit count (from ANALYSIS.md)
ORIGINAL_COUNT=<from analysis>

# Total commits across all split branches
SPLIT_COUNT=$(for b in <branches>; do git log --oneline <BASE>..$b | wc -l; done | paste -sd+ | bc)

# Should roughly match (may differ due to squashing)
```

- **PASS**: All commits accounted for
- **FAIL**: Commits missing → investigate which are lost

---

## Phase 4: Verification Command Execution (per branch)

For EACH branch, run verification for ALL affected packages.

### 4.1: Identify Affected Packages
```bash
git diff --name-only <BASE>..<branch> | cut -d'/' -f1-2 | sort -u
```

### 4.2: Run Verification Suite

#### A) TypeScript Check (REQUIRED)
```bash
yarn workspace <package-name> tsc --noEmit
# Or: cd <package-path> && npx tsc --noEmit
```
**Must pass. Type errors = FAIL.**

#### B) Lint Check (REQUIRED)
```bash
yarn workspace <package-name> lint
# Or: cd <package-path> && npm run lint
```
**Must pass. Lint errors = FAIL.**

#### C) Test Check (REQUIRED if tests exist)
```bash
yarn workspace <package-name> test
# Or: cd <package-path> && npm test
```
**Must pass. Test failures = FAIL.**

#### D) Build Check (REQUIRED if build script exists)
```bash
yarn workspace <package-name> build
# Or: cd <package-path> && npm run build
```
**Must pass. Build errors = FAIL.**

### 4.3: Handle Environment Issues
If tests require CI environment:
```bash
ARTIFACT_VERSION=1.0.0 SRC_MD5=local BUILD_ID=local yarn workspace <pkg> test
```

If still fails due to env:
- Mark as `SKIP (CI env required)`
- Note in report that CI will verify
- NOT a blocking failure

---

## Phase 5: rerere Status Check

If rerere was used during split:
```bash
git rerere status
git rerere diff
```

Document any recorded resolutions for future reference.

---

## Phase 6: Generate Validation Report

Write `VALIDATION-REPORT.md`:

```markdown
# Validation Report: <topic>

## Summary
| Branch | Isolation | TypeScript | Lint | Tests | Build | Cherry | Status |
|--------|-----------|------------|------|-------|-------|--------|--------|
| branch-1 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | **PASS** |
| branch-2 | ✅ | ✅ | ✅ | ⚠️ SKIP | N/A | ✅ | **PASS** |

## Git Cherry Accounting
- Original commits: <count>
- Accounted commits: <count>
- Status: PASS | FAIL

## Branch: <branch-name>

### Isolation
- Scope: <package-path>
- Files changed: <count>
- Out-of-scope files: NONE | <list>
- Cross-branch dependencies: NONE | <list>

### TypeScript
- Command: `yarn workspace @scope/pkg tsc --noEmit`
- Result: PASS | FAIL
- Errors: <if any>

### Lint
- Command: `yarn workspace @scope/pkg lint`
- Result: PASS | FAIL
- Errors: <if any>

### Tests
- Command: `yarn workspace @scope/pkg test`
- Result: PASS | FAIL | SKIP (reason)
- Failures: <if any>

### Build
- Command: `yarn workspace @scope/pkg build`
- Result: PASS | FAIL | N/A
- Errors: <if any>

## Overall Status: PASS | FAIL

## Blocking Issues
<list any failures that must be fixed>

## Non-Blocking Notes
<list skipped checks with reasons>

## rerere Status
<any recorded resolutions>
```

---

## Verification Checklist

Before marking verification complete:

- [ ] All branches checked out and verified
- [ ] TypeScript passes on ALL branches
- [ ] Lint passes on ALL branches
- [ ] Tests pass (or explicitly skipped with reason)
- [ ] Build passes (if applicable)
- [ ] No isolation violations
- [ ] Git cherry accounting passes
- [ ] Cross-branch dependencies documented
- [ ] `VALIDATION-REPORT.md` written
- [ ] All commands logged in `COMMAND-LOG.md`

---

## Failure Handling

### If TypeScript fails:
1. Read error messages
2. Fix type errors in the branch
3. Amend commit
4. Re-run verification

### If Lint fails:
1. Run `lint --fix` if available
2. Fix remaining issues manually
3. Amend commit
4. Re-run verification

### If Tests fail:
1. Identify failing tests
2. Determine if failure is:
   - Code bug → fix and amend
   - Missing dependency from other branch → note as stacking requirement
   - Environment issue → mark as SKIP

### If Build fails:
1. Check for missing dependencies
2. Check for import errors
3. Fix and amend

### If Git Cherry shows missing commits:
1. Identify missing commit SHAs
2. Determine if intentionally dropped or forgotten
3. Cherry-pick to appropriate branch if needed

---

## Output

- `VALIDATION-REPORT.md` — full verification results
- Updated `COMMAND-LOG.md` — all commands executed

When PASS, instruct: "Run `/smart-branch-split.publish`"
When FAIL, instruct: "Fix issues and re-run `/smart-branch-split.verify`"
