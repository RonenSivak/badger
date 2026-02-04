---
description: Generate summary report of rename changes
globs:
alwaysApply: false
---

# /better-names.publish — Summary Report

Generate a summary report of the rename operation.

## Prerequisites

- MUST have PASS from `/better-names.verify`

## Report Content

Print to chat:

```markdown
## Rename Complete: `<oldName>` → `<newName>`

### Summary
- Symbol kind: <kind>
- Files changed: <count>
- References updated: <count>

### Code Changes
- Imports: <count>
- Declarations: <count>
- References: <count>
- Type references: <count>

### String Changes
- dataHooks: <count>
- Tests: <count>
- Comments: <count>
- Configs: <count>

### Verification
- TypeScript: ✓
- Tests: ✓
- ESLint: ✓
- No orphans: ✓

### Files Modified
<list of files>

### Notes
<any special considerations or follow-ups needed>
```

## If NOT FOUND Items Exist

Report any symbols that couldn't be resolved:

```markdown
### Unresolved Items
- `<symbol>`: Could not locate definition
```

## Migration Guide (if breaking change)

If the renamed symbol was part of a public API:

```markdown
### Migration Guide

```typescript
// Before
import { OldName } from '@package/module';

// After
import { NewName } from '@package/module';
```
```

## End of Workflow

The `/better-names` workflow is complete.
