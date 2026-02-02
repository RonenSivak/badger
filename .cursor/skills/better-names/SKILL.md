---
name: better-names
description: "Safely rename TypeScript identifiers following naming conventions, with impact analysis (LSP + string usages) and verification (typecheck/tests/lint). Use when renaming symbols or fixing naming convention violations."
---

# Better-Names Skill

Purpose: Safely rename TypeScript identifiers following industry-standard naming conventions with comprehensive impact analysis.

## When to Use

- Renaming variables, functions, classes, interfaces, types, enums
- Fixing naming convention violations
- Removing `I` prefix from interfaces
- Removing `Type` suffix from type aliases
- Converting snake_case to camelCase

## Quick Start

```
/better-names
```

Then provide:
1. What symbol to rename
2. What the new name should be (or ask for suggestion)
3. Scope (file, package, monorepo)

## Workflow Steps

1. **Clarify** — Gather target symbol and new name
2. **Validate** — Check new name against conventions
3. **Analyze** — Find all impact areas (semantic + strings)
4. **Plan** — Generate concrete rename plan
5. **Execute** — Perform LSP rename + string updates
6. **Verify** — Type-check, test, lint
7. **Publish** — Summary report

## Naming Convention Quick Reference

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

## Impact Areas Checked

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

## Example Prompts

- "Rename `IUserService` to `UserService`"
- "Fix naming: `get_user_data` should be `getUserData`"
- "Remove I prefix from all interfaces in `src/types/`"

## Related Files

- KIT-SPEC: `.cursor/kits/better-names/KIT-SPEC.md`
- Commands: `.cursor/commands/better-names/`
- Rules: `.cursor/rules/better-names/`
