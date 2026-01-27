---
description: Perform rename via LSP and manual string updates
globs:
alwaysApply: false
---

# /better-names.execute — Execute Rename

Perform the rename based on the plan.

## Prerequisites

- MUST have completed `/better-names.analyze`
- MUST have completed `/better-names.plan`

## Execution Steps

### Step 1: LSP Rename

Use IDE's rename refactoring (F2 or equivalent) to rename the symbol.
This handles:
- Declaration
- All imports
- All code references
- Type references

### Step 2: String Reference Updates

For each string reference in the plan:

1. **dataHooks** — Update type parameter names
   ```typescript
   // Before
   dataHooks<{ OldName: ... }>('Component')
   // After
   dataHooks<{ NewName: ... }>('Component')
   ```

2. **Translation keys** — Update if derived from symbol name
   ```typescript
   // Only if key was based on symbol name
   t('component.oldName.label') → t('component.newName.label')
   ```

3. **Test descriptions** — Update describe/it blocks
   ```typescript
   describe('OldName', () => ...) → describe('NewName', () => ...)
   ```

4. **Comments/JSDoc** — Update documentation
   ```typescript
   /** OldName does X */ → /** NewName does X */
   ```

5. **Config files** — Update exports, aliases
   ```json
   { "exports": { "OldName": ... } } → { "exports": { "NewName": ... } }
   ```

### Step 3: Record Changes

Track all changes made for the publish step.

## Output

```
## EXECUTION SUMMARY

### LSP Rename
- Files changed: <count>
- References updated: <count>

### String Updates
| File | Line | Type | Status |
|------|------|------|--------|
| ... | ... | dataHook | ✓ |
| ... | ... | test | ✓ |
```

## Next Step

Run `/better-names.verify`.
