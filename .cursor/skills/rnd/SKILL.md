---
name: rnd
description: "Meta-orchestrator for Badger: run MCP preflight, route intent to the right command, and delegate to the canonical workflow. Use when the user starts with /rnd or wants 'the right workflow' without knowing which command."
---

# RnD Skill

Purpose: select the right Badger workflow command and enforce MCP gating before execution.

## Default flow

1) Run `/rnd.context-budget` when near limit (~90%)
2) Run `/rnd.preflight`
3) If any MCP is missing: prompt user with clickable options and WAIT
4) Run `/rnd.route`
5) Delegate to the selected command’s orchestrator

## Command selection cheat sheet

| User goal | Use | Why |
|----------|-----|-----|
| “How does X work end-to-end?” | `/deep-search` | produces provable architecture report (cross-repo proof) |
| “Implement this change safely” | `/implement` | uses deep-search artifacts as the map + verification gates |
| “Build this UI from Figma/requirements” | `/implement-ui` | WDS-first mapping + verification |
| “This is broken / regression / performance issue” | `/troubleshoot` | runtime evidence first, then code proof |
| “Review this change/PR” | `/review` | conformance + impact sweep |
| “Generate tests for this behavior” | `/testkit` | BDD specs + drivers/builders + ALWAYS GREEN gates |
| “Rename this symbol everywhere” | `/better-names` | LSP + string sweep + verification |
| “Simplify/refactor this code” | `/optimize-code` | staged refactors + verification |
| “Split this giant branch” | `/smart-branch-split` | strategy + git techniques + verification |
| “Merge/forward-port these branches” | `/smart-merge` | simulate/resolve/verify with blast-radius scan |
| “Address PR review comments” | `/address-pr` | fetch/triage/analyze/plan/verify (git read-only) |
| “Create a new kit” | `/create-kit` | KIT-SPEC + FILE-MAP + scaffold + verify + publish |
| “Bootstrap agent scaffolding” | `/create-agent` | creates baseline `.cursor/` + AGENTS.md structure |

## MCP quick reference

| MCP | Why it matters |
|-----|----------------|
| `user-octocode` | mandatory cross-repo proof (def + impl + boundary) |
| `user-MCP-S` | internal context + ownership + observability |
| `user-chrome-devtools` | runtime evidence for frontend/perf troubleshooting |
| `cursor-ide-browser` | browser automation fallback + visual verification |

Rule: if an MCP is missing/not active, **ask the user what to do** (added / skip / other) and WAIT.

Rule: if context is near-full (~90%), **ask the user what to do next**:
- dump session memory to `.cursor/session-memory/session-memory-<flow-summary>-<date>.md`, then stop for a new agent, OR
- continue as usual.

