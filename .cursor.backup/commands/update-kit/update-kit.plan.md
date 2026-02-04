---
description: Create specific update plan based on analysis
globs:
alwaysApply: false
---

# /update-kit.plan — Update Plan

Create actionable plan from analysis results.

## Inputs
- `.cursor/update-kit/<kit>/UPDATE-SPEC.md`
- `.cursor/update-kit/<kit>/ANALYSIS.md`

## Plan Structure

For each gap, create an action:

### Action Types

| Type | Description |
|------|-------------|
| CREATE | New file needed |
| MODIFY | Existing file needs changes |
| MOVE | File in wrong location |
| DELETE | File should be removed (rare) |

### Priority Levels

| Priority | Criteria |
|----------|----------|
| P0 | Blocks kit from working (missing orchestrator, broken refs) |
| P1 | Missing required elements (laws, skill) |
| P2 | Missing recommended elements (frontmatter fixes) |
| P3 | Nice to have (consistency improvements) |

## Planning Rules

1. **Group related changes**: If adding a rule, also update orchestrator "Enforces:" section
2. **Order by dependency**: Create files before updating references to them
3. **Minimize scope**: Only change what's in the update goals
4. **Preserve content**: When modifying, keep existing content unless explicitly fixing it

## Output

Write `.cursor/update-kit/<kit>/UPDATE-PLAN.md`:
```markdown
# Update Plan: <kit>

## Summary
- Total actions: X
- P0 (critical): X
- P1 (required): X
- P2 (recommended): X

## Actions

### P0 — Critical

#### Action 1: <title>
- Type: CREATE/MODIFY/MOVE/DELETE
- File: <path>
- Reason: <why needed>
- Details:
  ```
  <what to add/change>
  ```

### P1 — Required
...

### P2 — Recommended
...

## Execution Order
1. <action>
2. <action>
...

## Backup Required
- [ ] <file to backup>
```

End with: "Run `/update-kit.execute`."
