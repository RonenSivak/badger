---
name: splitting-branches
description: "Split a large branch into smaller reviewable branches for separate PRs. Use when you have a big branch with multiple features/fixes that should be reviewed independently."
---

# Splitting Branches (Smart Branch Split)

Split a large branch into smaller, reviewable branches suitable for separate PRs.

## Quick Start
1. Clarify split goals and strategy
2. Analyze the diff and commits
3. Plan the split (technique per bucket)
4. Execute the split (create branches)
5. Verify each branch (tsc/lint/test)
6. Publish PR guide

## Workflow Checklist
Copy and track your progress:
```
- [ ] Split spec clarified (strategy, PR flow type)
- [ ] BACKUP BRANCH created (mandatory!)
- [ ] Diff analyzed (commits mapped, clusters identified)
- [ ] Split plan created (technique per bucket)
- [ ] Branches split (using planned techniques)
- [ ] ALL branches verified (tsc/lint/test/build)
- [ ] Git cherry accounting passed
- [ ] PR guide published
```

## BACKUP FIRST (MANDATORY)
Before ANY rewrite operation:
```bash
git branch backup-<branch-name>-$(date +%Y%m%d)
```

## Clustering Strategies

| Strategy | Best For |
|----------|----------|
| **Feature** | Distinct features can be isolated |
| **Module** | Changes map to package boundaries |
| **History** | Commits naturally group |
| **Milestone** | Incremental value delivery |
| **Feature-flag** | Toggle-based deployment |

## PR Flow Types

| Type | Description |
|------|-------------|
| **Independent** | Each PR can merge alone |
| **Stacked** | PRs depend on each other |
| **Feature-branch** | Merge into feature, then main |
| **Trunk-based** | Direct to main with flags |

## Split Techniques

| Technique | When to Use |
|-----------|-------------|
| `cherry-pick` | Clean commits, simple case |
| `selective-staging` | Mixed commits need splitting |
| `patch+stash` | Complex intra-file changes |
| `rebase --onto` | Moving commit ranges |

## Verification Gates (BLOCKING)
Each split branch MUST pass:
- [ ] TypeScript (`tsc --noEmit`)
- [ ] Lint
- [ ] Tests (unless CI-only)
- [ ] Build (if exists)
- [ ] `git cherry` accounting (all commits accounted)
- [ ] No cross-branch import dependencies

## Git Cherry Accounting
Verify all original commits are accounted for:
```bash
git cherry -v main backup-branch | wc -l  # Original count
# Sum of commits in split branches should match
```

## Artifacts
All outputs go to `.cursor/smart-branch-split/<topic>/`:
- `SPLIT-SPEC.md` - Goals and strategy
- `ANALYSIS.md` - Diff and cluster analysis
- `SPLIT-PLAN.md` - Technique per bucket
- `BRANCH-MAP.md` - Created branches
- `VALIDATION-REPORT.md` - Verification results

## Hard-fail Conditions
- Splitting without backup branch
- Publishing without ALL verification passing
- TypeScript errors in any split branch
- Unaccounted commits (git cherry mismatch)
- Cross-branch import dependencies

## Related Skills
- [git-branch-splitting](../git-branch-splitting/SKILL.md) - Git techniques
- [conventional-branch-naming](../conventional-branch-naming/SKILL.md) - Branch naming
- [verifying-range-diff](../verifying-range-diff/SKILL.md) - Verify rewrites
