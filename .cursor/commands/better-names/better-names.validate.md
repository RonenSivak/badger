---
description: Validate new name against TypeScript naming conventions
globs:
alwaysApply: false
---

# /better-names.validate — Convention Check

Validate the proposed new name against TypeScript naming conventions.

## Rules Reference

See `.cursor/rules/better-names/naming-conventions.mdc` for full rules.

## Validation Checks

### 1. Convention Match
Check if new name follows the convention for its symbol kind:

| Symbol Kind | Expected Convention |
|-------------|---------------------|
| Variable | camelCase |
| Constant (local) | camelCase |
| Constant (module) | UPPER_SNAKE_CASE |
| Function | camelCase + verb |
| Class | PascalCase |
| Interface | PascalCase, no `I` prefix |
| Type | PascalCase, no `Type` suffix |
| Enum | PascalCase |
| Generic | Single uppercase OR PascalCase |

### 2. Semantic Validation

- **No collision**: New name doesn't exist in same scope
- **No shadowing**: New name doesn't shadow outer scope
- **Not a keyword**: New name isn't a reserved word
- **Acronym handling**: Treat as word (`customerId` not `customerID`)

### 3. Common Violations to Flag

- `I` prefix on interfaces → suggest removal
- `Type` suffix on types → suggest removal
- `_` prefix on private members → suggest removal
- snake_case in functions → suggest camelCase
- PascalCase for functions → suggest camelCase

## Output

```
## VALIDATION RESULT

- Proposed name: `<name>`
- Symbol kind: <kind>
- Convention: <PASS|FAIL>
- Collision check: <PASS|FAIL>
- Shadowing check: <PASS|FAIL>
- Keyword check: <PASS|FAIL>

Suggested corrections (if any):
- <suggestion>
```

## Next Step

If PASS: run `/better-names.analyze`.
If FAIL: propose corrected name, re-clarify.
