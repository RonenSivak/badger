---
name: create-kit
description: "Generate new Cursor workflow kit. Trigger: /create-kit <kit-name>"
disable-model-invocation: true
---

# Create-Kit Skill

Generate repeatable Cursor workflow kits (commands + rules + AGENTS.md).

## Quick Start

```bash
/create-kit my-workflow
```

## Key Rules

1. **Spec first** — KIT-SPEC + FILE-MAP before scaffolding
2. **Verify gates** — All files must pass verification
3. **Include AGENTS.md** — Kit-specific agent instructions

## Full Documentation

See `.cursor/commands/create-kit.md` for templates and workflow.
