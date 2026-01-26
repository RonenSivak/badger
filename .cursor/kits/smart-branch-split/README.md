# Smart Branch Split Kit (v2)

Split a large Git branch into smaller, reviewable branches using industry best practices.

## What It Does

Takes a large feature branch and splits it into multiple smaller branches suitable for separate PRs, using the most appropriate Git technique for each chunk.

## Features

- **5 Clustering Strategies**: By feature, module, commit history, milestones, or feature flags
- **6 Git Techniques**: Cherry-pick, selective staging, patch+stash, interactive rebase, rebase-onto, milestone branches
- **4 PR Flow Types**: Independent, stacked, feature branch, trunk-based with flags
- **Comprehensive Verification**: TypeScript, lint, tests, build, git cherry accounting
- **Backup Mandate**: Never split without backup (enforced by laws)

## Prerequisites

- Git
- Monorepo tooling (yarn workspaces, npm workspaces, turbo, or nx) — optional but detected

## Quick Start

```
/smart-branch-split
```

Then answer the clarification questions about your branch.

## Workflow

1. **Clarify** — Gather inputs, select strategy, discover verification commands
2. **Analyze** — Create backup, map diff/commits, propose clusters
3. **Plan** — Create concrete execution plan with technique per bucket
4. **Split** — Execute plan, create branches, move changes
5. **Verify** — Gate: all checks must pass before publish
6. **Publish** — Summary, PR guide, cleanup checklist

## Example Prompt

```
Split my feature branch `feat/big-feature` into smaller PRs targeting `main`.
It has changes across 3 packages and I want independent PRs if possible.
```

## Files Generated (per run)

| File | Phase | Purpose |
|------|-------|---------|
| `SPLIT-SPEC.md` | clarify | Inputs + constraints + strategy |
| `ANALYSIS.md` | analyze | Facts + metrics + backup info |
| `CLUSTERS.md` | analyze | Proposed buckets |
| `MIXED-COMMITS.md` | analyze | Commits needing splitting |
| `SPLIT-PLAN.md` | plan | Concrete execution plan |
| `BRANCH-MAP.md` | split | Created branches |
| `COMMAND-LOG.md` | split/verify | All commands executed |
| `VALIDATION-REPORT.md` | verify | Verification results |
| `FINAL-SUMMARY.md` | publish | PR guide + cleanup checklist |

All stored in: `.cursor/smart-branch-split/<topic>/`

## Kit Structure

### Commands
- `.cursor/commands/smart-branch-split.md` — Orchestrator
- `.cursor/commands/smart-branch-split/smart-branch-split.clarify.md`
- `.cursor/commands/smart-branch-split/smart-branch-split.analyze.md`
- `.cursor/commands/smart-branch-split/smart-branch-split.plan.md`
- `.cursor/commands/smart-branch-split/smart-branch-split.split.md`
- `.cursor/commands/smart-branch-split/smart-branch-split.verify.md`
- `.cursor/commands/smart-branch-split/smart-branch-split.publish.md`

### Rules
- `.cursor/rules/smart-branch-split/smart-branch-split-laws.mdc`

### Skills
- `.cursor/skills/git-branch-splitting/SKILL.md`
- `.cursor/skills/conventional-branch-naming/SKILL.md`
- `.cursor/skills/git-range-diff/SKILL.md`

## Verification Gates

| Check | Required | Blocking |
|-------|----------|----------|
| Backup exists | ✅ | YES |
| TypeScript (`tsc --noEmit`) | ✅ | YES |
| Lint | ✅ | YES |
| Tests | ✅ | YES (unless CI-only) |
| Build | If exists | YES |
| git cherry accounting | ✅ | YES |
| Isolation (scope) | ✅ | YES |

## Best Practices Incorporated

Based on industry best practices document:

- **Planning first**: Identify logical units before touching Git
- **Backup mandate**: Never rewrite without backup
- **git cherry tracking**: Ensure no commits lost
- **rerere enabled**: Reuse conflict resolutions
- **Worktrees**: Parallel work on multiple buckets
- **PR flow guidance**: Independent, stacked, feature branch, trunk-based
- **Cleanup checklist**: Post-merge branch deletion, flag removal

## What's New in v2

- **New `.plan` phase**: Concrete planning before execution
- **Backup mandate**: Enforced by laws
- **5 clustering strategies**: Not just 3
- **git cherry accounting**: Verify all commits accounted for
- **PR flow guidance**: Based on chosen strategy
- **Cleanup checklist**: Post-split maintenance
- **Enhanced skill**: All techniques from best practices
