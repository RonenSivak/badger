---
description: Validate DRAFT report is correct by proving edges are connected (imports/calls) and MCP-S was used
globs:
alwaysApply: false
---

# /deep-search.verify — Connectivity Validation (MANDATORY) ✅

## Inputs
- `.cursor/deep-search/<feature>/ARCHITECTURE-REPORT.draft.md`
- `.cursor/deep-search/<feature>/trace-ledger.md`
- `.cursor/deep-search/<feature>/octocode-queries.md`
- `.cursor/deep-search/<feature>/mcp-s-notes.md`

## Validate (Hard)
For every A -> B hop claimed in the draft:

### 1) Existence check
- path exists locally OR proven via Octocode snippet.

### 2) Connectivity check (the key)
You MUST prove at least one of:
- A imports B (import/require)
- A calls B (call-site)
- A references a concrete identifier in B (symbol usage)
- For services: A's request maps to B's handler (route/rpc binding)

"Similar folder/function name" is NOT proof.

### 3) Cross-repo re-proof (mandatory on boundary)
If a hop crosses repos OR uses non-local symbols:
- rerun **`/octocode/research`** for the exact symbol(s)
- append verification queries to `octocode-queries.md`

### 4) Mermaid check
Every mermaid edge must map to at least one validated hop proof.

---

## 🔎 MCP-S Validation (MANDATORY)

### 5) MCP-S notes file check
Verify `.cursor/deep-search/<feature>/mcp-s-notes.md`:
- **EXISTS**: file must be present
- **NOT EMPTY**: must contain at least one query record
- **COVERAGE**: every major feature/service in the report should have an MCP-S entry

### 6) MCP-S source coverage check
For each major topic in the report, verify at least ONE of:
- Internal docs searched (`docs-schema__search_docs`)
- Slack searched (`slack__search-messages`)
- Jira searched (`jira__get-issues`)
- DevEx searched (when applicable):
  - `code_owners_for_path` — for ownership claims
  - `get_project` — for project metadata
  - `get_build` / `search_builds` — for CI/CD info
  - `where_is_my_commit` — for commit tracking
  - `release_notes` — for release info

If a topic has no MCP-S coverage:
- either add MCP-S queries now
- OR mark as "MCP-S: NOT FOUND" with queries attempted

### 7) DevEx ownership validation (MANDATORY if ownership mentioned)
If the report mentions ownership or "who owns this":
- MUST have `code_owners_for_path` query in mcp-s-notes.md
- If no DevEx ownership query, fail validation

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
- **MCP-S Coverage**: topics covered, sources used, gaps
- **Broken claims** (with corrected pointers OR NOT FOUND)
- **Verified edge list** (A -> B with evidence pointers)
- **Verified SDK chain** (if relevant) OR NOT FOUND with queries+scope
- **Remaining NOT FOUND** (queries + scope for both MCP-S and Octocode)

### Validation Summary Format
```markdown
## Validation Summary
- MCP-S notes file: ✅ exists / ❌ missing
- MCP-S queries logged: N
- Topics with MCP-S coverage: N / M
- DevEx queries logged: N (code_owners, builds, commits, releases)
- Ownership verified via DevEx: ✅ / ❌ / N/A
- Octocode queries logged: N
- Verified edges: N
- Broken claims: N (fixed: N, NOT FOUND: N)
- SDK chain verified: ✅ / ❌ / N/A

## Result: PASS / FAIL
```
