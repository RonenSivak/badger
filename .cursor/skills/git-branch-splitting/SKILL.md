---
name: git-branch-splitting
description: "Split large Git branch into reviewable PRs. Trigger: /smart-branch-split"
disable-model-invocation: true
---

# Git Branch Splitting Skill

Split a large branch into smaller, reviewable branches.

## Quick Start

```bash
/smart-branch-split <branch-name>
```

## Technique Quick Reference

| Scenario | Technique |
|----------|-----------|
| Clean commits per bucket | Cherry-pick |
| Mixed commits | Cherry-pick -n + selective staging |
| Tangled changes | Patch + Stash |
| Needs history cleanup | Interactive Rebase |
| Stacked buckets | Rebase --onto |

## Full Documentation

See `.cursor/kits/smart-branch-split/AGENTS.md` for:
- Decision tree
- Git command examples
- Split strategies
- Verification checklist
