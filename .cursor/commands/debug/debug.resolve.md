---
description: MCP-S + Octocode proof loop (unlimited) to resolve all non-local symbols in the trace
globs:
alwaysApply: false
---

# /debug.resolve — Proof Loop 🛰️

Goal: produce:
- `.cursor/debug/<topic>/mcp-s-notes.md`
- `.cursor/debug/<topic>/octocode-queries.md`
- `.cursor/debug/<topic>/trace-ledger.md`

Mandatory loop (unlimited iterations):
For EVERY unresolved / non-local symbol found in E2E-TRACE:
1) MCP-S classification:
   - what layer is it? (sdk/client/service/facade/runtime)
   - generated vs runtime?
   - ownership hints / internal docs pointers
2) Octocode resolution (via `/octocode/research`):
   - definition (repo/path + lines + snippet)
   - implementation (repo/path + lines + snippet)
   - side-effect boundary snippet (network/persist/render/throw)

Rules:
- Generated wrappers do NOT count: you must find generator source (proto/openapi/graphql/etc.) and runtime implementer.
- Record every Octocode query you run in `octocode-queries.md`.
- Add every external/non-local symbol to `trace-ledger.md` with proof pointers.

Stop only when:
- all symbols resolved OR
- marked NOT FOUND with: exact searches + scope (repos/packages).
