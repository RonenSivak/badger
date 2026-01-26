---
description: Publish split outcome (summary + PR guide + cleanup checklist), only after verify passes
globs:
alwaysApply: false
---

# /smart-branch-split.publish — Summary + Artifacts

Precondition:
`VALIDATION-REPORT.md` exists and overall status is **PASS**.

> ⚠️ **Law:** Do not publish if any blocking check failed.

---

## Step 1 — Verify Precondition

Check `VALIDATION-REPORT.md`:
- Overall Status must be PASS
- No blocking issues listed

If FAIL: instruct to fix and re-run verify.

---

## Step 2 — Generate PR Creation Guide

Based on `SPLIT-PLAN.md` PR flow type:

### Independent PRs
```markdown
## PR Creation Order
PRs can be created and merged in any order.

1. Create PR: `<branch1>` → `main`
   - Title: <suggested title>
   - Reviewers: <suggested reviewers>

2. Create PR: `<branch2>` → `main`
   ...
```

### Stacked PRs
```markdown
## PR Creation Order (MUST follow this order)

1. Create PR: `<branch1>` → `main`
   - Title: <suggested title>
   - Label: "1/N - merge first"
   - After merge: delete branch

2. Create PR: `<branch2>` → `<branch1>`
   - Title: <suggested title>
   - Label: "2/N - depends on #1"
   - After PR1 merges: retarget to `main`
   - Then merge

3. Continue for remaining branches...

### Retargeting Guide
After PR1 merges:
1. Go to PR2 on GitHub
2. Click "Edit" next to base branch
3. Change from `<branch1>` to `main`
4. Resolve any conflicts if needed
5. Merge when ready
```

### Feature Branch Flow
```markdown
## PR Creation Order

1. Create feature branch: `feature/<topic>`
   ```bash
   git checkout main -b feature/<topic>
   git push -u origin feature/<topic>
   ```

2. Create PRs targeting feature branch:
   - PR: `<branch1>` → `feature/<topic>`
   - PR: `<branch2>` → `feature/<topic>`
   ...

3. After all merged to feature branch:
   - Create final PR: `feature/<topic>` → `main`
   - This PR shows complete feature
```

### Trunk-Based + Feature Flags
```markdown
## PR Creation Order

1. Create PRs (all target main, all behind flag):
   - PR: `<branch1>` → `main` (flag: <flag-name>)
   - PR: `<branch2>` → `main` (flag: <flag-name>)
   ...

2. After all merged:
   - Create flag removal PR
   - Or enable flag in production config
```

---

## Step 3 — Generate Cleanup Checklist

```markdown
## Post-Merge Cleanup

### Branches to Delete
After all PRs merged:
- [ ] `backup-<source>-YYYYMMDD` (keep until confident, then delete)
- [ ] `<split-branch-1>`
- [ ] `<split-branch-2>`
- [ ] Original source branch (if no longer needed)
- [ ] Feature branch (if used)

### Worktrees to Remove
- [ ] `git worktree remove ../wt-<bucket1>`
- [ ] `git worktree remove ../wt-<bucket2>`

### Feature Flags to Remove (if applicable)
- [ ] Flag: `<flag-name>` — remove after full feature verified in production

### Files to Clean Up
- [ ] `.cursor/smart-branch-split/<topic>/` — archive or delete after project complete

### Verify Integration
- [ ] All features work together in main
- [ ] No regressions introduced
- [ ] Feature flag behavior correct (if used)

### Communication
- [ ] Update issue tracker
- [ ] Notify reviewers PRs are ready
- [ ] Announce feature completion (if applicable)
```

---

## Step 4 — Write FINAL-SUMMARY.md

```markdown
# Split Summary: <topic>

## Overview
- Source branch: `<source>`
- Base branch: `<base>`
- Split into: <N> branches
- PR flow: <type>

## Branches Created
| Branch | Purpose | PR Target | Status |
|--------|---------|-----------|--------|
| <branch1> | <description> | main | Ready |
| <branch2> | <description> | main | Ready |

## Verification Results
- All checks: PASS
- See `VALIDATION-REPORT.md` for details

## PR Creation Guide
<see Step 2 output>

## Cleanup Checklist
<see Step 3 output>

## Files Generated
- `SPLIT-SPEC.md` — inputs and constraints
- `ANALYSIS.md` — diff/commit analysis
- `CLUSTERS.md` — proposed buckets
- `MIXED-COMMITS.md` — commits needing split
- `SPLIT-PLAN.md` — execution plan
- `BRANCH-MAP.md` — created branches
- `COMMAND-LOG.md` — all commands
- `VALIDATION-REPORT.md` — verification results
- `FINAL-SUMMARY.md` — this file
```

---

## Step 5 — Print Chat Summary

Print concise summary in chat (not full files):

```
## Split Complete: <topic>

**Branches created:** <N>
**PR flow:** <type>
**Status:** ✅ Ready for PRs

### Next Steps
1. Create PRs in this order:
   - `<branch1>` → `main`
   - `<branch2>` → `main`
   ...

2. After merge, run cleanup:
   - Delete backup branch
   - Remove worktrees
   - Clean up feature flags (if used)

### Files
All artifacts in: `.cursor/smart-branch-split/<topic>/`

### Quick Verify (re-run if needed)
```bash
yarn workspace <pkg> tsc --noEmit && yarn workspace <pkg> lint
```
```

---

## Output

- `.cursor/smart-branch-split/<topic>/FINAL-SUMMARY.md`
- Chat summary (concise, not full dump)

Do NOT dump full logs in chat — keep logs in files.
