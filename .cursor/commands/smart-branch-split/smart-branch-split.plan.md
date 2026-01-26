---
description: Create concrete split plan with technique per bucket and PR flow (writes SPLIT-PLAN.md)
globs:
alwaysApply: false
---

# /smart-branch-split.plan — Split Planning

Inputs:
- `.cursor/smart-branch-split/<topic>/SPLIT-SPEC.md`
- `.cursor/smart-branch-split/<topic>/CLUSTERS.md`
- `.cursor/smart-branch-split/<topic>/MIXED-COMMITS.md`

Goal:
Create a **concrete, executable plan** before any Git operations.

---

## Step 1 — Review Inputs

Read and summarize:
- Clustering strategy from SPLIT-SPEC.md
- PR flow type from SPLIT-SPEC.md
- Proposed buckets from CLUSTERS.md
- Mixed commits from MIXED-COMMITS.md

---

## Step 2 — Determine PR Flow

Based on SPLIT-SPEC.md preference and bucket dependencies:

### Independent PRs
- Each bucket → separate PR targeting main
- No ordering required
- Best when changes don't overlap

### Stacked PRs
- PR1 targets main
- PR2 targets PR1's branch
- PR3 targets PR2's branch, etc.
- Merge in order; retarget after each merge

### Feature Branch Flow
- Create temp branch: `feature/<topic>`
- All bucket PRs target feature branch
- Final PR merges feature → main
- Good for large features needing integration testing

### Trunk-Based + Feature Flags
- All PRs target main
- Changes behind feature flags
- Flag removal in final PR

---

## Step 3 — Assign Technique Per Bucket

For each bucket, select the best Git technique:

| Technique | When to Use | Complexity |
|-----------|-------------|------------|
| **Cherry-pick** | Commits already bucket-pure | Low |
| **Cherry-pick -n + staging** | Mixed commits, separable by file/hunk | Medium |
| **Patch + Stash** | Tangled commits, need manual control | Medium |
| **Interactive Rebase** | Source history needs cleaning first | High |
| **Rebase --onto** | Stacked PRs with shared base | Medium |
| **Milestone branches** | Sequential milestones exist | Low |

Decision tree:
1. Are all commits for this bucket pure? → **Cherry-pick**
2. Are mixed commits separable by file? → **Cherry-pick -n**
3. Are mixed commits tangled within files? → **Patch + Stash** or **Interactive Rebase**
4. Is this bucket stacked on another? → **Rebase --onto**
5. Does bucket align with milestone commit? → **Milestone branch**

---

## Step 4 — Define Execution Order

Based on dependencies:
1. Buckets with no dependencies → can run in parallel
2. Buckets depending on others → must wait
3. Consider using worktrees for parallel work

```bash
# Create worktrees for parallel bucket work
git worktree add ../wt-bucket1 <base>
git worktree add ../wt-bucket2 <base>
```

---

## Step 5 — Feature Flag Recommendations

If PR flow is "Trunk-Based + Flags" or SPLIT-SPEC mentions flags:
- Identify which changes need flags
- Suggest flag naming convention
- Note cleanup tasks for after full feature ships

---

## Step 6 — Enable rerere

Recommend enabling rerere for repeated conflict resolution:
```bash
git config rerere.enabled true
```

---

## Step 7 — Output SPLIT-PLAN.md

```markdown
# Split Plan: <topic>

## PR Flow
- Type: Independent | Stacked | Feature Branch | Trunk-Based
- Base branch: <branch>
- Feature branch (if applicable): <branch>

## Execution Order

### Phase 1 (can run in parallel)
- Bucket A
- Bucket B

### Phase 2 (depends on Phase 1)
- Bucket C (depends on A)

## Bucket Details

### Bucket: <name>
- **Technique:** Cherry-pick | Cherry-pick -n | Patch+Stash | Rebase-onto | Milestone
- **Branch name:** <branch-name>
- **Commits:** <sha list>
- **Mixed commits:** <sha list with handling notes>
- **Depends on:** <other bucket or "none">
- **PR target:** main | <other-branch>

### Bucket: <name>
...

## Worktree Recommendation
- [ ] Create worktrees for parallel work: `git worktree add ../wt-<bucket> <base>`

## rerere
- [ ] Enable: `git config rerere.enabled true`

## Feature Flags (if applicable)
- Flag name: <name>
- Buckets behind flag: <list>
- Cleanup task: Remove flag after full feature ships

## Risk Assessment
- High-risk buckets: <list with reason>
- Recommended review order: <order>

## Estimated Effort
| Bucket | Technique | Complexity | Est. Time |
|--------|-----------|------------|-----------|
| ... | ... | Low/Med/High | ... |
```

---

## Checklist Before Proceeding to Split

- [ ] All buckets have assigned technique
- [ ] Execution order is clear
- [ ] Dependencies documented
- [ ] Branch names follow convention
- [ ] rerere recommendation noted
- [ ] SPLIT-PLAN.md written

When complete, instruct: "Run `/smart-branch-split.split`"
