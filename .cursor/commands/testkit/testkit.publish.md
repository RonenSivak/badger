---
description: Publish summary to chat + keep evidence files (only after verify passes)
globs:
alwaysApply: false
---

# /testkit.publish — Publish 📣

Precondition:
- `.cursor/testkit/<feature>/VALIDATION-REPORT.md` exists and PASS.

Publish to chat:
- what was added (files)
- which example patterns were copied (links)
- confirmation of constraints (BDD/WDS/builders)
- if any NOT FOUND remains, list it with searches + scope

Ensure these exist on disk:
- TEST-SPEC.md
- EXAMPLES.md
- MCP-EVIDENCE.md
- VALIDATION-REPORT.md
- IMPLEMENTATION-NOTES.md
