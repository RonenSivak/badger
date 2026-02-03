# update-kit

Update existing Cursor workflow kits to align with current best practices and structure.

## Quick Start

```
/update-kit <kit-name>
```

## What It Does

1. **Analyzes** an existing kit's structure
2. **Compares** against best practices from other kits
3. **Plans** specific updates (add/modify files)
4. **Executes** changes with automatic backup
5. **Verifies** the updated kit passes all checks
6. **Publishes** a changelog of what changed

## When to Use

- Kit is missing frontmatter on files
- Kit lacks a `<kit>-laws.mdc` rules file
- Kit has no SKILL.md
- References are broken or orphaned
- Kit structure doesn't match current patterns

## Workflow

```
/update-kit.clarify  → Identify kit + goals
/update-kit.analyze  → Scan structure, find gaps
/update-kit.plan     → Create update actions
/update-kit.execute  → Apply changes (with backup)
/update-kit.verify   → Check all gates pass
/update-kit.publish  → Summary + changelog
```

## Safety

- **Always backs up** files before modifying
- **Fail-fast** on critical errors
- **Verify before publish** ensures consistency

## Best Practices Enforced

### Structure
- Orchestrator at `.cursor/commands/<kit>.md`
- Subcommands in `.cursor/commands/<kit>/`
- Rules in `.cursor/rules/<kit>/`
- Skill at `.cursor/skills/<kit>/SKILL.md`

### Frontmatter
- All `.md`/`.mdc` files have `description`, `globs`, `alwaysApply`

### Content
- Orchestrator lists subcommands with paths
- Orchestrator references enforced rules
- Laws file has workflow gates
- Skill has Quick Start, Workflow, Key Rules sections

## Examples

```bash
# Full update
/update-kit review

# Focus on frontmatter only
/update-kit testkit --focus frontmatter

# Add missing rules
/update-kit continue --add-missing-rules
```

## Related

- `/create-kit` — Create a new kit from scratch
