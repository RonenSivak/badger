---
description: Route user intent to the correct Badger command and enforce MCP gating decisions
globs:
alwaysApply: false
---

# /rnd.route — Intent Routing

Goal: map the user’s goal to the right Badger workflow command, ensure MCP prerequisites are satisfied (or explicitly skipped), then delegate to the chosen command.

## Inputs

- The user’s natural language request (what they typed after `/rnd`).
- The MCP preflight results in `.cursor/rnd/<topic>/MCP-PREFLIGHT.md`.

## Step 0 — MCP Gate (MANDATORY)

1) Confirm `/rnd.preflight` has been run for this topic.
2) Read `.cursor/rnd/<topic>/MCP-PREFLIGHT.md`.
3) If any MCP required by the chosen command is **MISSING** (not AVAILABLE and not SKIPPED):
   - Stop and run `/rnd.preflight` again.
   - Do not proceed until the user chooses `added` or `skip` for that MCP.

## Step 1 — Classify intent

Use the user’s wording to classify into one of these intent buckets:

| Bucket | Signals | Route To |
|--------|---------|----------|
| Architecture forensics | “how does X work”, “trace”, “E2E”, “architecture”, “where is this handled”, “SDK chain”, “generated”, “ambassador” | `/deep-search` |
| Implement from proven map | “implement”, “make change”, “apply deep-search”, “wire it up” | `/implement` |
| UI build from Figma/requirements | “Figma”, “UI”, “component”, “design”, “WDS” | `/implement-ui` |
| Debug a bug/perf issue | “bug”, “error”, “not working”, “regression”, “slow”, “timeout”, “console”, “network” | `/troubleshoot` |
| Code review | “review”, “look over”, “is this correct”, “impact sweep”, “conformance” | `/review` |
| Generate tests | “test”, “BDD”, “spec”, “coverage”, “driver”, “testkit” | `/testkit` |
| Rename identifiers safely | “rename”, “naming”, “PascalCase”, “camelCase”, “export rename” | `/better-names` |
| Simplify/refactor | “simplify”, “refactor”, “clean up”, “reduce duplication”, “optimize” | `/optimize-code` |
| Split branch | “split branch”, “smaller PRs”, “too big”, “stacked PRs” | `/smart-branch-split` |
| Merge/forward-port | “merge”, “forward-port”, “rebase”, “backport” | `/smart-merge` |
| Address PR comments | “PR comments”, “review feedback”, “address comments” | `/address-pr` |
| Create a new kit | “new kit”, “workflow kit”, “create-kit” | `/create-kit` |
| Bootstrap an agent | “AGENTS.md”, “bootstrap agent”, “setup .cursor” | `/create-agent` |

## Step 2 — Confirm routing (MANDATORY, clickable)

If classification is ambiguous, or multiple buckets match:
1) Present a single-choice prompt (clickable options) with the best 3–6 candidate commands.
2) WAIT for the user to choose.

Suggested option labels:
- “Deep-search architecture (cross-repo proof)”
- “Troubleshoot bug (runtime evidence)”
- “Implement change (from deep-search artifacts)”
- “Review changes (impact + conformance)”
- “Testkit (BDD tests)”
- “Other (describe)”

If user chooses “Other (describe)”, ask them to describe the goal in one sentence, then re-run routing.

## Step 3 — Delegate

After selecting a command:
- Print: `Routing /rnd → <command>`
- Then instruct execution to continue by running the selected command’s orchestrator (e.g. `/deep-search`).

## Output (MANDATORY)

Write `.cursor/rnd/<topic>/ROUTE.md` with:
- the user request summary (1–2 lines)
- selected command + why (signals)
- MCP prerequisites checked + any degradations (SKIPPED MCPs)

