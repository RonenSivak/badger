---
description: Output final report; produce REPORT.md — NO CODE COMMITS
globs:
alwaysApply: false
---

# /address-pr.publish — Final Report

Input:
- `.cursor/address-pr/<pr-number>/VERIFICATION.md` (must be PASS)
- `.cursor/address-pr/<pr-number>/ACTION-PLAN.md`

## Pre-conditions

- **VERIFICATION.md status must be PASS**
- If not PASS, do NOT publish — go back and fix issues

## Output

Write: `.cursor/address-pr/<pr-number>/REPORT.md`

Also print summary to chat.

Template:
```markdown
# PR Review Comments Report

## PR #{number}: {title}

### Quick Stats
- **Total comments**: {n}
- **Actionable**: {n}
- **Fixes needed**: {n}
- **Responses needed**: {n}

### Priority Summary

| Priority | Category | Count | Status |
|----------|----------|-------|--------|
| P0 | Security | {n} | {action needed/none} |
| P1 | Logic | {n} | {action needed/none} |
| P2 | Refactor | {n} | {action needed/none} |
| P3 | Style | {n} | {action needed/none} |

### Action Items

#### Must Do (P0-P1)
1. **Comment #{id}** ({category}): {one-line description}
   - File: `{path}:{line}`
   - Action: {FIX|RESPOND}

#### Should Do (P2)
1. ...

#### Nice to Do (P3)
1. ...

### Suggested Responses

For non-actionable comments that need replies:

> **Comment #{id}** by @{author}:
> "{comment body truncated}"
>
> **Suggested response**:
> "{draft response}"

---

## Next Steps

1. Review this report
2. Apply fixes manually (files listed in ACTION-PLAN.md)
3. Run tests: `npm test`
4. Respond to reviewers as needed
5. Request re-review

**REMINDER**: This workflow does NOT auto-commit or push. All changes require human action.
```

## Chat Output

Print a concise summary:

```
## PR #{number} Review Comments Addressed

**Summary**: {n} comments analyzed, {n} fixes needed, {n} responses needed

**Priority breakdown**:
- P0 (Security): {n}
- P1 (Logic): {n}
- P2 (Refactor): {n}
- P3 (Style): {n}

**Full report**: `.cursor/address-pr/{pr}/REPORT.md`
**Action plan**: `.cursor/address-pr/{pr}/ACTION-PLAN.md`

Ready for you to apply changes manually.
```
