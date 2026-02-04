---
description: Publish kit README + quickstart after verification passes
globs:
alwaysApply: false
---

# /create-kit.publish — Publish

Precondition:
- `.cursor/kits/<kit-name>/VERIFY-RESULT.md` is PASS

Actions:
1) Finalize `.cursor/kits/<kit-name>/README.md` with:
   - what it does
   - prerequisites (tools/MCPs)
   - install steps (copy `.cursor/`)
   - quickstart prompts
   - file list (commands/rules/skills)
   - what gets generated during runs
2) Print in chat:
   - 5–10 line quickstart
   - example prompt
   - “what to do next”

Hard rule:
- If verify is not PASS → do not publish.
