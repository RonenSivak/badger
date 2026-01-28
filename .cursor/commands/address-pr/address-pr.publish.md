---
description: Output final report with summary table — GIT READ-ONLY (no commits/push/comments)
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

## Git Read-Only Reminder

**FORBIDDEN:**
- `git commit`, `git push`
- `gh pr comment`, `gh pr review`

This step produces a REPORT only. Human applies all changes.

## Output

Write: `.cursor/address-pr/<pr-number>/REPORT.md`

Also **print the summary table to chat**.

Template:
```markdown
# PR Review Comments Report

## PR #{number}: {title}

### Summary Table — ALL Comments Addressed

| # | Comment | Status | Solution |
|---|---------|--------|----------|
| 1 | {comment summary - max 60 chars} | FIX | `{file}:{line}` — {change description} |
| 2 | {comment summary - max 60 chars} | FIX | `{file}:{line}` — {change description} |
| 3 | {comment summary - max 60 chars} | RESPONSE | {suggested reply text} |
| ... | ... | ... | ... |

### Stats
- **Total comments**: {n}
- **FIX**: {n}
- **RESPONSE**: {n}

---

### Detailed Fixes

#### Fix #{n}: Comment #{id}
- **File**: `{path}:{line}`
- **Comment**: {full comment body}
- **Change**:
\`\`\`{lang}
// Before
{old code}

// After  
{new code}
\`\`\`

---

### Detailed Responses

#### Response #{n}: Comment #{id}
- **Comment by @{author}**: "{comment body}"
- **Suggested response**: "{draft reply}"

---

## Next Steps

1. Review the summary table above
2. Apply fixes manually (code changes listed above)
3. Run tests: `npm test`
4. Copy/paste suggested responses to PR
5. Request re-review

**REMINDER**: Git read-only mode — no commits, pushes, or PR comments made by this workflow.
```

## Chat Output — MANDATORY TABLE

Print to chat:

```
## PR #{number} — All Comments Addressed

| # | Comment | Status | Solution |
|---|---------|--------|----------|
| 1 | {summary} | FIX | `{file}:{line}` — {what} |
| 2 | {summary} | RESPONSE | {reply} |
| ... | ... | ... | ... |

**Stats**: {n} total — {n} FIX, {n} RESPONSE

**Full report**: `.cursor/address-pr/{pr}/REPORT.md`

Ready for manual application. No git writes performed.
```
