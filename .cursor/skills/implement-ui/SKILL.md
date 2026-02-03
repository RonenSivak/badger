---
name: implement-ui
description: "Create UI from Figma or description using WDS. Trigger: /implement-ui <figma-url|description>"
disable-model-invocation: true
---

# implement-ui Skill

Build React+TS components using Wix Design System.

## Quick Start

```bash
/implement-ui https://www.figma.com/design/abc?node-id=123
/implement-ui Create a settings panel with toggle, dropdown, save button
```

## Key Rule

**Always call `getComponentsList` first** — then map UI to WDS components.

## Required MCP

`wix-design-system-mcp` — Use `getComponentsList`, `getComponentProps`, `verify`

## Full Documentation

See `.cursor/commands/implement-ui.md` for complete MCP reference and boundaries.
