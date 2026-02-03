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

## Passive context references (preferred)
Ownership/context tools and logging discipline are defined as passive context:
- `@.cursor/rules/shared/011-mcp-s-mandate.mdc`
- `@.cursor/rules/shared/001-proof-discipline.mdc`

Minimum expectation for conflicts:
- **Always** use `code_owners_for_path` for conflicting paths before deciding.

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
