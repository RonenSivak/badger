---
description: Gather scope, goals, and constraints for code optimization
globs:
alwaysApply: false
---

# /optimize-code.clarify — Scope Definition

Gather information to produce `OPTIMIZATION-SPEC.md`.

## Questions to Ask

1. **Target**: What file(s) or directory to optimize?
2. **Goals**: What matters most?
   - [ ] Readability (cleaner, shorter)
   - [ ] Type safety (remove `any`, add discriminated unions)
   - [ ] Performance (memoization, reduce re-renders)
   - [ ] Testability (extract pure functions, DI)
3. **Constraints**:
   - Must preserve public API? (yes/no)
   - Time budget? (quick wins only / full deep clean)
   - Test coverage requirement?

## Output

Create `.cursor/optimize-code/<target-name>/OPTIMIZATION-SPEC.md`:

```markdown
# OPTIMIZATION-SPEC

## Target
<file or directory path>

## Goals
- [ ] Readability
- [ ] Type safety
- [ ] Performance
- [ ] Testability

## Constraints
- Preserve API: yes/no
- Scope: quick-wins / deep-clean / both
- Must pass: <test command>

## Notes
<any additional context>
```

## Next Step
When complete, instruct: "Run `/optimize-code.analyze`."
