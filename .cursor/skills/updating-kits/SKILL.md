---
name: updating-kits
description: "Update existing Cursor workflow kits to align with current best practices and structure. Use when a kit needs modernization, missing elements, or consistency fixes."
---

# Updating Kits

Update existing Cursor workflow kits to match current best practices.

> **Reference**: [Wix Coding Agents Handbook](https://github.com/wix-private/coding-agents-handbook)

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

## Best Practices Checklist (Handbook-Aligned)

Per the [Wix Coding Agents Handbook](https://github.com/wix-private/coding-agents-handbook):

### Preferred Structure
- **AGENTS.md** — Persistent context (always available, project-specific)
- **Skills** at `.cursor/skills/<kit>/SKILL.md` — Action-specific workflows
- **Guides** at `.cursor/guides/` — Domain-specific knowledge (progressive disclosure)

### Deprecated (avoid)
- ~~`.cursor/rules/`~~ — Use AGENTS.md instead
- ~~`.cursor/commands/`~~ — Use skills instead

### Skill Structure
- `name` and `description` in frontmatter
- Quick Start section
- Workflow summary
- Key Rules section
- Examples section
- References to guides for detailed patterns

### AGENTS.md Guidelines
- Keep it small and focused (every token loads on every request)
- Use progressive disclosure — move domain-specific rules to separate files (guides)
- Reference skills and guides rather than duplicating content

## Update Goals

| Goal | Description |
|------|-------------|
| `full` | Align everything to best practices |
| `frontmatter` | Fix missing/broken frontmatter only |
| `skill` | Add or update SKILL.md |
| `refs` | Fix orphan references |
| `handbook` | Migrate rules/commands to skills/AGENTS.md |

## Examples

**Full update:**
```
/update-kit review
```

**Frontmatter only:**
```
/update-kit testkit --focus frontmatter
```

**Migrate to handbook structure:**
```
/update-kit testkit --focus handbook
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

## Related Skills

- [creating-kits](../creating-kits/SKILL.md) — Create a new kit from scratch
