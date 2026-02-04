---
description: Load the session memory dump and any referenced artifacts
globs:
alwaysApply: false
---

# /continue.load — Load Memory + Artifacts

Goal: read the session memory dump and hydrate the minimal context needed to proceed.

## Inputs

- `.cursor/continue/<topic>/CONTINUE-SPEC.md`

## Steps (MANDATORY)

1) Read the selected memory dump file.

2) Extract and restate (briefly):
- objective
- what’s already done
- next steps
- constraints (including missing/skipped MCPs)
- pointers (file paths)

3) For each pointer path listed in the dump:
- if it exists: read it (only as much as needed)
- if it does not exist: record it as NOT FOUND (do not guess)

## Output (MANDATORY)

Write `.cursor/continue/<topic>/LOADED-MEMORY.md` containing:
- a compact summary of the dump
- the extracted next steps (as a checklist)
- a “Pointers” section with each path + status (FOUND/NOT FOUND)

