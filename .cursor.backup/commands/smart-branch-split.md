---
description: Split a large branch into smaller reviewable branches (clarify → analyze → plan → split → verify → publish)
globs:
alwaysApply: false
---

# /smart-branch-split — Orchestrator

You are running a **repeatable workflow** to split a large branch into smaller branches suitable for separate PRs.

Workflow:
1) Clarify (interactive loop + verification discovery + strategy selection)
2) Analyze (map diff + commits + **create backup** + cluster candidates)
3) **Plan (NEW: concrete split plan with technique per bucket)**
4) Split (create branches + move changes using planned techniques)
5) **Verify (GATE: isolation + tsc + lint + test + build + git cherry accounting)**
6) Publish (chat summary + PR guide + cleanup checklist)

Enforces:
- `.cursor/rules/smart-branch-split/smart-branch-split-laws.mdc`

Skills used:
- `.cursor/skills/git-branch-splitting/SKILL.md`
- `.cursor/skills/conventional-branch-naming/SKILL.md`
- `.cursor/skills/git-range-diff/SKILL.md`

Delegates to:
- `/smart-branch-split.clarify` → `.cursor/commands/smart-branch-split/smart-branch-split.clarify.md`
- `/smart-branch-split.analyze`  → `.cursor/commands/smart-branch-split/smart-branch-split.analyze.md`
- `/smart-branch-split.plan`     → `.cursor/commands/smart-branch-split/smart-branch-split.plan.md`
- `/smart-branch-split.split`    → `.cursor/commands/smart-branch-split/smart-branch-split.split.md`
- `/smart-branch-split.verify`   → `.cursor/commands/smart-branch-split/smart-branch-split.verify.md`
- `/smart-branch-split.publish`  → `.cursor/commands/smart-branch-split/smart-branch-split.publish.md`

---

## Step 1 — Clarify (MANDATORY)
Run `/smart-branch-split.clarify` until a complete **Split Spec** exists.

**Must include:**
- Verification discovery (workspace type, available scripts, CI-only commands)
- Clustering strategy preference (feature/module/history/milestone/feature-flag)
- PR flow type preference (independent/stacked/feature-branch/trunk-based)
- Stacking requirements (if any)

---

## Step 2 — Analyze (MANDATORY)
Run `/smart-branch-split.analyze` to produce:
- **BACKUP BRANCH** (mandatory before any rewrites)
- commit list + file map
- proposed clusters (using 5 clustering strategies)
- "mixed commits" list (need splitting)
- affected packages per cluster
- original commit count (for git cherry verification later)

---

## Step 3 — Plan (MANDATORY — NEW)
Run `/smart-branch-split.plan` to produce:
- `SPLIT-PLAN.md` with:
  - PR flow type (independent vs stacked vs feature-branch)
  - Bucket → technique mapping (cherry-pick, patch+stash, rebase-onto, etc.)
  - Execution order and dependencies
  - Feature flag recommendations (if applicable)

---

## Step 4 — Split (MANDATORY)
Run `/smart-branch-split.split` to:
- enable rerere (`git config rerere.enabled true`)
- create new branches from base
- move commits using technique from SPLIT-PLAN.md
- record all branches in BRANCH-MAP.md

---

## Step 5 — Verify (MANDATORY — BLOCKING GATE)
Run `/smart-branch-split.verify`:

### Required Checks (per branch)
| Check | Required | Blocking |
|-------|----------|----------|
| **Isolation** | ✅ | YES |
| **TypeScript** (`tsc --noEmit`) | ✅ | YES |
| **Lint** | ✅ | YES |
| **Tests** | ✅ | YES (unless CI-only) |
| **Build** | If exists | YES |
| **git cherry accounting** | ✅ | YES |

### Verification Process
1. Checkout each split branch
2. Run `tsc --noEmit` for affected packages
3. Run `lint` for affected packages
4. Run `test` for affected packages (skip if CI-only)
5. Run `build` if script exists
6. Run `git cherry` to verify all commits accounted for
7. Check for cross-branch import dependencies
8. Write `VALIDATION-REPORT.md`

**Cannot proceed to publish if any blocking check fails.**

---

## Step 6 — Publish (MANDATORY)
Run `/smart-branch-split.publish` to:
- print concise summary in chat
- provide PR creation guide (based on PR flow type)
- include cleanup checklist
- write final artifacts under `.cursor/smart-branch-split/<topic>/`

---

## Hard-Fail Conditions
- ❌ Splitting without backup branch
- ❌ Publishing without ALL verification checks passing
- ❌ TypeScript errors in any split branch
- ❌ Lint errors in any split branch
- ❌ Test failures (unless explicitly CI-only)
- ❌ Build failures
- ❌ Branches with files outside declared scope (unless explicitly allowed)
- ❌ git cherry shows unaccounted commits
