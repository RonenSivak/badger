---
description: RnD meta-orchestrator for Badger kits (preflight MCPs → route intent → delegate)
globs: ".cursor/commands/rnd/**/*.md"
alwaysApply: false
---

# /rnd — Orchestrator

Purpose: a single entry point that knows how to use every Badger command, when to use it, and which MCPs are required. It runs a strict **MCP preflight gate**, then routes to the correct workflow.

## Enforces (rules)
- [RnD Laws](../rules/rnd/rnd-laws.mdc)
- [MCP Gate](../rules/rnd/mcp-gate.mdc)
- [Context Budget Gate](../rules/rnd/context-budget-gate.mdc)

## Delegates to (sub-commands)
- `/rnd.context-budget` → `.cursor/commands/rnd/rnd.context-budget.md`
- `/rnd.preflight` → `.cursor/commands/rnd/rnd.preflight.md`
- `/rnd.route`     → `.cursor/commands/rnd/rnd.route.md`

## Known commands (routing targets)

| Command | Best for |
|---------|----------|
| `/deep-search` | provable E2E architecture forensics (cross-repo) |
| `/implement` | implementing change using deep-search artifacts |
| `/implement-ui` | UI build from Figma/requirements (WDS) |
| `/troubleshoot` | debugging with runtime evidence + proof |
| `/review` | deep review (conformance + impact sweep) |
| `/testkit` | BDD test generation |
| `/better-names` | safe TS renames (LSP + string sweep) |
| `/optimize-code` | simplify/refactor TypeScript/React |
| `/smart-branch-split` | split a large branch into reviewable PRs |
| `/smart-merge` | safe merge/forward-port between diverged branches |
| `/address-pr` | address PR review comments (read-only git) |
| `/create-kit` | create a new reusable workflow kit |
| `/create-agent` | scaffold agent setup for a repo |

---

## Step 0 — Clarify (MANDATORY)

Ask: **“What would you like to do?”**
- Encourage a 1–2 sentence goal plus 1–3 breadcrumbs (paths, errors, links, symbols).

## Step 1 — Context Budget Gate (MANDATORY)

Run `/rnd.context-budget`.
- If context is near-full (~90%), you MUST prompt the user with clickable options and WAIT.

## Step 2 — MCP Preflight (MANDATORY)

Run `/rnd.preflight`.
- If any MCP is missing, you MUST prompt the user with clickable options and WAIT.

## Step 3 — Route + Delegate (MANDATORY)

Run `/rnd.route` to pick the right command and then delegate to it.

Hard rule:
- Do not start the selected workflow until MCP requirements are either AVAILABLE or explicitly SKIPPED (with degraded-mode constraints recorded).

