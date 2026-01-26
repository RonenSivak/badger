---
description: Execute the split using techniques from SPLIT-PLAN.md (writes BRANCH-MAP.md + COMMAND-LOG.md)
globs:
alwaysApply: false
---

# /smart-branch-split.split — Create Split Branches

Inputs:
- `SPLIT-SPEC.md`
- `SPLIT-PLAN.md`
- `CLUSTERS.md`
- `MIXED-COMMITS.md`

Skills:
- `.cursor/skills/git-branch-splitting/SKILL.md` (techniques)
- `.cursor/skills/conventional-branch-naming/SKILL.md` (naming)

---

## Step 0 — Pre-flight

### Enable rerere
```bash
git config rerere.enabled true
```

### Verify backup exists
```bash
git branch | grep "backup-"
```
> ⚠️ **Law:** If no backup, STOP and run `/smart-branch-split.analyze` first.

### Verify clean working directory
```bash
git status --short
```

---

## Step 1 — Create Branches

For each bucket in SPLIT-PLAN.md:
```bash
git switch <base>
git switch -c <bucket-branch-name>
```

Use naming from `.cursor/skills/conventional-branch-naming/SKILL.md`.

Record all branches in `BRANCH-MAP.md`.

---

## Step 2 — Move Changes (per technique from SPLIT-PLAN.md)

### Technique A — Cherry-pick (clean commits)

When commits are bucket-pure:
```bash
git checkout <bucket-branch>
git cherry-pick <sha1> <sha2> <sha3>
```

### Technique B — Cherry-pick -n + Selective Staging

When commits are mixed but separable by file/hunk:
```bash
git checkout <bucket-branch>
git cherry-pick -n <mixed-sha>
git reset HEAD  # Unstage all
git add -p <files-for-this-bucket>  # Stage only what belongs
git commit -m "<type>(<scope>): <desc>"
git checkout -- .  # Discard leftovers
git clean -fd  # Remove untracked leftovers
```

Repeat for each mixed commit.

### Technique C — Patch + Stash

When commits are tangled and need manual control:
```bash
# Create patch from source
git diff <base>..<source> > big.patch

# Start bucket branch
git checkout <base> -b <bucket-branch>

# Apply patch (no commit)
git apply big.patch

# Stage only this bucket's changes
git add <bucket-files>
git commit -m "<type>(<scope>): <desc>"

# Stash the rest for next bucket
git stash --include-untracked --keep-index
```

For next bucket:
```bash
git checkout <base> -b <next-bucket-branch>
git stash apply
# Stage next bucket's changes...
```

### Technique D — Interactive Rebase (clean source first)

When source history needs cleaning before splitting:
```bash
# On source branch backup
git rebase -i <merge-base>
# Mark commits to split as "edit"
# When stopped:
git reset HEAD^  # Uncommit to working tree
git add -p  # Re-commit in smaller chunks
git rebase --continue
```

Then cherry-pick clean commits to bucket branches.

### Technique E — Rebase --onto (stacked PRs)

When buckets must stack:
```bash
# PR1 branch (base)
git checkout <base> -b <bucket1-branch>
git cherry-pick <bucket1-commits>

# PR2 branch (stacked on PR1)
git checkout <bucket1-branch> -b <bucket2-branch>
git cherry-pick <bucket2-commits>

# Or use rebase-onto for existing branches:
git rebase --onto <new-base> <old-base> <branch>
```

### Technique F — Milestone Branches

When sequential milestones exist:
```bash
# Find milestone commits
git log --oneline <base>..<source> | grep -i "milestone\|done\|complete"

# Create branch at each milestone
git checkout <milestone1-sha> -b <step1-branch>
git checkout <milestone2-sha> -b <step2-branch>
```

---

## Step 3 — Use Worktrees for Parallel Work

If working on multiple buckets simultaneously:
```bash
git worktree add ../wt-<bucket1> <bucket1-branch>
git worktree add ../wt-<bucket2> <bucket2-branch>
```

Work in each worktree independently.

Clean up when done:
```bash
git worktree remove ../wt-<bucket1>
```

---

## Step 4 — Record Evidence

### COMMAND-LOG.md
Record every command executed:
```markdown
# Command Log: <topic>

## Setup
- `git config rerere.enabled true`
- `git fetch origin --prune`

## Bucket: <name>
- `git checkout main -b <branch>`
- `git cherry-pick abc123 def456`
- ...

## Bucket: <name>
- ...
```

### BRANCH-MAP.md
```markdown
# Branch Map: <topic>

| Branch | Bucket | Technique | Commits | Directories | Status |
|--------|--------|-----------|---------|-------------|--------|
| feat/router-info | Router Info Card | cherry-pick | abc, def | src/RouterInfo/ | created |
| feat/connected-pages | Connected Pages | cherry-pick -n | ghi, jkl | src/ConnectedPages/ | created |
...

## Stacking (if applicable)
- feat/step1 ← base
- feat/step2 ← feat/step1
- feat/step3 ← feat/step2

## Worktrees Used
- ../wt-bucket1 (cleaned up)
- ../wt-bucket2 (cleaned up)
```

---

## Checklist Before Proceeding to Verify

- [ ] All buckets have branches created
- [ ] All commits moved to appropriate branches
- [ ] Mixed commits handled per SPLIT-PLAN technique
- [ ] COMMAND-LOG.md updated
- [ ] BRANCH-MAP.md complete
- [ ] No uncommitted changes remain

When complete, instruct: "Run `/smart-branch-split.verify`"
