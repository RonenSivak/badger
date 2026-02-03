---
name: optimize-code
description: "Simplify TypeScript/React code with staged refactors. Trigger: /optimize-code <path>"
disable-model-invocation: true
---

# Optimize-Code Skill

Systematically simplify TypeScript code with verification.

## Quick Start

```bash
/optimize-code src/components/MyComponent.tsx
/optimize-code src/utils/
```

## Key Rules

1. **Quick wins first** — Start with lowest-risk refactors
2. **One at a time** — Apply and verify each change
3. **Tests must pass** — No refactor without green tests

## Full Documentation

See `.cursor/kits/optimize-code/AGENTS.md` for patterns and boundaries.
