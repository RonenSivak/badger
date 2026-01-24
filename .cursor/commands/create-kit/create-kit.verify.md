---
description: Verify kit wiring, frontmatter, and reference integrity
globs:
alwaysApply: false
---

# /create-kit.verify — Verification Gate

Verify the newly scaffolded kit is internally consistent.

Checks (must pass):
1) **Frontmatter present** on every `.mdc` file:
   - description
   - alwaysApply
   - globs (may be empty)
2) **No orphan references**:
   - orchestrator delegates all exist
   - referenced rules exist
   - referenced skills exist
3) **No circular delegation** unless explicitly intended
4) **Naming consistency**:
   - command file name matches command name
   - kit folder name matches KIT SPEC
5) **README exists** (draft is fine; publish will finalize)

Write:
- `.cursor/kits/<kit-name>/VERIFY-RESULT.md`
  - PASS/FAIL
  - broken references list
  - missing frontmatter list

If FAIL:
- instruct to fix, then re-run `/create-kit.verify`.

If PASS:
- instruct to run `/create-kit.publish`.
