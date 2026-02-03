# smart-branch-split Kit - Agent Instructions

IMPORTANT: Prefer retrieval-led reasoning. Analyze git history and file dependencies before splitting.

## Commands
```bash
/smart-branch-split          # Orchestrator
/smart-branch-split.clarify # Gather branch + split criteria
/smart-branch-split.analyze # Map commits and dependencies
/smart-branch-split.plan    # Create split strategy
/smart-branch-split.split   # Execute branch splits
/smart-branch-split.verify  # Verify each branch builds/tests
/smart-branch-split.publish # Summary with PR links
```

## Technique Decision Tree

```
Is commit bucket-pure (only one bucket's files)?
├── YES → Cherry-pick (Technique A)
└── NO (mixed)
    └── Separable by file/hunk?
        ├── YES → Cherry-pick -n + Selective Staging (B)
        └── NO → Patch + Stash (C) or Interactive Rebase (D)

Stacked on another bucket? → Rebase --onto (E)
Milestone commits exist? → Milestone Branches (F)
```

## Git Techniques

### A. Cherry-pick (clean commits)
```bash
git checkout <base> -b <bucket-branch>
git cherry-pick <sha1> <sha2> <sha3>
```

### B. Cherry-pick -n + Selective Staging (mixed commits)
```bash
git checkout <base> -b <bucket-branch>
git cherry-pick -n <mixed-sha>
git reset HEAD
git add -p  # stage only bucket-relevant hunks
git commit -m "Bucket A changes"
```

### C. Patch + Stash (tangled changes)
```bash
git diff <base>...<feature> -- <bucket-files> > bucket.patch
git checkout <base> -b <bucket-branch>
git apply bucket.patch
```

### D. Interactive Rebase (history cleanup)
```bash
git rebase -i <base>
# reorder/squash commits by bucket
```

### E. Rebase --onto (stacked buckets)
```bash
git rebase --onto <bucket-a-branch> <base> <bucket-b-branch>
```

### F. Milestone Branches
```bash
git checkout <milestone-sha> -b <bucket-branch>
```

## Split Strategies

| Strategy | When to Use | Target Size |
|----------|-------------|-------------|
| By Feature | Related commits | ~300-500 lines |
| By File Type | Frontend/backend separation | Per layer |
| By Size | Large refactors | Reviewable in one session |

## Boundaries

### ✅ Always
- Verify each split branch builds
- Maintain commit history integrity
- Create meaningful PR titles

### ⚠️ Ask First
- Force pushing
- Rewriting shared history
- Splitting merged commits

### 🚫 Never
- Split without backup
- Break dependencies between splits
- Skip build verification

## Verification
- [ ] Each branch builds cleanly
- [ ] Tests pass on each branch
- [ ] No duplicate commits across splits
- [ ] Dependencies respected (base → dependent order)
