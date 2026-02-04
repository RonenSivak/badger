---
description: Create changelog and summary of updates
globs:
alwaysApply: false
---

# /update-kit.publish — Publish

Create final changelog and summary.

## Inputs
- `.cursor/update-kit/<kit>/UPDATE-PLAN.md`
- `.cursor/update-kit/<kit>/EXECUTION-LOG.md`
- `.cursor/update-kit/<kit>/VERIFY-RESULT.md` (must be PASS)

## Pre-condition
**VERIFY MUST PASS** before publishing.

If verify has not passed:
- STOP
- Instruct user to run `/update-kit.verify` first
- Do not proceed

## Changelog Content

Summarize what changed:
- Files created
- Files modified
- Files moved/deleted
- Gaps fixed
- Remaining issues (if any)

## Output

### 1. Write Changelog
`.cursor/update-kit/<kit>/CHANGE-LOG.md`:
```markdown
# Changelog: <kit>

## Update Date
<timestamp>

## Summary
<1-2 sentence summary of what was updated>

## Changes

### Created
- `<path>` — <purpose>

### Modified
- `<path>` — <what changed>

### Moved
- `<old-path>` → `<new-path>`

### Deleted
- `<path>` — <reason>

## Gaps Fixed
- <gap> — <how fixed>

## Remaining Issues
- <issue> — <why not fixed>

## Backup Location
`.cursor/update-kit/<kit>/backup/`
```

### 2. Print Summary in Chat

```
## /update-kit Complete: <kit>

**Changes Applied:**
- Created: X files
- Modified: X files
- Fixed: X gaps

**Key Updates:**
- <highlight 1>
- <highlight 2>

**Backup:** `.cursor/update-kit/<kit>/backup/`
**Changelog:** `.cursor/update-kit/<kit>/CHANGE-LOG.md`
```

### 3. Optional: Update Kit README
If `.cursor/kits/<kit>/README.md` exists, consider updating it with:
- New features/structure added
- Updated usage notes
