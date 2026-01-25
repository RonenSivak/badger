---
description: Verify each split branch is isolated and valid (diff sanity + tsc/lint/test/build), writes VALIDATION-REPORT.md
globs:
alwaysApply: false
---

# /smart-branch-split.verify — Isolation + Build Verification

Inputs:
- `SPLIT-SPEC.md`
- `BRANCH-MAP.md`

**Hard rule: No publishing unless ALL verification checks pass.**

---

## Phase 1: Discover Verification Commands

Before running checks, discover what commands are available in the workspace.

### Step 1.1: Detect Workspace Type
```bash
# Check for monorepo tooling
ls package.json turbo.json nx.json lerna.json 2>/dev/null
```

### Step 1.2: Extract Available Scripts
For each affected package, extract scripts from `package.json`:
```bash
# Get scripts from package.json
cat <package-path>/package.json | jq '.scripts | keys'
```

### Step 1.3: Build Verification Command List
Look for these scripts (in priority order):

| Check Type | Common Script Names |
|------------|---------------------|
| **TypeScript** | `tsc`, `typecheck`, `type-check`, `types` |
| **Lint** | `lint`, `eslint`, `lint:fix` |
| **Test** | `test`, `test:unit`, `jest` |
| **Build** | `build`, `compile`, `bundle` |

Record discovered commands in `VERIFICATION-COMMANDS.md`:
```markdown
## Package: @scope/package-name
- tsc: `yarn workspace @scope/package-name tsc --noEmit`
- lint: `yarn workspace @scope/package-name lint`
- test: `yarn workspace @scope/package-name test`
- build: `yarn workspace @scope/package-name build`
```

---

## Phase 2: Isolation Checks (per branch)

For EACH branch in `BRANCH-MAP.md`:

### 2.1: Diff Scope Verification
```bash
git checkout <branch>
git diff --name-only <BASE>..<branch>
```
- **PASS**: All files match bucket's declared directories/globs
- **FAIL**: Files outside declared scope found

### 2.2: Base Verification
```bash
git merge-base <BASE> <branch>
```
- **PASS**: Branch is cleanly based on `<BASE>`
- **FAIL**: Branch has unexpected ancestry

### 2.3: No Cross-Branch Dependencies
- Verify branch doesn't import/depend on changes from other split branches
- Check for import paths that would break if other branch isn't merged

---

## Phase 3: Verification Command Execution (per branch)

For EACH branch, run verification commands for ALL affected packages.

### 3.1: Identify Affected Packages
```bash
git diff --name-only <BASE>..<branch> | cut -d'/' -f1-2 | sort -u
```

### 3.2: Run Verification Suite
For each affected package, execute in order:

#### A) TypeScript Check (REQUIRED)
```bash
# Yarn workspaces
yarn workspace <package-name> tsc --noEmit

# Or direct
cd <package-path> && npx tsc --noEmit
```
**Must pass. Type errors = FAIL.**

#### B) Lint Check (REQUIRED)
```bash
yarn workspace <package-name> lint
# Or
cd <package-path> && npm run lint
```
**Must pass. Lint errors = FAIL.**

#### C) Test Check (REQUIRED if tests exist)
```bash
yarn workspace <package-name> test
# Or
cd <package-path> && npm test
```
**Must pass. Test failures = FAIL.**

#### D) Build Check (REQUIRED if build script exists)
```bash
yarn workspace <package-name> build
# Or
cd <package-path> && npm run build
```
**Must pass. Build errors = FAIL.**

### 3.3: Handle Environment Issues
If tests require CI environment variables (common in Wix projects):
```bash
# Try with mock CI vars
ARTIFACT_VERSION=1.0.0 SRC_MD5=local BUILD_ID=local yarn workspace <pkg> test
```

If still fails due to env:
- Mark as `SKIP (CI env required)`
- Note in report that CI will verify
- NOT a blocking failure

---

## Phase 4: Generate Validation Report

Write `VALIDATION-REPORT.md`:

```markdown
# Validation Report: <topic>

## Summary
| Branch | Isolation | TypeScript | Lint | Tests | Build | Status |
|--------|-----------|------------|------|-------|-------|--------|
| branch-1 | ✅ | ✅ | ✅ | ✅ | ✅ | **PASS** |
| branch-2 | ✅ | ✅ | ✅ | ⚠️ SKIP | N/A | **PASS** |

## Branch: <branch-name>

### Isolation
- Scope: <package-path>
- Files changed: <count>
- Out-of-scope files: NONE | <list>

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
- Result: PASS | FAIL | N/A (no build script)
- Errors: <if any>

## Overall Status: PASS | FAIL

## Blocking Issues
<list any failures that must be fixed>

## Non-Blocking Notes
<list skipped checks with reasons>
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

---

## Output

- `VALIDATION-REPORT.md` — full verification results
- Updated `COMMAND-LOG.md` — all commands executed
