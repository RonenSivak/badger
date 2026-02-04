---
description: Classify comments into categories; produce TRIAGE.md
globs:
alwaysApply: false
---

# /address-pr.triage — Classify Comments

Input:
- `.cursor/address-pr/<pr-number>/COMMENTS.md`

## ALL Comments Must Be Addressed

**No comment is "non-actionable"** — every comment gets either:
- `FIX` — code change needed
- `RESPONSE` — reply to reviewer needed

## Classification Categories

| Category | Resolution | Signals |
|----------|------------|---------|
| `logic` | FIX | Bug, incorrect behavior, missing edge case, wrong algorithm |
| `security` | FIX | Vulnerability, unsafe pattern, injection risk, auth issue |
| `style` | FIX | Naming, formatting, code style (verifiable via linter) |
| `refactor` | FIX | DRY violation, complexity, structural improvement |
| `nit` | FIX | "nit:", minor suggestion, "nice to have" |
| `question` | RESPONSE | "?", "why", clarification request — needs explanation |
| `praise` | RESPONSE | "LGTM", "looks good", "+1" — needs acknowledgment |

## Classification Process

For each comment:

1) **Check for suggestion blocks** — if present, it's a FIX
2) **Keyword scan**:
   - `nit:`, `nitpick`, `minor` → `nit` (FIX)
   - `LGTM`, `looks good`, `nice`, `great` → `praise` (RESPONSE)
   - `?`, `why`, `how come` → `question` (RESPONSE)
   - `bug`, `wrong`, `incorrect`, `broken` → `logic` (FIX)
   - `security`, `vulnerability`, `unsafe`, `injection` → `security` (FIX)
3) **AI classification** (advisory): Ask model to classify if ambiguous
4) **Record confidence**: HIGH / MEDIUM / LOW

## Output

Write: `.cursor/address-pr/<pr-number>/TRIAGE.md`

Template:
```markdown
# Triage Results

## Summary
- Total comments: {count}
- FIX needed: {count} (logic: X, security: Y, style: Z, refactor: W, nit: N)
- RESPONSE needed: {count} (question: X, praise: Y)

## Comments Requiring FIX

### Comment #{id} — {category} (confidence: {level})
- **File**: {path}:{line}
- **Body**: {truncated body}
- **Reason**: {why classified this way}
- **Has suggestion block**: {yes/no}

## Comments Requiring RESPONSE

### Comment #{id} — {category}
- **Body**: {truncated body}
- **Response type**: {explanation | acknowledgment | clarification}
```

Then instruct: "Run `/address-pr.analyze`."
