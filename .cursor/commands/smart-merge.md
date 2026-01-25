---
description: Smart forward-port merge (clarify → analyze → apply → verify)
globs:
alwaysApply: false
---

# /smart-merge — Orchestrator 🧠🔀

Goal: move changes safely between diverged branches (sibling branches, forward-port from master, conflict-heavy merges) with proof + verification.

Workflow:
1) Clarify
2) Analyze divergence + choose strategy
3) Apply (merge/rebase/cherry-pick) with conflict playbooks
4) Verify (build/tests + cross-repo impact scan)
5) Summarize next actions

Enforces:
- `.cursor/rules/smart-merge/smart-merge-laws.mdc`
- `.cursor/rules/smart-merge/octocode-mandate.mdc`
- `.cursor/rules/smart-merge/mcp-s-mandate.mdc`

Delegates to:
- `/smart-merge.clarify`
- `/smart-merge.analyze`
- `/smart-merge.apply`
- `/smart-merge.verify`

## Step 1 — Clarify (MANDATORY)
Ask: “What are the source branch + target branch + desired outcome?”
Run `/smart-merge.clarify` until a Merge Spec is complete.

## Step 2 — Analyze (MANDATORY)
Run `/smart-merge.analyze`:
- compute divergence (common base + unique commits)
- detect likely conflict types
- choose a strategy: merge vs rebase vs cherry-pick (with reasoning)

## Step 3 — Apply (MANDATORY)
Run `/smart-merge.apply`:
- enable rerere
- apply chosen strategy
- resolve conflicts using conflict-type playbooks
- record resolutions + decisions

## Step 4 — Verify (MANDATORY)
Run `/smart-merge.verify`:
- local checks (lint/tsc/tests/build)
- cross-repo impact scan (Octocode BFS on touched exports/APIs)
- produce a verification report

## Output (Chat)
Return:
- what strategy was chosen + why
- conflicts encountered + resolution summary
- verification status + remaining risks
- next options: (re-run apply, fix followups, open PR, rollback)
