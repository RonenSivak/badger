---
description: Clarify which session memory to load and what outcome to pursue
globs:
alwaysApply: false
---

# /continue.clarify — Clarify

Goal: identify the session memory dump to load and define the current goal.

## Inputs

The user may provide:
- an explicit path to a memory dump file, OR
- no path (meaning: pick from recent dumps)

## Steps (MANDATORY)

1) If the user provided a path:
   - confirm it exists and is readable.

2) If the user did NOT provide a path:
   - list `.cursor/session-memory/`
   - present the most recent 5–10 `session-memory-*.md` files as clickable choices
   - WAIT for the user to choose

3) Ask for the current objective in one sentence:
   - “What outcome do you want now, given this memory dump?”

## Output (MANDATORY)

Write `.cursor/continue/<topic>/CONTINUE-SPEC.md` with:
- selected memory file path
- current objective

