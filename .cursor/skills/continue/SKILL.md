---
name: continue
description: "Resume session from memory dump. Trigger: /continue [path]"
disable-model-invocation: true
---

# Continue Skill

Resume work from a session-memory dump.

## Quick Start

```bash
/continue                                    # Select from recent dumps
/continue .cursor/session-memory/<file>.md  # Specific dump
```

## Key Rules

1. **No assumptions** — Only use what's in the dump
2. **Validate pointers** — Check artifact paths exist
3. **Delegate to workflows** — Follow dump instructions

## Full Documentation

See `.cursor/kits/continue/AGENTS.md` for memory dump format and boundaries.
