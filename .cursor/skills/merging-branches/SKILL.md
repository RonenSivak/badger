---
name: merging-branches
description: "Safely merge branches with conflict resolution and blast-radius analysis. Use when you need to merge, forward-port, or integrate branches with potential conflicts."
---

# Merging Branches (Smart Merge)

Safe branch merging: simulate → resolve → verify → publish.

## Quick Start
1. Clarify merge intent (source → target, strategy)
2. Simulate the merge to identify conflicts
3. Plan conflict resolution using existing patterns
4. Resolve conflicts with ownership context
5. Verify with real checks (tests/lint/tsc)
6. Scan blast radius
7. Publish merge result

## Workflow Checklist
Copy and track your progress:
```
- [ ] Merge intent clarified (source, target, strategy)
- [ ] Merge simulated (conflicts identified)
- [ ] Resolution plan created
- [ ] Conflicts resolved (using patterns + ownership)
- [ ] Verification passed (tests/lint/tsc)
- [ ] Blast radius scanned
- [ ] Merge published
```

## Merge Strategies

| Strategy | When to Use |
|----------|-------------|
| **merge** | Standard merge, preserves history |
| **rebase** | Linear history preferred |
| **squash** | Clean single commit |

## Conflict Resolution Principles
1. Understand intent from both sides
2. Check ownership (who wrote each version)
3. Find existing patterns in codebase
4. Prefer the more recent semantic intent
5. When in doubt, ask

## Verification Gates
Before completing merge:
- [ ] All conflicts resolved
- [ ] Tests pass
- [ ] TypeScript compiles
- [ ] Linter passes
- [ ] No unintended file deletions

## Blast Radius Scan
After merge, check:
- Which files were modified?
- Which consumers are affected?
- Any breaking changes introduced?

## Artifacts
- `.cursor/smart-merge/<merge>/MERGE-PLAN.md`
- `.cursor/smart-merge/<merge>/CONFLICT-RESOLUTION.md`
- `.cursor/smart-merge/<merge>/BLAST-RADIUS.md`

## Hard-fail Conditions
- Completing merge without verification
- Force-pushing without explicit permission
- Unresolved conflicts remaining
- Tests failing after merge

## Git Safety
- NEVER force push to main/master
- NEVER skip hooks unless explicitly requested
- Always verify before completing
