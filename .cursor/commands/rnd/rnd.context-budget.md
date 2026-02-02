---
description: Detect near-full context (~90%) and prompt user to dump session memory or continue
globs:
alwaysApply: false
---

# /rnd.context-budget — Context Budget Gate

Goal: when the agent estimates the context window is ~90% full, **pause** and ask the user what to do next.

## When to trigger (MANDATORY)

Trigger this gate when you estimate context usage is near the limit (≈ 90%).

Signals you’re close:
- you’re dropping earlier details
- tool outputs are being truncated frequently
- you’re about to start a large multi-file change/review with many citations

## Behavior (MANDATORY, interactive)

When triggered, prompt the user with clickable options:

1) **Dump session memory** (recommended)
   - Write a session memory file to: `.cursor/session-memory/`
   - File name: `session-memory-<flow-summary>-<date>.md`
     - `<flow-summary>`: 3–4 words, kebab-cased (e.g. `deep-search-auth-flow`)
     - `<date>`: full timestamp (e.g. `2026-02-02T15-30`)
   - Then tell the user to create a new agent and reference this file.

2) **Continue as usual**
   - Proceed without dumping, accepting higher risk of losing context.

You MUST WAIT for the user’s response before continuing.

## Memory dump contents (MANDATORY)

The memory dump file must be concise and high-signal:
- **Current objective** and selected `/rnd` route (if decided)
- **What’s already done** (key decisions, changes, artifacts)
- **What remains** (next concrete steps)
- **Constraints** (missing/skipped MCPs; degraded-mode constraints)
- **Pointers** to relevant artifacts:
  - `.cursor/rnd/<topic>/MCP-PREFLIGHT.md`
  - `.cursor/rnd/<topic>/ROUTE.md`

## Output

If the user chooses dump:
- Ensure directory exists: `.cursor/session-memory/`
- Write: `.cursor/session-memory/session-memory-<flow-summary>-<date>.md`

