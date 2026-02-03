---
description: Scan existing kit structure and compare against best practices
globs:
alwaysApply: false
---

# /update-kit.analyze — Analysis

Scan the target kit and identify gaps vs best practices.

## Inputs
- `.cursor/update-kit/<kit>/UPDATE-SPEC.md`

## Analysis Checklist

### 1. Structure Check
Verify existence of:
- [ ] `.cursor/commands/<kit>.md` — Orchestrator
- [ ] `.cursor/commands/<kit>/` — Subcommands folder
- [ ] `.cursor/rules/<kit>/` — Rules folder
- [ ] `.cursor/rules/<kit>/<kit>-laws.mdc` — Laws file
- [ ] `.cursor/skills/<kit>/SKILL.md` — Skill file
- [ ] `.cursor/kits/<kit>/` — Kit docs folder

### 2. Frontmatter Check
For each `.md` and `.mdc` file in the kit:
- [ ] Has `description`
- [ ] Has `globs`
- [ ] Has `alwaysApply`

### 3. Orchestrator Check
- [ ] Lists all subcommands with paths
- [ ] References enforced rules
- [ ] Documents workflow steps (numbered)
- [ ] Lists hard-fail conditions
- [ ] Has "Delegates to:" section

### 4. Subcommand Check
For each subcommand:
- [ ] Has clear purpose in description
- [ ] Documents inputs
- [ ] Documents outputs (if any)
- [ ] Ends with "next step" instruction

### 5. Rules Check
- [ ] `<kit>-laws.mdc` exists
- [ ] Laws include workflow gates
- [ ] References to common rules are valid

### 6. Skill Check
- [ ] Has Quick Start section
- [ ] Has Workflow section
- [ ] Has Key Rules section
- [ ] Has Examples section

### 7. Reference Integrity
- [ ] All "Delegates to:" paths exist
- [ ] All "Enforces:" rule paths exist
- [ ] No orphan files (files not referenced by orchestrator)

## Compare to Golden Kits

Compare against well-structured kits:
- `implement-ui` — Full structure with MCP reference
- `review` — Many subcommands, impact sweep
- `create-kit` — Meta kit, verification gates

## Output

Write `.cursor/update-kit/<kit>/ANALYSIS.md`:
```markdown
# Analysis: <kit>

## Current State
- Orchestrator: EXISTS/MISSING
- Subcommands: X found
- Rules: X found
- Skill: EXISTS/MISSING

## Gaps Found

### Critical (must fix)
1. <gap> — <reason>

### Recommended (should fix)
1. <gap> — <reason>

### Optional (nice to have)
1. <gap> — <reason>

## Files Inventory
| File | Status | Issues |
|------|--------|--------|
| path | OK/ISSUE | description |
```

End with: "Run `/update-kit.plan`."
