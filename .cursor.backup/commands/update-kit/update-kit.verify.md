---
description: Verify updated kit passes all quality gates
globs:
alwaysApply: false
---

# /update-kit.verify — Verification

Verify the updated kit is correct and complete.

## Inputs
- `.cursor/update-kit/<kit>/UPDATE-PLAN.md`
- `.cursor/update-kit/<kit>/EXECUTION-LOG.md`

## Verification Checks

### 1. Frontmatter Check (MANDATORY)
For every `.md` and `.mdc` file in the kit:
- [ ] Has `description` (non-empty)
- [ ] Has `globs` (may be empty)
- [ ] Has `alwaysApply` (boolean)

### 2. Reference Integrity (MANDATORY)
- [ ] All "Delegates to:" paths exist
- [ ] All "Enforces:" rule paths exist
- [ ] All skill references exist
- [ ] No circular delegation (unless intentional)

### 3. Naming Consistency (MANDATORY)
- [ ] Command file names match command names
- [ ] Rule folder matches kit name
- [ ] Skill folder matches kit name

### 4. Structure Completeness
- [ ] Orchestrator has workflow steps
- [ ] Orchestrator has hard-fail conditions
- [ ] Laws file has workflow gates
- [ ] Skill has required sections

### 5. Execution Verification
- [ ] All planned actions completed
- [ ] No failed actions blocking functionality

## Reuse create-kit.verify Logic

This verify step uses the same checks as `/create-kit.verify`:
- Frontmatter validation
- Reference integrity
- Naming consistency

## Output

Write `.cursor/update-kit/<kit>/VERIFY-RESULT.md`:
```markdown
# Verify Result: <kit>

## Status: PASS / FAIL

## Checks

### Frontmatter
| File | Status | Issue |
|------|--------|-------|
| path | OK/FAIL | description |

### References
| Reference | Status | Issue |
|-----------|--------|-------|
| delegate/rule | OK/FAIL | description |

### Naming
| Item | Status | Issue |
|------|--------|-------|
| item | OK/FAIL | description |

## Summary
- Total checks: X
- Passed: X
- Failed: X

## Next Steps
<instructions based on result>
```

If FAIL:
- List specific issues to fix
- Instruct to fix and re-run `/update-kit.verify`

If PASS:
- Instruct to run `/update-kit.publish`
