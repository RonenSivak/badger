# Continuing Sessions Kit

Resume a previously interrupted session using a session-memory dump file.

## What It Does

- Selects a `session-memory-*.md` dump from `.cursor/session-memory/`
- Loads the dump + reads any referenced artifacts
- Verifies the "next steps" are actionable
- Resumes work by delegating to the correct workflow skill

## Quick Start

Continue from a specific dump:
```
Resume from .cursor/session-memory/session-memory-deep-search-auth-flow-2026-02-02T15-30.md
```

Or pick from recent dumps:
```
I need to continue where I left off
```

## Workflow

1. **Clarify** — Choose memory file + set current objective
2. **Load** — Read dump + referenced artifacts
3. **Verify** — Produce an actionable resume plan
4. **Resume** — Execute next steps or delegate to a workflow skill
5. **Publish** — Summary of what's loaded and what happens next

## Structure

| Type | Location | Purpose |
|------|----------|---------|
| Skill | `.cursor/skills/continuing-sessions/SKILL.md` | Main entry point |
| Guides | `.cursor/guides/` | Progressive disclosure |

## Generated During Runs

| File | Created By |
|------|------------|
| `.cursor/continue/<topic>/CONTINUE-SPEC.md` | clarify |
| `.cursor/continue/<topic>/LOADED-MEMORY.md` | load |
| `.cursor/continue/<topic>/RESUME-PLAN.md` | verify |

## Session Memory Format

Session dumps in `.cursor/session-memory/` contain:
- Flow type (which workflow was running)
- Last completed step
- Pending steps
- Key artifacts created
- Important context/decisions
- Next action to take
