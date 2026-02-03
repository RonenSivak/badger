---
name: optimize-code
description: "Systematically simplify TypeScript/React code with staged refactors and verification (tests/types/lint). Use when asked to simplify code, reduce complexity, remove duplication, or improve maintainability."
---

# Skill: /optimize-code

Systematically simplify TypeScript code following the "Best Practices for Simplifying TypeScript Code" guide.

## When to Use

- Code review suggests "simplify this"
- File is hard to read or maintain
- High cyclomatic complexity
- Many `any` types
- Deep nesting / arrowhead pattern
- Duplicated logic

## Quick Start

```
/optimize-code <file-or-directory>
```

Example:
```
/optimize-code src/components/MyComponent.tsx
/optimize-code src/utils/
```

## Workflow

1. **Clarify** — Define scope, goals, constraints
2. **Analyze** — Scan for violations, measure metrics
3. **Plan** — Order refactors (quick wins first)
4. **Execute** — Apply one-by-one with verification
5. **Verify** — Tests, types, lint all pass
6. **Publish** — Summary with before/after metrics

## Principles (passive context)
The detailed principles live in rules so they’re always available without requiring skill invocation:
- TypeScript: `.cursor/rules/optimize-code/ts-core-principles.mdc`
- React: `.cursor/rules/optimize-code/react-principles.mdc`
- React Query: `.cursor/rules/optimize-code/react-query-principles.mdc`
- React Hook Form: `.cursor/rules/optimize-code/react-hook-form-principles.mdc`

## Key Rules

- One refactor at a time
- Tests must pass after each change
- Never introduce new `any`
- Quick wins before deep cleans

## Related Files

- Orchestrator: `.cursor/commands/optimize-code.md`
- Laws: `.cursor/rules/optimize-code/optimize-code-laws.mdc`
- TS Principles: `.cursor/rules/optimize-code/ts-core-principles.mdc`
- React Principles: `.cursor/rules/optimize-code/react-principles.mdc`
- React Query: `.cursor/rules/optimize-code/react-query-principles.mdc`
- React Hook Form: `.cursor/rules/optimize-code/react-hook-form-principles.mdc`
- Kit Spec: `.cursor/kits/optimize-code/KIT-SPEC.md`
