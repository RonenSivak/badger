---
name: update-kit
description: "Update existing kit to best practices. Trigger: /update-kit <kit-name>"
disable-model-invocation: true
---

# Update-Kit Skill

Update existing Cursor workflow kits to match current best practices.

## Quick Start

```bash
/update-kit deep-search
```

## Key Rules

1. **Backup first** — Files backed up before modification
2. **Kit must exist** — Use `/create-kit` for new kits
3. **Verify before publish** — Must pass all gates

## Full Documentation

See `.cursor/kits/update-kit/README.md` for checklist and workflow details.
