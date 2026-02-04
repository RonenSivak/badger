---
description: Generate rename plan with all affected locations
globs:
alwaysApply: false
---

# /better-names.plan — Rename Plan

Generate a concrete rename plan listing every change.

## Input

- RENAME SPEC from clarify
- VALIDATION RESULT from validate
- IMPACT ANALYSIS from analyze

## Plan Structure

Create a plan file at `.cursor/plans/better-names.<timestamp>.md`:

```markdown
# Rename Plan: <currentName> → <newName>

## Summary
- Symbol: `<currentName>` → `<newName>`
- Kind: <kind>
- Scope: <scope>
- Total changes: <count>

## Code Changes (LSP will handle)

### Imports
| File | Line | Change |
|------|------|--------|
| ... | ... | import { <old> } → import { <new> } |

### Declarations
| File | Line | Change |
|------|------|--------|
| ... | ... | const <old> → const <new> |

### References
| File | Line | Change |
|------|------|--------|
| ... | ... | <old>() → <new>() |

## String Changes (Manual)

### dataHooks
| File | Line | Change |
|------|------|--------|
| ... | ... | dataHooks<{ <Old>: ... }> → dataHooks<{ <New>: ... }> |

### Tests
| File | Line | Change |
|------|------|--------|
| ... | ... | describe('<old>') → describe('<new>') |

### Comments/JSDoc
| File | Line | Change |
|------|------|--------|
| ... | ... | /** <old> */ → /** <new> */ |

## Risk Assessment

- [ ] Breaking change for external consumers
- [ ] Requires migration guide
- [ ] Cross-package coordination needed
```

## Output

Plan file path printed to chat.

## Next Step

Run `/better-names.execute`.
