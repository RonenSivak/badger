---
name: better-names
description: "Safely rename TypeScript identifiers. Trigger: /better-names"
disable-model-invocation: true
---

# Better-Names Skill

Safely rename TypeScript identifiers with impact analysis and verification.

## Quick Start

```bash
/better-names
```

Provide: symbol to rename, new name, scope (file/package/monorepo)

## Key Rules

1. **LSP + String sweep** — Find all semantic and string usages
2. **Verify after rename** — typecheck, test, lint must pass
3. **Follow conventions** — camelCase for variables, PascalCase for types

## Full Documentation

See `.cursor/commands/better-names.md` for naming conventions and workflow.
