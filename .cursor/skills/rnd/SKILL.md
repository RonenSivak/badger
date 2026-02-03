---
name: rnd
description: "Meta-orchestrator: MCP preflight + intent routing. Trigger: /rnd"
disable-model-invocation: true
---

# RnD Skill

Meta-orchestrator that runs MCP preflight and routes to the right Badger workflow.

## Quick Start

```bash
/rnd                    # Auto-detect intent and route
/rnd.preflight          # Check MCP availability
/rnd.route              # Route after preflight
```

## Intent → Command

| User says | Routes to |
|-----------|-----------|
| "how does X work" | `/deep-search` |
| "debug/fix/broken" | `/troubleshoot` |
| "build UI/Figma" | `/implement-ui` |
| "implement/create" | `/implement` |
| "review/PR" | `/review` |

## Full Documentation

See `.cursor/commands/rnd.md` for MCP preflight matrix, boundaries, and output format.
