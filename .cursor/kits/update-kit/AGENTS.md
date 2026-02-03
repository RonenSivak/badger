# update-kit Kit - Agent Instructions

IMPORTANT: Prefer retrieval-led reasoning. Read existing kit files before modifying.

## Commands
```bash
/update-kit                  # Orchestrator
/update-kit.clarify         # Identify kit + goals
/update-kit.analyze         # Scan structure, find gaps
/update-kit.plan            # Create update actions
/update-kit.execute         # Apply changes (with backup)
/update-kit.verify          # Check all gates pass
/update-kit.publish         # Summary + changelog
```

## Best Practices Enforced

### Structure
- Orchestrator: `.cursor/commands/<kit>.md`
- Subcommands: `.cursor/commands/<kit>/<kit>.<phase>.md`
- Rules: `.cursor/rules/<kit>/`
- Skill: `.cursor/skills/<kit>/SKILL.md`
- **NEW**: AGENTS.md: `.cursor/kits/<kit>/AGENTS.md`

### Frontmatter (all .md/.mdc files)
```yaml
---
description: "Clear description"
globs: "pattern" # or empty
alwaysApply: false
---
```

### Content Requirements
- Orchestrator lists subcommands with paths
- Orchestrator references enforced rules
- Laws file has workflow gates
- AGENTS.md has commands, MCPs, boundaries
- Skill has Quick Start, Workflow, Key Rules

## Boundaries

### ✅ Always
- Create backup before modifying files
- Verify kit passes all gates before publishing
- Add AGENTS.md to every kit

### ⚠️ Ask First
- Deleting files
- Changing rule globs

### 🚫 Never
- Modify without backup
- Skip verification gate
- Remove existing functionality without approval

## Verification Checklist
- [ ] All files have frontmatter
- [ ] Orchestrator references all subcommands
- [ ] Rules have correct globs
- [ ] AGENTS.md exists with commands/MCPs/boundaries
- [ ] SKILL.md has Quick Start section
