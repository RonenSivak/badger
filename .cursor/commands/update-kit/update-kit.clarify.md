---
description: Identify which kit to update and gather update goals
globs:
alwaysApply: false
---

# /update-kit.clarify — Clarification

Identify the target kit and update scope.

## Steps

1) **Identify kit name**
   - If provided in command: validate it exists
   - If not provided: list available kits, ask user to choose

2) **Validate kit exists**
   - Check for orchestrator at `.cursor/commands/<kit>.md`
   - If not found: STOP, inform user, suggest `/create-kit`

3) **Gather update goals**
   Ask or infer:
   - Full refresh (align everything to best practices)
   - Frontmatter only (fix missing/broken frontmatter)
   - Add missing rules (create standard rules like `<kit>-laws.mdc`)
   - Add missing skill (create SKILL.md)
   - Fix references (resolve orphan delegates/rules)
   - Custom goal (user specifies)

4) **List available kits**
   Scan `.cursor/commands/` for orchestrator files:
   ```
   .cursor/commands/<kit>.md  →  kit name = <kit>
   ```

## Output

Write `.cursor/update-kit/<kit>/UPDATE-SPEC.md`:
```markdown
# Update Spec: <kit>

## Target Kit
- Name: <kit>
- Orchestrator: .cursor/commands/<kit>.md

## Update Goals
- [ ] Goal 1
- [ ] Goal 2

## Scope
- Focus areas: <list>
- Exclude: <list>
```

End with: "Run `/update-kit.analyze`."
