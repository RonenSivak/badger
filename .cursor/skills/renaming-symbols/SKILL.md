---
name: renaming-symbols
description: "Safely rename TypeScript identifiers with comprehensive impact analysis (LSP + string usages) and verification. Use when renaming variables, functions, classes, or fixing naming convention violations."
---

# Renaming Symbols (Better Names)

Safely rename TypeScript identifiers following industry-standard naming conventions.

## Quick Start
1. Clarify target symbol and new name
2. Validate new name against conventions
3. Analyze impact (semantic + string)
4. Plan the rename
5. Execute (LSP + string updates)
6. Verify (tsc/tests/lint)
7. Publish report

## Workflow Checklist
Copy and track your progress:
```
- [ ] Symbol and new name clarified
- [ ] New name validated (conventions)
- [ ] Impact analyzed (LSP + strings)
- [ ] Rename plan created
- [ ] Rename executed
- [ ] Verification passed (tsc/tests/lint)
- [ ] Report published
```

## When to Use
- Renaming variables, functions, classes, interfaces, types, enums
- Fixing naming convention violations
- Removing `I` prefix from interfaces
- Removing `Type` suffix from type aliases
- Converting snake_case to camelCase

## Naming Conventions

| Symbol | Convention | Example |
|--------|------------|---------|
| Variable | camelCase | `recordCount` |
| Function | camelCase + verb | `sendEmail` |
| Class | PascalCase | `UserManager` |
| Interface | PascalCase, no `I` | `User` (not `IUser`) |
| Type | PascalCase, no `Type` | `Address` (not `AddressType`) |
| Enum | PascalCase | `StatusCode` |
| Constant (module) | UPPER_SNAKE_CASE | `MAX_CONNECTIONS` |
| Constant (local) | camelCase | `const pi = 3.14` |

## Impact Areas

### Semantic (LSP)
- Imports and re-exports
- Direct references
- Inheritance chains
- Interface implementations
- Generic constraints

### String-based (grep)
- dataHooks type parameters
- Translation keys (i18n)
- Test descriptions
- Comments and JSDoc
- Config files

## Verification Gates
- [ ] `tsc --noEmit` passes
- [ ] Tests pass
- [ ] ESLint passes
- [ ] No orphaned string references

## Artifacts
- Rename plan with all changes listed
- Before/after summary
- Verification results

## Hard-fail Conditions
- Executing without analyze
- Skipping verify
- Name collision detected
- Reserved keyword used as name
- Non-local symbols without Octocode proof
