---
description: Classify comments into categories; produce TRIAGE.md
globs:
alwaysApply: false
---

# /address-pr.triage — Classify Comments

Input:
- `.cursor/address-pr/<pr-number>/COMMENTS.md`

## Classification Categories

| Category | Actionable | Signals |
|----------|------------|---------|
| `logic` | YES | Bug, incorrect behavior, missing edge case, wrong algorithm |
| `security` | YES | Vulnerability, unsafe pattern, injection risk, auth issue |
| `style` | YES | Naming, formatting, code style (verifiable via linter) |
| `refactor` | YES | DRY violation, complexity, structural improvement |
| `nit` | OPTIONAL | "nit:", minor suggestion, "nice to have" |
| `question` | NO | "?", "why", clarification request |
| `praise` | NO | "LGTM", "looks good", "+1", positive feedback |

## Classification Process

For each comment:

1) **Check for suggestion blocks** — if present, likely actionable
2) **Keyword scan**:
   - `nit:`, `nitpick`, `minor` → `nit`
   - `LGTM`, `looks good`, `nice`, `great` → `praise`
   - `?`, `why`, `how come` → `question`
   - `bug`, `wrong`, `incorrect`, `broken` → `logic`
   - `security`, `vulnerability`, `unsafe`, `injection` → `security`
3) **AI classification** (advisory): Ask model to classify if ambiguous
4) **Record confidence**: HIGH / MEDIUM / LOW

## Output

Write: `.cursor/address-pr/<pr-number>/TRIAGE.md`

Template:
```markdown
# Triage Results

## Summary
- Total comments: {count}
- Actionable: {count} (logic: X, security: Y, style: Z, refactor: W)
- Optional: {count} (nit)
- Non-actionable: {count} (question: X, praise: Y)

## Actionable Comments

### Comment #{id} — {category} (confidence: {level})
- **File**: {path}:{line}
- **Body**: {truncated body}
- **Reason**: {why classified this way}
- **Has suggestion block**: {yes/no}

## Non-Actionable Comments

### Comment #{id} — {category}
- **Body**: {truncated body}
- **Reason**: {why non-actionable}
```

Then instruct: "Run `/address-pr.analyze`."
