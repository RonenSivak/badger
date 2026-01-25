---
description: Analyze diff + commits and propose split buckets (writes ANALYSIS.md + CLUSTERS.md)
globs:
alwaysApply: false
---

# /smart-branch-split.analyze — Diff/Commit Analysis

Inputs:
- `.cursor/smart-branch-split/<topic>/SPLIT-SPEC.md`

Goal:
Produce a split plan that is grounded in **actual diff + commit history**.

Actions (run in terminal):
1) Sync:
- `git fetch <remote> --prune`

2) Compute base:
- `BASE=<remote>/<base-branch>`
- `SRC=<source-branch>`
- `MB=$(git merge-base "$BASE" "$SRC")`

3) Gather facts:
- `git log --oneline --reverse "$MB..$SRC"`
- `git diff --name-only "$MB..$SRC"`
- `git diff --stat "$MB..$SRC"`

4) Identify “mixed commits” (heuristic):
- commits that touch multiple unrelated directories/packages
- commits that include refactors + feature in same commit
Record them as candidates for commit-splitting.

5) Propose clusters:
- cluster by top-level folders / packages
- cluster by domain keywords in commit messages
- cluster by runtime boundary (UI vs API vs infra)
Output initial buckets as:
- Bucket name
- file globs / directories
- commits that mostly belong
- “must-split” commits that mix buckets

Artifacts:
- `ANALYSIS.md` (facts + metrics)
- `CLUSTERS.md` (bucket proposal)
- `MIXED-COMMITS.md` (commit hashes + why mixed)
