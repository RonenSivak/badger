---
description: Load deep-search outputs and convert them into an Implementation Spec for a new agent context
globs:
alwaysApply: false
---

# /deep-implement.load — Context Loader (deep-search → implementable spec)

Hard rule:
Deep-search outputs are the canonical context. Don’t re-derive what already exists.

## Inputs
- `.cursor/deep-search/<feature>/...`
- Implementation request summary (from clarify)

## Actions
1) Read these (if missing, note it):
- `ARCHITECTURE-REPORT.md` (or draft)
- `trace-ledger.md` / `TRACE-LEDGER.md`
- `VALIDATION-REPORT.md` (if exists)
- change surface checklist (file or section)

2) Extract:
- the E2E flow steps (producer → storage → consumer)
- the exact “change surfaces” list
- the risky couplings + pitfalls
- the “must not break” contracts

3) Create implementation workspace:
- `.cursor/deep-implement/<task>/`

## Outputs (write files)
1) `.cursor/deep-implement/<task>/IMPLEMENTATION-SPEC.md`
Include:
- summary
- acceptance criteria
- referenced deep-search files
- the change surfaces checklist (as TODO list)

2) `.cursor/deep-implement/<task>/SCOPE.md`
Include:
- in-scope repos/packages/services
- out-of-scope
- required MCPs: `/octocode/research` + MCP-S
