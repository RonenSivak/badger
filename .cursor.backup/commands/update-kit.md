---
description: Update an existing Cursor workflow kit to align with current best practices
globs:
alwaysApply: false
---

# /update-kit — Orchestrator

Update an existing kit to match current best practices, structure, and patterns.

Workflow:
1) Clarify (which kit + update goals)
2) Analyze (scan structure, compare vs best practices)
3) Plan (create update plan)
4) Execute (apply changes with backup)
5) Verify (check updated kit passes all gates)
6) Publish (summary + changelog)

Enforces:
- `.cursor/rules/update-kit/update-kit-laws.mdc`
- `.cursor/rules/create-kit/mdc-frontmatter-guard.mdc` (reused)

Delegates to:
- `/update-kit.clarify`  → `.cursor/commands/update-kit/update-kit.clarify.md`
- `/update-kit.analyze`  → `.cursor/commands/update-kit/update-kit.analyze.md`
- `/update-kit.plan`     → `.cursor/commands/update-kit/update-kit.plan.md`
- `/update-kit.execute`  → `.cursor/commands/update-kit/update-kit.execute.md`
- `/update-kit.verify`   → `.cursor/commands/update-kit/update-kit.verify.md`
- `/update-kit.publish`  → `.cursor/commands/update-kit/update-kit.publish.md`

## Step 1 — Clarify (MANDATORY)
Run `/update-kit.clarify` to identify:
- Which kit to update
- Update goals (full refresh, frontmatter only, add missing rules, etc.)
- Scope constraints

## Step 2 — Analyze (MANDATORY)
Run `/update-kit.analyze` to:
- Scan existing kit structure
- Compare against best practices checklist
- Identify gaps and issues

Output: `.cursor/update-kit/<kit>/ANALYSIS.md`

## Step 3 — Plan (MANDATORY)
Run `/update-kit.plan` to:
- Create specific update actions (add/modify/remove)
- Prioritize changes
- Identify dependencies

Output: `.cursor/update-kit/<kit>/UPDATE-PLAN.md`

## Step 4 — Execute (MANDATORY)
Run `/update-kit.execute` to:
- Backup files before modifying
- Apply planned changes
- Track what was changed

Backup: `.cursor/update-kit/<kit>/backup/`

## Step 5 — Verify (MANDATORY)
Run `/update-kit.verify` to confirm:
- All frontmatter present
- No orphan references
- All delegates exist
- Naming consistent

If FAIL: fix issues and re-run verify.

## Step 6 — Publish (MANDATORY)
Run `/update-kit.publish` to:
- Write changelog
- Print summary in chat

Output: `.cursor/update-kit/<kit>/CHANGE-LOG.md`

## Hard-fail conditions

- Publishing without passing verify
- Executing without a plan
- Modifying files without backup
- Kit not found (suggest `/create-kit` instead)
