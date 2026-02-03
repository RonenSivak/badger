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

## Git Commands
```bash
git log --oneline <branch>   # View commits
git diff <base>...<branch>   # View changes
git cherry-pick <commit>     # Apply specific commits
git rebase -i <base>         # Interactive rebase
```

## Split Strategies

### By Feature
- Group related commits
- Maintain logical coherence

### By File Type
- Frontend vs backend
- Tests vs implementation

### By Size
- Target ~300-500 lines per PR
- Reviewable in one session

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
