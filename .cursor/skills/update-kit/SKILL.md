---
name: update-kit
description: "Update existing Cursor workflow kits to align with current best practices and structure. Use when a kit needs modernization, missing elements, or consistency fixes."
---

# update-kit Skill

Update existing Cursor workflow kits to match current best practices.

## Quick Start

```
/update-kit <kit-name>
```

Example:
```
/update-kit deep-search
```

## Workflow

1. **Clarify** → Identify kit, gather update goals → `UPDATE-SPEC.md`
2. **Analyze** → Scan structure, compare vs best practices → `ANALYSIS.md`
3. **Plan** → Create update actions → `UPDATE-PLAN.md`
4. **Execute** → Apply changes with backup
5. **Verify** → Check all gates pass → `VERIFY-RESULT.md`
6. **Publish** → Summary + changelog → `CHANGE-LOG.md`

## Key Rules

1. **Always backup before modifying** — Files backed up to `.cursor/update-kit/<kit>/backup/`
2. **Verify before publish** — Must pass verification gate
3. **Kit must exist** — Cannot update non-existent kit (use `/create-kit` instead)
4. **Preserve content** — Only change what needs fixing

## Best Practices Checklist

### Structure
- Orchestrator at `.cursor/commands/<kit>.md`
- Subcommands in `.cursor/commands/<kit>/`
- Rules in `.cursor/rules/<kit>/`
- Skill at `.cursor/skills/<kit>/SKILL.md`

### Frontmatter (all .md/.mdc)
- `description` — meaningful purpose
- `globs` — file patterns (may be empty)
- `alwaysApply` — typically false

### Orchestrator
- Lists all subcommands with paths
- References enforced rules
- Documents workflow steps
- Lists hard-fail conditions

### Rules
- `<kit>-laws.mdc` with workflow gates
- Reuse common rules where applicable

### Skill
- Quick Start section
- Workflow summary
- Key Rules section
- Examples section

## Update Goals

| Goal | Description |
|------|-------------|
| `full` | Align everything to best practices |
| `frontmatter` | Fix missing/broken frontmatter only |
| `rules` | Add missing rules like `<kit>-laws.mdc` |
| `skill` | Add or update SKILL.md |
| `refs` | Fix orphan references |

## Examples

**Full update:**
```
/update-kit review
```

**Frontmatter only:**
```
/update-kit testkit --focus frontmatter
```

**Add missing rules:**
```
/update-kit continue --add-missing-rules
```

## Files Generated

```
.cursor/update-kit/<kit>/
├── UPDATE-SPEC.md      # Update goals
├── ANALYSIS.md         # Current state + gaps
├── UPDATE-PLAN.md      # Planned actions
├── EXECUTION-LOG.md    # What was done
├── VERIFY-RESULT.md    # Pass/fail
├── CHANGE-LOG.md       # Final summary
└── backup/             # Original files
```

## Related Commands

- `/create-kit` — Create a new kit from scratch
- `/create-kit.verify` — Reused for verification logic
