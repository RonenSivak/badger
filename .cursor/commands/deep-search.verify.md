---
description: Validate DRAFT report is correct by proving edges are connected (imports/calls)
globs:
alwaysApply: false
---

# /deep-search.verify — Connectivity Validation (MANDATORY)

## Inputs
- `.cursor/deep-search/<feature>/ARCHITECTURE-REPORT.draft.md`
- `.cursor/deep-search/<feature>/trace-ledger.md`
- `.cursor/deep-search/<feature>/octocode-queries.md`

## Validate (Hard)
For every A -> B hop claimed in the draft:

1) Existence check
- path exists locally OR proven via Octocode result snippet.

2) Connectivity check (the key fix)
You MUST show at least one of:
- A imports B (import/require)
- A calls B (call-site)
- A references a concrete identifier in B (symbol usage)
- For services: A’s request maps to B’s handler (route/rpc method binding)

“Similar folder/function name” is NOT proof.

3) Cross-repo re-proof
If a hop crosses repos:
- rerun `/octocode/research` for the exact symbol(s)
- append verification queries to `octocode-queries.md`

4) Mermaid check
Every mermaid edge must map to at least one validated hop proof.

## Output
Write:
- `.cursor/deep-search/<feature>/VALIDATION-REPORT.md`

Include:
- Broken claims (with corrected pointers)
- Verified edge list (A -> B with evidence pointers)
- Remaining NOT FOUND (queries + scope)

## Cursor review step (recommended)
After validation, instruct user to also run Cursor Review tools (Find Issues / PR Review) as an extra safety net.
