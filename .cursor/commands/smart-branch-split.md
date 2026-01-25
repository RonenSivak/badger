---
description: Split a large branch into smaller reviewable branches (clarify → analyze → split → verify → publish)
globs:
alwaysApply: false
---

# /smart-branch-split — Orchestrator

You are running a **repeatable workflow** to split a large branch into smaller branches suitable for separate PRs.

Workflow:
1) Clarify (interactive loop + verification discovery)
2) Analyze (map diff + commits + cluster candidates)
3) Split (create branches + move changes cleanly)
4) **Verify (GATE: tsc + lint + test + build must pass)**
5) Publish (chat summary + files)

Enforces:
- `.cursor/rules/smart-branch-split/smart-branch-split-laws.mdc`

Delegates to:
- `/smart-branch-split.clarify` → `.cursor/commands/smart-branch-split/smart-branch-split.clarify.md`
- `/smart-branch-split.analyze`  → `.cursor/commands/smart-branch-split/smart-branch-split.analyze.md`
- `/smart-branch-split.split`    → `.cursor/commands/smart-branch-split/smart-branch-split.split.md`
- `/smart-branch-split.verify`   → `.cursor/commands/smart-branch-split/smart-branch-split.verify.md`
- `/smart-branch-split.publish`  → `.cursor/commands/smart-branch-split/smart-branch-split.publish.md`

---

## Step 1 — Clarify (MANDATORY)
Run `/smart-branch-split.clarify` until a complete **Split Spec** exists.

**Must include verification discovery:**
- Workspace type (yarn/npm workspaces, turbo, nx)
- Available scripts per affected package
- Commands that require CI environment

---

## Step 2 — Analyze (MANDATORY)
Run `/smart-branch-split.analyze` to produce:
- commit list + file map
- proposed clusters (candidate PRs)
- "mixed commits" list (need splitting)
- affected packages per cluster

---

## Step 3 — Split (MANDATORY)
Run `/smart-branch-split.split` to:
- create new branches from base
- move commits (cherry-pick / rebase-onto / commit-splitting)

---

## Step 4 — Verify (MANDATORY — BLOCKING GATE)
Run `/smart-branch-split.verify`:

### Required Checks (per branch)
| Check | Required | Blocking |
|-------|----------|----------|
| **Isolation** | ✅ | YES |
| **TypeScript** (`tsc --noEmit`) | ✅ | YES |
| **Lint** | ✅ | YES |
| **Tests** | ✅ | YES (unless CI-only) |
| **Build** | If exists | YES |

### Verification Process
1. Checkout each split branch
2. Run `tsc --noEmit` for affected packages
3. Run `lint` for affected packages
4. Run `test` for affected packages (skip if CI-only)
5. Run `build` if script exists
6. Write `VALIDATION-REPORT.md`

**Cannot proceed to publish if any blocking check fails.**

---

## Step 5 — Publish (MANDATORY)
Run `/smart-branch-split.publish` to:
- print concise summary in chat
- write final artifacts under `.cursor/smart-branch-split/<topic>/`

---

## Hard-Fail Conditions
- ❌ Publishing without ALL verification checks passing
- ❌ TypeScript errors in any split branch
- ❌ Lint errors in any split branch
- ❌ Test failures (unless explicitly CI-only)
- ❌ Build failures
- ❌ Branches with files outside declared scope (unless explicitly allowed)
