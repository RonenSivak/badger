---
description: Create action plan per comment; produce ACTION-PLAN.md
globs:
alwaysApply: false
---

# /address-pr.plan — Create Action Plan

Input:
- `.cursor/address-pr/<pr-number>/ANALYSIS.md`
- `.cursor/address-pr/<pr-number>/TRIAGE.md`

## For Each Actionable Comment

Create a concrete action plan:

1) **Decide action type**:
   - `FIX` — implement the change
   - `RESPOND` — reply to reviewer explaining why no change
   - `DISCUSS` — needs sync with reviewer/team
   - `DEFER` — valid but out of scope for this PR

2) **For FIX actions**:
   - Exact file(s) to modify
   - Line range to change
   - Description of the change
   - Code sketch (if helpful)
   - Tests to add/update

3) **For RESPOND actions**:
   - Draft response to reviewer
   - Evidence/rationale

4) **Priority assignment**:
   - P0: Security issues
   - P1: Logic bugs
   - P2: Refactoring
   - P3: Style/nits

## Output

Write: `.cursor/address-pr/<pr-number>/ACTION-PLAN.md`

Template:
```markdown
# Action Plan: PR #{number}

## Summary
- Total actions: {count}
- FIX: {count}
- RESPOND: {count}
- DISCUSS: {count}
- DEFER: {count}

## Priority Order

### P0 — Security (address immediately)
{list or "None"}

### P1 — Logic (must fix before merge)
{list or "None"}

### P2 — Refactoring (should fix)
{list or "None"}

### P3 — Style/Nits (nice to fix)
{list or "None"}

---

## Detailed Actions

### Action #{n}: Comment #{id}
- **Type**: {FIX|RESPOND|DISCUSS|DEFER}
- **Priority**: {P0|P1|P2|P3}
- **Category**: {logic|security|style|refactor}

#### Change Plan
- **File**: {path}
- **Lines**: {start}-{end}
- **Description**: {what to change}

#### Code Sketch
\`\`\`{lang}
// Before
{current code}

// After
{proposed change}
\`\`\`

#### Tests
- [ ] {test file}: {test description}

---
```

**REMINDER**: This plan is for human review. Do NOT auto-commit or push.

Then instruct: "Run `/address-pr.verify`."
