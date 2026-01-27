---
description: Gather target symbol, new name, and scope for renaming
globs:
alwaysApply: false
---

# /better-names.clarify — Clarification Loop

Gather information needed to perform a safe rename.

## Questions to Ask

1. **What symbol do you want to rename?**
   - Provide the current name
   - Specify the file path if ambiguous

2. **What should the new name be?**
   - Or ask for a suggestion based on conventions

3. **What is the rename scope?**
   - Single file
   - Single package
   - Entire monorepo

4. **Is this symbol exported?**
   - If yes, cross-package impact analysis required

## Output

Draft a **RENAME SPEC**:

```
## RENAME SPEC

- Current name: `<current>`
- New name: `<proposed>`
- Symbol kind: <variable|function|class|interface|type|enum|constant>
- Location: `<file:line>`
- Scope: <file|package|monorepo>
- Exported: <yes|no>
```

## Next Step

When complete, run `/better-names.validate`.
