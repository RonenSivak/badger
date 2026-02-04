---
description: Semantic and string-based impact analysis for rename
globs:
alwaysApply: false
---

# /better-names.analyze — Impact Analysis

Find ALL locations affected by the rename.

## Rules Reference

See `.cursor/rules/better-names/impact-checklist.mdc` for complete checklist.
See `.cursor/rules/shared/octocode-mandate.mdc` for cross-package symbols.

## Analysis Phases

### Phase 1: Semantic Analysis (LSP)

Use LSP tools to find:

1. **Definition** — `lspGotoDefinition`
2. **All references** — `lspFindReferences`
3. **Call hierarchy** — `lspCallHierarchy(incoming)` and `lspCallHierarchy(outgoing)`
4. **Inheritance chain** — classes that extend/implement
5. **Type hierarchy** — types that reference this type

Record each finding with file:line.

### Phase 2: String Reference Analysis (grep)

Search for string patterns:

```
# dataHooks pattern
rg "dataHooks.*<symbol>" --type ts

# Translation keys
rg "t\(['\"].*<symbol>" --type ts

# Test descriptions
rg "describe\(['\"].*<symbol>" --type ts

# Comments/JSDoc
rg "\/\*\*.*<symbol>" --type ts
rg "\/\/.*<symbol>" --type ts

# Config files
rg "<symbol>" package.json webpack.config.* tsconfig.*
```

### Phase 3: Cross-Package Analysis (if exported)

If symbol is exported, use octocode to find:
- External package consumers
- Re-exports in other packages
- Type usage in external packages

## Output

```
## IMPACT ANALYSIS

### Semantic References (LSP)
| File | Line | Type |
|------|------|------|
| ... | ... | import/call/extends/implements |

### String References (grep)
| File | Line | Pattern |
|------|------|---------|
| ... | ... | dataHook/i18n/test/comment |

### Cross-Package (if applicable)
| Package | File | Usage |
|---------|------|-------|
| ... | ... | ... |

### NOT FOUND
- <any symbols that couldn't be resolved>
```

## Next Step

Run `/better-names.plan`.
