---
name: verifying-range-diff
description: "Verify that a rewritten history (e.g., split/reworded commits) preserves the intended patchset using git range-diff. Use when you rewrote commits but need confidence the diff matches the original."
---

# Verifying Range Diff

Verify that a rewritten Git history preserves the intended patchset.

## Quick Start

```bash
git range-diff <BASE>..<old-branch> <BASE>..<new-branch>
```

## When to Use

- After splitting a branch into smaller branches
- After rewording or squashing commits
- After interactive rebase
- When you suspect you lost or accidentally added changes

## Workflow Checklist

```
- [ ] Identify the base commit (merge-base)
- [ ] Run git range-diff between old and new series
- [ ] Review output for unexpected changes
- [ ] Verify all original commits are accounted for
```

## Reading the Output

```
1:  abc1234 = 1:  def5678 feat: add feature A
    (same commit, possibly rebased)

2:  ghi9012 ! 2:  jkl3456 fix: bug fix
    (commit changed - review the diff)

3:  mno7890 < -:  ------- refactor: cleanup
    (commit removed - intentional?)

-:  ------- > 3:  pqr1234 docs: update readme
    (new commit added)
```

## Examples

**Compare before/after split:**
```bash
# Original branch vs split branches combined
git range-diff main..backup-original main..split-branch-1
```

**Compare before/after rebase:**
```bash
git range-diff main..feature-backup main..feature
```

**Compare specific commit ranges:**
```bash
git range-diff abc123..def456 ghi789..jkl012
```

## Hard-fail Conditions

- Unreviewed `!` (changed) markers
- Unexpected `-` (removed) commits without explanation
- Missing commits from original series

## Related Skills

- [splitting-branches](../splitting-branches/SKILL.md) - Split large branches
- [git-branch-splitting](../git-branch-splitting/SKILL.md) - Git techniques
