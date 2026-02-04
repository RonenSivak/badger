# Splitting Branches Kit

Split a large Git branch into smaller, reviewable branches using industry best practices.

## What It Does

Takes a large feature branch and splits it into multiple smaller branches suitable for separate PRs, using the most appropriate Git technique for each chunk.

## Features

- **5 Clustering Strategies**: By feature, module, commit history, milestones, or feature flags
- **6 Git Techniques**: Cherry-pick, selective staging, patch+stash, interactive rebase, rebase-onto, milestone branches
- **4 PR Flow Types**: Independent, stacked, feature branch, trunk-based with flags
- **Comprehensive Verification**: TypeScript, lint, tests, build, git cherry accounting
- **Backup Mandate**: Never split without backup

## Prerequisites

- Git
- Monorepo tooling (yarn workspaces, npm workspaces, turbo, or nx) — optional but detected

## Quick Start

```
I need to split my feature branch `feat/big-feature` into smaller PRs targeting `main`.
It has changes across 3 packages and I want independent PRs if possible.
```

## Workflow

1. **Clarify** — Gather inputs, select strategy, discover verification commands
2. **Analyze** — Create backup, map diff/commits, propose clusters
3. **Plan** — Create concrete execution plan with technique per bucket
4. **Split** — Execute plan, create branches, move changes
5. **Verify** — Gate: all checks must pass before publish
6. **Publish** — Summary, PR guide, cleanup checklist

## Files Generated (per run)

| File | Phase | Purpose |
|------|-------|---------|
| `SPLIT-SPEC.md` | clarify | Inputs + constraints + strategy |
| `ANALYSIS.md` | analyze | Facts + metrics + backup info |
| `CLUSTERS.md` | analyze | Proposed buckets |
| `SPLIT-PLAN.md` | plan | Concrete execution plan |
| `BRANCH-MAP.md` | split | Created branches |
| `VALIDATION-REPORT.md` | verify | Verification results |

All stored in: `.cursor/smart-branch-split/<topic>/`

## Structure

| Type | Location | Purpose |
|------|----------|---------|
| Skill | `.cursor/skills/splitting-branches/SKILL.md` | Main entry point |
| Helper Skills | `.cursor/skills/git-branch-splitting/SKILL.md` | Git techniques |
| Helper Skills | `.cursor/skills/conventional-branch-naming/SKILL.md` | Branch naming |
| Helper Skills | `.cursor/skills/verifying-range-diff/SKILL.md` | Verify rewrites |

## Verification Gates

| Check | Required | Blocking |
|-------|----------|----------|
| Backup exists | Yes | YES |
| TypeScript (`tsc --noEmit`) | Yes | YES |
| Lint | Yes | YES |
| Tests | Yes | YES (unless CI-only) |
| Build | If exists | YES |
| git cherry accounting | Yes | YES |
| Isolation (scope) | Yes | YES |

## Best Practices

- **Planning first**: Identify logical units before touching Git
- **Backup mandate**: Never rewrite without backup
- **git cherry tracking**: Ensure no commits lost
- **rerere enabled**: Reuse conflict resolutions
- **PR flow guidance**: Independent, stacked, feature branch, trunk-based
- **Cleanup checklist**: Post-merge branch deletion, flag removal
