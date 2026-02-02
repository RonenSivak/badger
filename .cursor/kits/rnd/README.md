# /rnd Kit

`/rnd` is a meta-orchestrator for Badger: it checks MCP availability, routes user intent to the right workflow, then delegates to the canonical command.

## What it does

- **Preflight MCPs** and block on missing tools until the user decides what to do
- **Route** to the best Badger command based on intent signals
- **Delegate** to the selected workflow (no duplicated orchestration)

## Install

Copy to your project:

```
.cursor/commands/rnd.md
.cursor/commands/rnd/
.cursor/rules/rnd/
.cursor/skills/rnd/
```

## Quick start

```
/rnd I’m seeing a crash when saving. Here’s the console error: ...
```

Then follow the prompts:
1) Context budget gate (if near context limit: clickable options + wait)
2) MCP preflight (if missing MCPs: clickable options + wait)
3) Routing confirmation (if ambiguous)
4) Delegation to the chosen workflow (e.g. `/troubleshoot`)

## Context Budget Gate (critical behavior)

When the agent estimates context usage is near-full (~90%), `/rnd.context-budget` MUST ask with clickable options:
- “Dump session memory (write file, then I’ll create a new agent)”
- “Continue as usual”

If you choose dump, it writes:
- `.cursor/session-memory/session-memory-<flow-summary>-<date>.md`
  - `<flow-summary>`: 3–4 words, kebab-cased
  - `<date>`: full timestamp

## MCP Gate (critical behavior)

If any MCP is missing/not active, `/rnd.preflight` MUST ask with clickable options:
- “I enabled/added it now (recheck)”
- “Proceed without it (degraded mode)”
- “Other / help me set it up”

If the user chooses “Proceed without it”, the run becomes **degraded**:
- cross-repo proof requirements become **NOT FOUND** (with searches + scope), or
- a documented fallback is used.

## Routing targets

| User goal | Routed command |
|----------|----------------|
| Understand system / trace E2E | `/deep-search` |
| Debug a bug/perf issue | `/troubleshoot` |
| Implement change safely | `/implement` |
| UI from Figma/requirements | `/implement-ui` |
| Review a change/PR | `/review` |
| Generate BDD tests | `/testkit` |
| Rename symbols safely | `/better-names` |
| Simplify/refactor code | `/optimize-code` |
| Split a large branch | `/smart-branch-split` |
| Merge/forward-port branches | `/smart-merge` |
| Address PR comments | `/address-pr` |
| Create a new kit | `/create-kit` |
| Bootstrap agent scaffolding | `/create-agent` |

## Files

### Commands

| File | Purpose |
|------|---------|
| `rnd.md` | orchestrator |
| `rnd.preflight.md` | MCP availability gate |
| `rnd.route.md` | intent routing + delegation |

### Rules

| File | Purpose |
|------|---------|
| `rnd-laws.mdc` | orchestrator laws |
| `mcp-gate.mdc` | missing MCP interactive gate |

### Skill

| File | Purpose |
|------|---------|
| `SKILL.md` | quick reference and routing cheat sheet |

