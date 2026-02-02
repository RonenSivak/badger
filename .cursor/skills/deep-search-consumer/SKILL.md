---
name: deep-search-consumer
description: "Use deep-search artifacts as portable context to implement changes safely, re-pin non-local symbols with /octocode/research, and carry forward pitfalls/contracts. Use when implementing from an existing deep-search report."
---

# Skill: deep-search-consumer

Goal:
Help a fresh agent use deep-search outputs as “portable context” to implement changes safely.

Inputs (expected artifacts):
- `.cursor/deep-search/<feature>/ARCHITECTURE-REPORT.md`
- `.cursor/deep-search/<feature>/trace-ledger.md`
- `.cursor/deep-search/<feature>/VALIDATION-REPORT.md` (optional)
- change surface checklist (file or section)

How to use:
1) Treat the E2E flow + change surface checklist as the implementation map.
2) Do NOT re-invent discovery: only re-search if:
   - the report has NOT FOUND
   - you need updated info after code moved
3) When deep-search references non-local repos/packages:
   - use `/octocode/research` to re-pin definition + implementation + boundary.
4) Always carry forward:
   - risky couplings/pitfalls
   - contracts/IDL sources and generated SDK chain

Outputs this skill supports:
- IMPLEMENTATION-SPEC.md
- SCOPE.md
- PLAN.md
