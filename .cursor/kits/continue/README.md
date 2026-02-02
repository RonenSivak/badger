# /continue Kit

`/continue` resumes a previously interrupted session using a session-memory dump file (typically created by `/rnd.context-budget` when context was getting too large).

## What it does

- Selects a `session-memory-*.md` dump from `.cursor/session-memory/`
- Loads the dump + reads any referenced artifacts (paths listed inside)
- Verifies the “next steps” are actionable
- Resumes work by delegating to the correct Badger workflow when appropriate

## Install

Copy to your project:

```
.cursor/commands/continue.md
.cursor/commands/continue/
.cursor/rules/continue/
.cursor/skills/continue/
```

## Quick start

Continue from a specific dump:

```
/continue .cursor/session-memory/session-memory-deep-search-auth-flow-2026-02-02T15-30.md
```

Or pick from recent dumps:

```
/continue
```

## Workflow

1. **Clarify** — choose memory file + set current objective
2. **Load** — read dump + referenced artifacts
3. **Verify** — produce an actionable resume plan
4. **Resume** — execute next steps or delegate to a canonical workflow
5. **Publish** — concise summary of what’s loaded and what happens next

## Files

### Commands

| File | Purpose |
|------|---------|
| `continue.md` | orchestrator |
| `continue.clarify.md` | choose dump + objective |
| `continue.load.md` | load dump + pointers |
| `continue.verify.md` | validate coherence + plan |
| `continue.resume.md` | resume or delegate |
| `continue.publish.md` | summary |

### Rules

| File | Purpose |
|------|---------|
| `continue-laws.mdc` | guardrails: no assumptions, verify pointers, preserve constraints |

### Skill

| File | Purpose |
|------|---------|
| `SKILL.md` | quick reference |

## Generated during runs

| File | Created By |
|------|------------|
| `.cursor/continue/<topic>/CONTINUE-SPEC.md` | clarify |
| `.cursor/continue/<topic>/LOADED-MEMORY.md` | load |
| `.cursor/continue/<topic>/RESUME-PLAN.md` | verify |

