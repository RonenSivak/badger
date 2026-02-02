---
name: continue
description: "Resume a prior session from a session-memory dump (created by /rnd.context-budget). Use when starting a fresh agent after dumping memory."
---

# Continue Skill

Purpose: resume work using a memory dump file under `.cursor/session-memory/`.

## Quick start

1) Create a new agent
2) Run:

```
/continue .cursor/session-memory/session-memory-<flow-summary>-<date>.md
```

Or run `/continue` with no args to select from recent dumps.

## What the memory dump should contain

- Current objective
- What’s already done
- Next steps (ordered)
- Constraints (missing/skipped MCPs; degraded-mode notes)
- Pointers to artifacts (paths)

## Rules to follow

- No assumptions beyond memory; gaps are explicit.
- Validate pointers (FOUND vs NOT FOUND).
- Delegate to canonical workflows when the dump says so (e.g. `/deep-search`, `/troubleshoot`, `/rnd`).

