---
description: Scaffold the kit files from FILE-MAP
globs:
alwaysApply: false
---

# /create-kit.scaffold — Generate Files

Input:
- `.cursor/kits/<kit-name>/KIT-SPEC.md`
- `.cursor/kits/<kit-name>/FILE-MAP.md`

Actions:
1) Create the directories listed in FILE-MAP.
2) Generate each file with correct `.mdc` frontmatter if applicable.
3) Ensure references are real:
   - Orchestrator delegates exist
   - Rules referenced exist
   - Skills referenced exist
4) Keep files small and modular; avoid duplicating text across commands—link to rules/skills instead.

Output:
- All kit files created in-place under `.cursor/...` (and `.cursor/kits/<kit-name>/...`).
- Do not “publish” usage instructions yet. Tell user to run `/create-kit.verify`.
