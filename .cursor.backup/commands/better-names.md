---
description: Safely rename TypeScript identifiers following naming conventions
globs:
alwaysApply: false
---

# /better-names — Orchestrator

Safely rename TypeScript identifiers following industry-standard naming conventions, with comprehensive semantic and string-based impact analysis.

## Workflow

1. **Clarify** → `/better-names.clarify`
2. **Validate** → `/better-names.validate`
3. **Analyze** → `/better-names.analyze`
4. **Plan** → `/better-names.plan`
5. **Execute** → `/better-names.execute`
6. **Verify** → `/better-names.verify`
7. **Publish** → `/better-names.publish`

## Delegates

- `.cursor/commands/better-names/better-names.clarify.md`
- `.cursor/commands/better-names/better-names.validate.md`
- `.cursor/commands/better-names/better-names.analyze.md`
- `.cursor/commands/better-names/better-names.plan.md`
- `.cursor/commands/better-names/better-names.execute.md`
- `.cursor/commands/better-names/better-names.verify.md`
- `.cursor/commands/better-names/better-names.publish.md`

## Rules Enforced

- `.cursor/rules/better-names/better-names-laws.mdc`
- `.cursor/rules/better-names/naming-conventions.mdc`
- `.cursor/rules/better-names/impact-checklist.mdc`
- `.cursor/rules/shared/octocode-mandate.mdc`
- `.cursor/rules/shared/proof-discipline.mdc`

## Step 1 — Clarify (MANDATORY)
Run `/better-names.clarify` to gather:
- Target symbol(s) to rename
- Proposed new name(s)
- Scope (file, package, monorepo)

## Step 2 — Validate (MANDATORY)
Run `/better-names.validate` to check new name against TypeScript naming conventions.
If validation fails: propose correct name, re-clarify.

## Step 3 — Analyze (MANDATORY)
Run `/better-names.analyze` to find all impact areas:
- Semantic (LSP): imports, references, inheritance, implementations
- String: dataHooks, i18n keys, tests, comments, configs

## Step 4 — Plan (MANDATORY)
Run `/better-names.plan` to generate rename plan listing every change.

## Step 5 — Execute (MANDATORY)
Run `/better-names.execute` to perform:
- LSP rename for code references
- Manual string reference updates

## Step 6 — Verify (MANDATORY)
Run `/better-names.verify` to ensure:
- `tsc --noEmit` passes
- Tests pass
- No orphaned string references
- ESLint passes

If verify fails: fix issues, re-verify.

## Step 7 — Publish (MANDATORY)
Run `/better-names.publish` to generate summary report.

## Hard-fail Conditions

- Executing without analyze
- Skipping verify before commit
- Name collision detected
- Keyword used as name
