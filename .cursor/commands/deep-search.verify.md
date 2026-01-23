---
description: Validate DRAFT report is correct by proving edges are connected (imports/calls)
globs:
alwaysApply: false
---

# /deep-search.verify — Connectivity Validation (MANDATORY) ✅

## Inputs
- `.cursor/deep-search/<feature>/ARCHITECTURE-REPORT.draft.md`
- `.cursor/deep-search/<feature>/trace-ledger.md`
- `.cursor/deep-search/<feature>/octocode-queries.md`

## Validate (Hard)
For every A -> B hop claimed in the draft:

### 1) Existence check
- path exists locally OR proven via Octocode snippet.

### 2) Connectivity check (the key)
You MUST prove at least one of:
- A imports B (import/require)
- A calls B (call-site)
- A references a concrete identifier in B (symbol usage)
- For services: A’s request maps to B’s handler (route/rpc binding)

“Similar folder/function name” is NOT proof.

### 3) Cross-repo re-proof (mandatory on boundary)
If a hop crosses repos OR uses non-local symbols:
- rerun **`/octocode/research`** for the exact symbol(s)
- append verification queries to `octocode-queries.md`

### 4) Mermaid check
Every mermaid edge must map to at least one validated hop proof.

---

## 🚨 SDK Generation Chain Validation (MANDATORY)
If the draft mentions ANY SDK (especially `@wix/ambassador-*`, `.../rpc`, `.../types`, `ctx.ambassador.request`):

You MUST verify the chain is connected by code:

1) **Callsite → RPC builder**
- prove import + usage of specific rpc function

2) **RPC builder → IDL**
- prove the rpc function is generated from a specific source IDL (proto/openapi/graphql)
- requires Octocode proof (repo/path + lines + snippet)

3) **IDL → package generation trigger/config**
- prove where the generator/pipeline is configured or triggered
- requires Octocode proof

4) **Runtime transport**
- prove where request execution happens (network boundary)
- prove where auth/baseUrl/retries are configured
- requires Octocode proof

5) **Types**
- prove `.../types` are generated from the same IDL source

If any link cannot be proven:
- mark that claim as broken OR downgrade to NOT FOUND
- include exact searches + scope

---

## Output
Write:
- `.cursor/deep-search/<feature>/VALIDATION-REPORT.md`

Include:
- Broken claims (with corrected pointers OR NOT FOUND)
- Verified edge list (A -> B with evidence pointers)
- Verified SDK chain (if relevant) OR NOT FOUND with queries+scope
- Remaining NOT FOUND (queries + scope)
