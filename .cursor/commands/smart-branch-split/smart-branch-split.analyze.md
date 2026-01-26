---
description: Analyze diff + commits, create backup, and propose split buckets (writes ANALYSIS.md + CLUSTERS.md)
globs:
alwaysApply: false
---

# /smart-branch-split.analyze — Diff/Commit Analysis

Inputs:
- `.cursor/smart-branch-split/<topic>/SPLIT-SPEC.md`

Goal:
Produce a split plan that is grounded in **actual diff + commit history**.

---

## Step 1 — Create Backup Branch (MANDATORY)

**Before any analysis or rewrites, create a backup of the source branch.**

```bash
git branch backup-<source-branch>-$(date +%Y%m%d) <source-branch>
```

Record the backup branch name in ANALYSIS.md.

> ⚠️ **Law:** Never proceed without backup. This is non-negotiable.

---

## Step 2 — Sync and Compute Base

```bash
git fetch <remote> --prune
BASE=<remote>/<base-branch>
SRC=<source-branch>
MB=$(git merge-base "$BASE" "$SRC")
echo "Merge base: $MB"
```

Verify clean ancestry:
```bash
git log --oneline "$MB..$SRC" | wc -l
```

---

## Step 3 — Gather Facts

```bash
# Commit list
git log --oneline --reverse "$MB..$SRC"

# Files changed
git diff --name-only "$MB..$SRC"

# Stats
git diff --stat "$MB..$SRC"

# Commits per file (helps identify hot spots)
git log --oneline --name-only "$MB..$SRC" | grep -v '^$' | sort | uniq -c | sort -rn | head -20
```

Record:
- Total commit count (for git cherry verification later)
- Total files changed
- Packages/directories affected

---

## Step 4 — Identify Mixed Commits

A "mixed commit" needs splitting if it:
- Touches multiple unrelated directories/packages
- Includes refactors + feature in same commit
- Has changes for multiple logical buckets

For each commit, check:
```bash
git show --stat --oneline <sha>
```

Heuristics:
- >3 top-level directories = likely mixed
- Commit message mentions multiple concerns = likely mixed
- Test + implementation + config in one commit = might be okay (context-dependent)

---

## Step 5 — Propose Clusters (5 Strategies)

Based on SPLIT-SPEC.md clustering strategy, apply:

### Strategy 1: By Feature/Task
- Parse commit messages for feature keywords
- Group commits mentioning same feature
- Buckets = distinct features

### Strategy 2: By Module/Component  
- Group by top-level folder / package
- Each package = one bucket
- Cross-package commits = mixed

### Strategy 3: By Commit History Clusters
- Find natural breaks in commit sequence
- Group sequential commits for same sub-task
- Time gaps may indicate bucket boundaries

### Strategy 4: Milestone Breakpoints
- Find commits that represent "done" states
- Each milestone = bucket boundary
- Good for stacked PRs

### Strategy 5: Feature Flag Isolation
- Identify what can be behind a flag
- Group flag-able changes together
- Separate infrastructure from feature code

---

## Step 6 — Output Artifacts

### ANALYSIS.md
```markdown
# Analysis: <topic>

## Backup
- Branch: `backup-<source>-YYYYMMDD`

## Source Info
- Merge base: <sha>
- Commits: <count>
- Files changed: <count>

## Package Breakdown
| Package | Files | Commits |
|---------|-------|---------|
| ... | ... | ... |

## Hot Spots (most-changed files)
1. <file> — <count> commits
...
```

### CLUSTERS.md
```markdown
# Proposed Clusters: <topic>

## Clustering Strategy Used
<strategy from SPLIT-SPEC.md>

## Buckets

### Bucket 1: <name>
- **Scope:** <directories/globs>
- **Commits:** <sha list>
- **Mixed commits:** <sha list requiring split>
- **Estimated size:** <files/lines>

### Bucket 2: <name>
...

## Dependency Notes
- Bucket X depends on Bucket Y because: <reason>
```

### MIXED-COMMITS.md
```markdown
# Mixed Commits: <topic>

| SHA | Message | Directories | Why Mixed |
|-----|---------|-------------|-----------|
| abc123 | "Add feature + fix bug" | src/, tests/ | Multiple concerns |
...

## Recommended Action Per Commit
- abc123: Cherry-pick -n + selective staging
- def456: Split via interactive rebase
```
