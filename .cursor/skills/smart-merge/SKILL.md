---
name: smart-merge
description: "Safely merge branches by simulating merge, resolving conflicts using existing patterns and ownership context, verifying with real checks, and scanning blast radius. Use when performing non-trivial merges with conflicts."
---

# Smart Merge Skill 🔀

## What "smart" means
1) simulate merge in scratch branch (no commit)
2) resolve conflicts by matching existing patterns + ownership context
3) verify with real commands (lint/tsc/tests)
4) scan blast radius (find consumers of changed surfaces)

---

## MCP-S Tools for Smart Merge

Use MCP-S to gather **ownership and context** before resolving conflicts:

| Tool | When to Use | Priority |
|------|-------------|----------|
| `code_owners_for_path` | Every conflicting file — know who owns each side | **P0** |
| `search_builds` | Before merge — check branch build status | **P1** |
| `slack__search-messages` | Semantic conflict — why was this built? | **P1** |
| `jira__get-issues` | Requirements unclear — feature/bug context | **P2** |
| `get_commit_information` | Conflict resolution — commit intent | **P2** |

### Quick Workflow
```
1. Conflict detected in file.ts
   └── code_owners_for_path("path/to/file.ts") → know owners
   └── slack__search-messages("file.ts refactor") → context
   └── Resolve with ownership + context in mind
```

---

## Evidence artifacts
Write everything to `.cursor/smart-merge/<name>/...` so the chat context stays small:
- `MERGE-SPEC.md` — branches, strategy, constraints
- `MERGE-PLAN.md` — commands, checkpoints
- `CONFLICT-RESOLUTION.md` — decisions + proof
- `mcp-s-notes.md` — ownership & context findings

## Git mechanics you should use
- Use `git merge --no-commit` to test merging without committing; reset/abort if needed.
- Follow standard conflict-resolution flow (identify, resolve, stage, continue).
