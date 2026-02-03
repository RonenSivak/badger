---
name: smart-merge
description: "Safely merge branches with conflict resolution. Trigger: /smart-merge"
disable-model-invocation: true
---

# Smart Merge Skill

Safely merge branches by simulating, resolving conflicts, and verifying.

## Quick Start

```bash
/smart-merge
```

## What "Smart" Means

1. **Simulate** — `git merge --no-commit` in scratch branch
2. **Resolve** — Use patterns + code ownership context
3. **Verify** — lint/tsc/tests must pass
4. **Scan blast radius** — Find consumers of changed surfaces

## Full Documentation

See `.cursor/commands/smart-merge.md` for workflow and artifact paths.
