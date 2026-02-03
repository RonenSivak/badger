---
description: Apply planned changes with backup
globs:
alwaysApply: false
---

# /update-kit.execute — Execute Updates

Apply the planned changes safely.

## Inputs
- `.cursor/update-kit/<kit>/UPDATE-PLAN.md`

## Safety Protocol

### 1. Create Backup Directory
```
.cursor/update-kit/<kit>/backup/
```

### 2. Backup Before Modify
For each MODIFY or DELETE action:
- Copy original file to backup directory
- Preserve relative path structure
- Example: `.cursor/commands/review.md` → `.cursor/update-kit/review/backup/commands/review.md`

### 3. Execute in Order
Follow the execution order from the plan:
1. CREATE actions first (new files)
2. MODIFY actions second (update existing)
3. MOVE actions third (relocate files)
4. DELETE actions last (remove files)

### 4. Track Changes
For each action:
- Log what was done
- Note any issues encountered
- Mark success/failure

## Execution Rules

1. **Atomic changes**: Complete each action fully before moving to next
2. **Fail fast**: If a critical (P0) action fails, STOP and report
3. **Continue on P2/P3**: Non-critical failures can be noted and continued
4. **Preserve formatting**: Match existing code style when modifying
5. **Use templates**: For new files, follow patterns from golden kits

## Frontmatter Template

When adding frontmatter to existing files:
```yaml
---
description: <infer from content>
globs:
alwaysApply: false
---
```

## Output

Track progress in `.cursor/update-kit/<kit>/EXECUTION-LOG.md`:
```markdown
# Execution Log: <kit>

## Backup Created
- <timestamp>
- Location: .cursor/update-kit/<kit>/backup/

## Actions Completed

### Action 1: <title>
- Status: SUCCESS/FAILED
- File: <path>
- Notes: <any issues>

...

## Summary
- Total: X
- Success: X
- Failed: X
```

End with: "Run `/update-kit.verify`."
