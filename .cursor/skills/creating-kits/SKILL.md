---
name: creating-kits
description: "Create new Cursor workflow kits with skills, guides, and verification. Use when you need to create a reusable workflow kit for a specific domain or task."
---

# Creating Kits

Create a new reusable Cursor workflow kit following the handbook-compliant structure.

## Quick Start
1. Clarify the kit purpose and scope (KIT SPEC)
2. Plan the file structure (FILE-MAP)
3. Scaffold the files
4. Verify wiring + references
5. Publish README + usage guide

## Workflow Checklist
Copy and track your progress:
```
- [ ] Kit spec clarified (purpose, triggers, workflow)
- [ ] File map planned (skills, guides, artifacts)
- [ ] Files scaffolded
- [ ] Verification passed (no orphan refs, valid structure)
- [ ] README published with usage guide
```

## Kit Structure (Handbook-Compliant)
```
.cursor/
├── skills/<kit-name>/SKILL.md    # Main entry point
├── guides/<kit>-*.md             # Progressive disclosure
└── kits/<kit-name>/              # Kit documentation
    ├── KIT-SPEC.md
    ├── FILE-MAP.md
    └── README.md
```

## Skill Naming Convention
Use gerund form (verb + -ing):
- Good: `processing-pdfs`, `analyzing-data`, `debugging-issues`
- Bad: `pdf-processor`, `data-analyzer`

## KIT SPEC Requirements
Must define:
- Kit name and purpose
- When to use (triggers)
- Workflow steps
- Artifacts produced
- Verification gates

## FILE-MAP Requirements
Must list:
- All files to create
- Purpose of each file
- Dependencies between files

## Verification Gates
Before publish, verify:
- [ ] SKILL.md has valid frontmatter (name, description)
- [ ] Description includes "when to use"
- [ ] SKILL.md body under 500 lines
- [ ] All file references exist (no orphans)
- [ ] Progressive disclosure works (skill → guides)

## Artifacts
All outputs go to `.cursor/kits/<kit-name>/`:
- `KIT-SPEC.md` - Kit specification
- `FILE-MAP.md` - File structure plan
- `README.md` - Usage documentation

## Hard-fail Conditions
- Publishing without verification pass
- Missing frontmatter in SKILL.md
- Orphan references (files that don't exist)
- SKILL.md over 500 lines
