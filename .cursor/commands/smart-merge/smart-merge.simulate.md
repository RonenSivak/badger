---
description: Simulate merge safely in a scratch branch (no commit)
globs:
alwaysApply: false
---

# /smart-merge.simulate — Simulate 🔬

Create a scratch branch and test the merge *without committing*.

Write:
`.cursor/smart-merge/<name>/SIMULATION.md`

Required content:
- scratch branch name
- commands executed
- merge status:
  - clean
  - conflicts (list files)
  - abort/reset instructions

Default mechanics:
- Use `git merge --no-commit` to test the merge without finalizing it.
- If conflicts exist, stop and hand off to `/smart-merge.resolve`.
