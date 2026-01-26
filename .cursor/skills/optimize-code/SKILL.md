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

## 12 Core TypeScript Principles

1. Single Responsibility
2. Clear Naming
3. Immutability
4. Reduce Nesting (guard clauses)
5. No Flag Parameters
6. Leverage Types
7. Use Built-in Methods
8. DRY Carefully
9. Composition Over Inheritance
10. Separation of Concerns
11. Strategic Error Handling
12. Simple Tests

## 10 React-Specific Principles

1. Single-Responsibility Components
2. State Colocation
3. Limit Prop Drilling
4. Composition Over Conditionals
5. Custom Hooks for Reusable Logic
6. Minimal Props Interface
7. TypeScript Safety at Boundaries
8. YAGNI and KISS
9. Readability Over Cleverness
10. Design for Testing

## Key Rules

- One refactor at a time
- Tests must pass after each change
- Never introduce new `any`
- Quick wins before deep cleans

## Related Files

- Orchestrator: `.cursor/commands/optimize-code.md`
- Laws: `.cursor/rules/optimize-code/optimize-code-laws.mdc`
- Principles: `.cursor/rules/optimize-code/ts-simplification-principles.mdc`
- Kit Spec: `.cursor/kits/optimize-code/KIT-SPEC.md`
