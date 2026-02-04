---
description: Generate BDD tests via Clarify → Resolve (MCP-S + Octocode) → Implement → Verify → Publish
globs:
alwaysApply: false
---

# /testkit — Orchestrator 🧪🧭

You are running a strict workflow. **Do not skip steps.**

Workflow:
1) Clarify (interactive loop)
2) Resolve (MCP-S + `/octocode/research`, unlimited)
3) Implement tests (drivers/builders + WDS testkits)
4) Verify (connectivity + “uses correct packages/versions”)
5) Publish (chat + files)

Enforces:
- `.cursor/rules/testkit/testkit-laws.mdc`
- `.cursor/rules/shared/octocode-mandate.mdc`
- `.cursor/rules/shared/proof-discipline.mdc`

Delegates to:
- `/testkit.clarify`  → `.cursor/commands/testkit/testkit.clarify.md`
- `/testkit.resolve`  → `.cursor/commands/testkit/testkit.resolve.md`
- `/testkit.implement`→ `.cursor/commands/testkit/testkit.implement.md`
- `/testkit.verify`   → `.cursor/commands/testkit/testkit.verify.md`
- `/testkit.publish`  → `.cursor/commands/testkit/testkit.publish.md`

## Step 0 — Clarify (MANDATORY)
Ask: “What would you like to add tests for?”
Run `/testkit.clarify` until a complete “Test Spec” exists.

## Step 1 — Resolve (MANDATORY, UNLIMITED)
Run `/testkit.resolve` until:
- testing stack + versions are proven
- best in-ecosystem examples are proven
- all non-local symbols are resolved OR NOT FOUND (with searches + scope)

## Step 2 — Implement (MANDATORY)
Run `/testkit.implement`:
- generate drivers/builders/tests aligned to proven examples
- prefer generated Ambassador builders if they exist

## Step 3 — Verify (MANDATORY)
Run `/testkit.verify`:
- confirm imports/calls match the chosen examples
- confirm packages/versions match repo reality
- confirm BDD structure rules are satisfied

## Step 4 — Publish (MANDATORY)
Run `/testkit.publish`:
- prints summary to chat
- writes files
- includes MCP Evidence section (queries + results)

## Hard-fail
- If MCP Evidence is empty → STOP (invalid run).
- If non-local symbols exist without Octocode proof → STOP (invalid run).
