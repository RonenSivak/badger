# SKILL: Git branch splitting (big branch → multiple PR branches)

## When to use which strategy

### A) Cherry-pick (clean commits)
Use when commits already match a bucket.
- `git cherry-pick <sha...>`

### B) Cherry-pick -n + patch staging (mixed commits)
Use when one commit contains changes for multiple buckets.
- `git cherry-pick -n <sha>`
- stage only what belongs:
  - `git add -p`
  - or `git add <paths>`
- commit with a clean message
- repeat until the commit’s content is fully distributed

### C) Split commits via interactive rebase
Use when the source history must be cleaned (many mixed commits).
Typical approach:
- interactive rebase, stop on a commit (“edit”)
- uncommit it to working tree
- re-commit in smaller logical chunks using `git add -p`

### D) Rebase --onto (stacked PRs)
Use when PR2 must sit on top of PR1, etc.
- `git rebase --onto <new-base> <old-base> <branch>`

## Worktrees (strongly recommended for many split branches)
Create parallel checkouts so you don’t constantly switch:
- `git worktree add ../wt-<branch> <branch>`
