---
description: Resolve non-local symbols via MCP-S + /octocode/research (unlimited)
globs:
alwaysApply: false
---

# /deep-search.resolve — Cross-Repo Proof Loop 🌍🛰️

## Hard Rules
- MCP-S is for: classification + internal docs/ownership hints.
- Octocode is for: authoritative cross-repo code proof via **`/octocode/research`**.
- Any non-local symbol MUST be resolved to:
  (1) definition, (2) implementation, (3) side-effect boundary snippet.

> Don’t stop early. Unlimited iteration is REQUIRED.

---

## Octocode Escalation Triggers (MANDATORY)
Use **`/octocode/research` immediately** when:
- import is from external package not in local workspace (`@wix/*`, SDKs, generated clients)
- you hit a facade (`documentServices.*`, `viewerServices.*`, `platformServices.*`)
- you can’t show implementation within 2 hops locally
- you hit generated outputs (`proto-generated`, `dist`, `*.pb.ts`)
- **SDK signals:** `@wix/ambassador-*`, `ctx.ambassador.request`, imports from `.../rpc` or `.../types`
- **Metro signals:** “metro”, “package generation”, “fqdn”, `(.wix.api.entity)`, “platformization”

---

## Procedure (repeat until done)
For EACH newly encountered abstraction/symbol/call boundary:

### A) Classify (MCP-S)
Call `user-mcp-s-mcp` and record:
- layer (UI/BFF/service/SDK/runtime)
- generated vs runtime
- owner/team/domain
- doc/spec links (hints only)

Write into:
`.cursor/deep-search/<feature>/mcp-s-notes.md`

### B) Resolve (Octocode)
Run **`/octocode/research`** to fetch:
- definition (repo/path + lines + snippet)
- implementation (repo/path + lines + snippet)
- side-effect boundary snippet (network/persist/render/throw)

Write queries + results into:
`.cursor/deep-search/<feature>/octocode-queries.md`

### C) Update Trace Ledger
Append to:
`.cursor/deep-search/<feature>/trace-ledger.md`
with:
Symbol | MCP-S classification | Def | Impl | Boundary | Status

---

## 🚨 Generated SDK Chain Rule (MANDATORY)
If you mention ANY SDK/client package (especially `@wix/ambassador-*`), you MUST resolve the full chain:

### 1) Usage (local)
- Where it is imported and called (repo/path + lines + snippet)

### 2) Generated package artifacts
- Where `/rpc` builders and `/types` are exported from (repo/path + lines + snippet)

### 3) Generator source (IDL)
- The actual `.proto/openapi/graphql` that generated it
- For Ambassador/Metro V2, prove the proto contains the entity fqdn-style linkage (e.g. `(.wix.api.entity).fqdn` or equivalent convention)
- Provide repo/path + lines + snippet

### 4) Generation trigger/config (“package generation”)
- Prove where generation is configured or triggered (scripts/config/pipeline/service)
- Provide repo/path + lines + snippet

### 5) Runtime transport boundary (real execution)
- Prove where `ctx.ambassador.request(...)` (or equivalent) executes network calls
- Prove where auth/baseUrl/retries are configured (snippets)
- Provide repo/path + lines + snippet for each

### 6) Types proof
- Prove `.../types` is generated from the same IDL source (not hand-written)
- Provide repo/path + lines + snippet

All 6 must be recorded in:
- trace-ledger (symbols)
- octocode-queries (queries + excerpts)

---

## NOT FOUND Rule
If unresolved after exhaustive attempts:
- mark NOT FOUND
- list exact queries attempted (MCP-S + Octocode)
- list closest candidate files
- state scope searched (repos/packages)
