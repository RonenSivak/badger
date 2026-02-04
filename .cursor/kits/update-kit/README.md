# Updating Kits

Update existing Cursor workflow kits to align with current best practices and structure.

## What It Does

1. **Analyzes** an existing kit's structure
2. **Compares** against best practices
3. **Plans** specific updates (add/modify files)
4. **Executes** changes with automatic backup
5. **Verifies** the updated kit passes all checks
6. **Publishes** a changelog of what changed

## When to Use

- Kit is missing SKILL.md
- Kit structure doesn't match handbook-compliant patterns
- References are broken or orphaned
- Kit needs modernization

## Quick Start

```
Update the implement-ui kit to follow current best practices
```

## Workflow

1. **Clarify** — Identify kit + update goals
2. **Analyze** — Scan structure, find gaps
3. **Plan** — Create update actions
4. **Execute** — Apply changes (with backup)
5. **Verify** — Check all gates pass
6. **Publish** — Summary + changelog

## Safety

- **Always backs up** files before modifying
- **Fail-fast** on critical errors
- **Verify before publish** ensures consistency

## Best Practices Enforced (Handbook-Compliant)

### Structure
- Skill at `.cursor/skills/<kit>/SKILL.md` (main entry point)
- Guides in `.cursor/guides/` for progressive disclosure
- Kit docs in `.cursor/kits/<kit>/`

### Skill Requirements
- `name` field (gerund form: `processing-data`)
- `description` includes "when to use"
- Body under 500 lines
- Progressive disclosure to guides

### Content
- Workflow checklist included
- Hard-fail conditions documented
- No orphan references

## Related

- `creating-kits` skill — Create a new kit from scratch
