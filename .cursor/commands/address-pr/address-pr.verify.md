---
description: Verify analysis correctness + static analysis; produce VERIFICATION.md
globs:
alwaysApply: false
---

# /address-pr.verify — Verification

Input:
- `.cursor/address-pr/<pr-number>/ACTION-PLAN.md`
- `.cursor/address-pr/<pr-number>/ANALYSIS.md`

## Verification Steps

### A) Completeness Check
- [ ] All comments from COMMENTS.md accounted for in TRIAGE.md
- [ ] All actionable comments have entries in ANALYSIS.md
- [ ] All FIX actions have concrete file + line targets

### B) Static Analysis (for style claims)
Run linters to verify style-related claims:

```bash
# ESLint for JS/TS
npx eslint {files} --format json

# TypeScript type check
npx tsc --noEmit

# Prettier check
npx prettier --check {files}
```

Record which claims are validated by tooling.

### C) Cross-Repo Proof Check
For each non-local symbol in ANALYSIS.md:
- [ ] Octocode proof exists (repo + file + line + snippet)
- [ ] Contract/interface documented

### D) Edge Connectivity
Verify that proposed changes connect properly:
- [ ] Imports resolve
- [ ] Types align
- [ ] No circular dependencies introduced

### E) Test Coverage Check
```bash
# Check if affected files have tests
# Check if proposed changes would break existing tests
npm test -- --findRelatedTests {files} --passWithNoTests
```

## Output

Write: `.cursor/address-pr/<pr-number>/VERIFICATION.md`

Template:
```markdown
# Verification Results

## Status: {PASS|FAIL}

## Completeness
- Comments total: {n}
- Triaged: {n} ✓
- Analyzed: {n} ✓
- Planned: {n} ✓

## Static Analysis

### ESLint
- Files checked: {list}
- Errors: {count}
- Warnings: {count}
- Relevant to comments: {yes/no}

### TypeScript
- Status: {pass/fail}
- Errors: {list if any}

## Cross-Repo Proofs
| Symbol | Repo | File:Line | Verified |
|--------|------|-----------|----------|
| {name} | {repo} | {path}:{line} | ✓ |

## Blockers
{list any blocking issues or "None"}

## Ready for Publish: {YES|NO}
```

If PASS: instruct "Run `/address-pr.publish`."
If FAIL: list what needs fixing, then re-verify.
