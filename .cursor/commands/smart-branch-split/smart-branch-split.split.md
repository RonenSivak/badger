---
description: Execute the split (create branches + move changes cleanly), writes BRANCH-MAP.md + COMMAND-LOG.md
globs:
alwaysApply: false
---

# /smart-branch-split.split — Create Split Branches

Inputs:
- `SPLIT-SPEC.md`
- `CLUSTERS.md`
- `MIXED-COMMITS.md`

Principles:
- New branches start from **base** (not from the big branch).
- Prefer **cherry-pick** when commits are already clean.
- Use **commit-splitting** when commits mix buckets.
- Use **worktrees** if juggling many branches.

## Step 1 — Create branches
For each bucket:
- choose a conventional name (see skills)
- `git switch <base>`
- `git switch -c <new-branch> <BASE>`

Record all created branches in `BRANCH-MAP.md`.

## Step 2 — Move changes (pick the best strategy per bucket)

### Strategy A — Cherry-pick clean commits
If commits are bucket-pure:
- `git cherry-pick <sha1> <sha2> ...`

### Strategy B — Cherry-pick without committing (stage subsets)
If commits are mixed but changes are separable by hunks/files:
- `git cherry-pick -n <sha>`
- stage only bucket changes (`git add -p` / `git add <paths>`)
- `git commit -m "<type>(<scope>): <desc>"`
- revert unstaged leftovers back out of index/worktree if needed
Repeat until done, then continue with next mixed commit.

### Strategy C — Split commits at the source (interactive rebase)
If the history must be cleaned first:
- interactive rebase the source branch to split “mixed commits”
- rewrite them into smaller commits
Then return to Strategy A.

### Strategy D — Rebase-onto (stacked PRs)
If buckets must be stacked:
- `git rebase --onto <new-base> <old-base> <branch>`
Use when ordering is required (PR2 depends on PR1).

## Step 3 — Keep evidence
Write:
- `COMMAND-LOG.md` with every command you ran (copy/paste)
- update `BRANCH-MAP.md` with:
  - branch name
  - bucket intent
  - commits included
  - directories touched

Output folder:
`.cursor/smart-branch-split/<topic>/`
