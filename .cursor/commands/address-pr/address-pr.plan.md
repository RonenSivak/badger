---
description: Create action plan per comment; produce ACTION-PLAN.md — ALL comments addressed
globs:
alwaysApply: false
---

# /address-pr.plan — Create Action Plan

Input:
- `.cursor/address-pr/<pr-number>/ANALYSIS.md`
- `.cursor/address-pr/<pr-number>/TRIAGE.md`

## Git Read-Only Reminder

**FORBIDDEN:** `git commit`, `git push`, `gh pr comment`, `gh pr review`

## For EVERY Comment (no exceptions)

Create a concrete action plan:

1) **Decide action type** (only two options):
   - `FIX` — code change needed
   - `RESPONSE` — reply to reviewer needed

2) **For FIX actions**:
   - Exact file(s) to modify
   - Line range to change
   - Description of the change
   - Code sketch (if helpful)
   - Tests to add/update

3) **For RESPONSE actions**:
   - Draft response to reviewer
   - Evidence/rationale

4) **Priority assignment**:
   - P0: Security issues
   - P1: Logic bugs
   - P2: Refactoring
   - P3: Style/nits/questions/praise

## Output

Write: `.cursor/address-pr/<pr-number>/ACTION-PLAN.md`

Template:
```markdown
# Action Plan: PR #{number}

## Summary
- Total comments: {count}
- FIX: {count}
- RESPONSE: {count}

## Summary Table (Preview)

| # | Comment | Status | Solution |
|---|---------|--------|----------|
| 1 | {summary} | FIX | `{file}:{line}` — {description} |
| 2 | {summary} | RESPONSE | {reply suggestion} |

## Priority Order

### P0 — Security (address immediately)
{list or "None"}

### P1 — Logic (must fix before merge)
{list or "None"}

### P2 — Refactoring (should fix)
{list or "None"}

### P3 — Style/Nits/Other (complete the PR)
{list or "None"}

---

## Detailed Actions

### Action #{n}: Comment #{id}
- **Type**: {FIX|RESPONSE}
- **Priority**: {P0|P1|P2|P3}
- **Category**: {logic|security|style|refactor|nit|question|praise}

#### For FIX:
- **File**: {path}
- **Lines**: {start}-{end}
- **Description**: {what to change}

\`\`\`{lang}
// Before
{current code}

// After
{proposed change}
\`\`\`

#### For RESPONSE:
- **Suggested reply**: "{draft response text}"

---
```

**REMINDER**: Git read-only mode — no commits, pushes, or PR comments. Human applies all changes.

Then instruct: "Run `/address-pr.verify`."
