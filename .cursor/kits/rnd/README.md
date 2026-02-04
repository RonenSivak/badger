# Routing Workflows Kit (RnD)

Meta-orchestrator for Badger: checks MCP availability, routes user intent to the right workflow skill.

## What It Does

- **Preflight MCPs** and block on missing tools until the user decides what to do
- **Route** to the best Badger skill based on intent signals
- **Delegate** to the selected workflow

## Quick Start

```
I'm seeing a crash when saving. Here's the console error: ...
```

The routing skill will:
1. Check context budget (if near limit: offer to dump session)
2. Run MCP preflight (if missing MCPs: ask what to do)
3. Route to the appropriate skill (e.g., `troubleshooting`)

## Context Budget Gate

When context usage is near-full (~90%), the skill asks:
- "Dump session memory (write file, then create a new agent)"
- "Continue as usual"

If dumping, it writes to `.cursor/session-memory/`.

## MCP Gate

If any MCP is missing, the skill asks:
- "I enabled/added it now (recheck)"
- "Proceed without it (degraded mode)"
- "Other / help me set it up"

## Routing Targets

| User Goal | Skill |
|-----------|-------|
| Understand system / trace E2E | `deep-searching` |
| Debug a bug/perf issue | `troubleshooting` |
| Implement change safely | `implementing` |
| UI from Figma/requirements | `implement-ui` |
| Review a change/PR | `reviewing` |
| Generate BDD tests | `testing` |
| Rename symbols safely | `renaming-symbols` |
| Simplify/refactor code | `optimizing-code` |
| Split a large branch | `splitting-branches` |
| Merge/forward-port branches | `merging-branches` |
| Address PR comments | `addressing-prs` |
| Create a new kit | `creating-kits` |

## Structure

| Type | Location | Purpose |
|------|----------|---------|
| Skill | `.cursor/skills/routing-workflows/SKILL.md` | Main entry point |
| Guides | `.cursor/guides/` | Progressive disclosure |
