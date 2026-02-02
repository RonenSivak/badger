---
name: git-branch-splitting
description: "Split a large Git branch into smaller reviewable branches using cherry-pick, selective staging, patch+stash, rebase --onto, or milestone branches. Use when you need to break a big change into multiple PRs."
---

# SKILL: Git Branch Splitting (big branch → multiple PR branches)

Split a large Git branch into smaller, reviewable branches using the appropriate technique.

---

## Technique Decision Tree

```
Is the commit bucket-pure (only touches one bucket's files)?
├── YES → Use Cherry-pick (Technique A)
└── NO (mixed commit)
    └── Are changes separable by file or hunk?
        ├── YES → Use Cherry-pick -n + Selective Staging (Technique B)
        └── NO (tangled within files)
            └── Do you need precise control over each change?
                ├── YES → Use Patch + Stash (Technique C)
                └── NO (history needs cleaning first)
                    └── Use Interactive Rebase (Technique D)

Is this bucket stacked on another bucket?
├── YES → Use Rebase --onto (Technique E)
└── NO → Use independent branching

Do milestone commits exist?
├── YES → Use Milestone Branches (Technique F)
└── NO → Use commit-based techniques above
```

---

## Technique A — Cherry-pick (clean commits)

**When:** Commits already match a bucket exactly.

```bash
git checkout <base> -b <bucket-branch>
git cherry-pick <sha1> <sha2> <sha3>
```

**Pros:** Simple, preserves commit metadata.
**Cons:** Only works for bucket-pure commits.

---

## Technique B — Cherry-pick -n + Selective Staging

**When:** Mixed commits are separable by file or hunk.

```bash
git checkout <base> -b <bucket-branch>
git cherry-pick -n <mixed-sha>    # Apply without committing
git reset HEAD                     # Unstage all
git add -p <files>                 # Stage only bucket's changes
git commit -m "<type>(<scope>): <desc>"
git checkout -- .                  # Discard unstaged
git clean -fd                      # Remove untracked
```

**Pros:** Fine-grained control per file/hunk.
**Cons:** Manual process per mixed commit.

---

## Technique C — Patch + Stash

**When:** Commits are tangled, need manual untangling with full control.

### Step 1: Create patch
```bash
git diff <base>..<source> > big.patch
```

### Step 2: Apply and stage first bucket
```bash
git checkout <base> -b <bucket1-branch>
git apply big.patch               # Apply all changes (no commit)
git add <bucket1-files>           # Stage only bucket1
git commit -m "<type>(<scope>): bucket1 changes"
```

### Step 3: Stash remainder
```bash
git stash --include-untracked --keep-index
```

### Step 4: Repeat for next bucket
```bash
git checkout <base> -b <bucket2-branch>
git stash apply                   # Restore remaining changes
git add <bucket2-files>
git commit -m "<type>(<scope>): bucket2 changes"
git stash --include-untracked --keep-index
```

### Step 5: Continue until all changes committed
```bash
git stash show  # Check what remains
```

**Pros:** Full manual control, works for any tangle level.
**Cons:** Most manual, easy to lose track.

---

## Technique D — Interactive Rebase (clean source first)

**When:** Source branch history is messy, needs cleaning before splitting.

### Step 1: Create backup
```bash
git branch backup-<source> <source>
```

### Step 2: Interactive rebase
```bash
git checkout <source>
git rebase -i <merge-base>
```

### Step 3: In editor, mark commits to split
```
pick abc123 Add feature A
edit def456 Mixed: feature B + refactor   # ← mark as "edit"
pick ghi789 Fix bug
```

### Step 4: When stopped on "edit" commit
```bash
git reset HEAD^               # Uncommit to working tree
git add -p <feature-files>    # Commit feature part
git commit -m "feat: feature B"
git add -p <refactor-files>   # Commit refactor part
git commit -m "refactor: cleanup"
git rebase --continue
```

### Step 5: Now cherry-pick clean commits to buckets
```bash
git checkout <base> -b <bucket-branch>
git cherry-pick <clean-sha1> <clean-sha2>
```

**Pros:** Cleans history permanently.
**Cons:** Rewrites history, higher complexity.

---

## Technique E — Rebase --onto (stacked PRs)

**When:** Buckets must stack (PR2 depends on PR1).

### Setup stacked branches
```bash
# PR1 branch
git checkout <base> -b <bucket1-branch>
git cherry-pick <bucket1-commits>

# PR2 branch (stacked on PR1)
git checkout <bucket1-branch> -b <bucket2-branch>
git cherry-pick <bucket2-commits>
```

### Or rebase existing branch onto new base
```bash
git rebase --onto <new-base> <old-base> <branch>
```

### After PR1 merges, rebase PR2 onto updated main
```bash
git checkout <bucket2-branch>
git rebase --onto <base> <bucket1-branch>
# or use GitHub's retarget feature
```

**Pros:** Maintains dependency chain.
**Cons:** Must rebase/retarget after each merge.

---

## Technique F — Milestone Branches

**When:** Sequential milestone commits exist that mark "done" states.

### Step 1: Find milestone commits
```bash
git log --oneline <base>..<source> | grep -i "step\|phase\|v1\|v2\|done"
```

### Step 2: Create branch at each milestone
```bash
git checkout <milestone1-sha> -b step1-branch
git checkout <milestone2-sha> -b step2-branch
```

### Step 3: Open PRs in sequence
- PR1: `step1-branch` → `main` (or `step2-branch` for stacked)
- PR2: `step2-branch` → `main` (after PR1 merges)

**Pros:** Natural boundaries, preserves full context.
**Cons:** Requires clean milestone commits.

---

## Worktrees (parallel bucket work)

**When:** Working on multiple buckets simultaneously.

### Create worktrees
```bash
git worktree add ../wt-bucket1 <bucket1-branch>
git worktree add ../wt-bucket2 <bucket2-branch>
```

### Work in each independently
```bash
cd ../wt-bucket1
# make changes, commit
cd ../wt-bucket2
# make changes, commit
```

### Clean up
```bash
git worktree remove ../wt-bucket1
git worktree remove ../wt-bucket2
```

**Pros:** No context switching, parallel work.
**Cons:** Uses disk space, can confuse IDE.

---

## rerere (reuse recorded resolution)

**When:** Same conflicts recur during rebasing.

### Enable
```bash
git config rerere.enabled true
```

### How it works
1. First conflict: you resolve manually
2. Git records the resolution
3. Same conflict later: Git auto-applies recorded resolution

### Check status
```bash
git rerere status    # Show recorded resolutions
git rerere diff      # Show pending resolutions
```

**Pros:** Saves time on repeated rebases.
**Cons:** Must review auto-applied resolutions.

---

## git cherry (track progress)

**When:** Need to verify all commits are accounted for.

### List commits in source not in target
```bash
git cherry <target-branch> <source-branch>
```

Output:
- `+ sha` = commit NOT in target (needs picking)
- `- sha` = commit already in target (skip)

### Example workflow
```bash
# After splitting, verify all accounted for
git cherry main backup-original | grep "^+"
# Should show nothing if all commits moved
```

**Pros:** Ensures nothing lost.
**Cons:** Requires understanding cherry output.

---

## Quick Reference

| Technique | Commits | Complexity | Use Case |
|-----------|---------|------------|----------|
| Cherry-pick | Pure | Low | Clean commits |
| Cherry-pick -n | Mixed (by file) | Medium | Separable hunks |
| Patch + Stash | Tangled | Medium | Manual control |
| Interactive Rebase | Messy history | High | Clean first |
| Rebase --onto | Stacked | Medium | Dependencies |
| Milestone | Sequential | Low | Natural breaks |
