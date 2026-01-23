---
description: Resolve non-local symbols via MCP-S + /octocode/research (unlimited)
globs:
alwaysApply: false
---

# /deep-search.resolve — Cross-Repo Proof Loop

## Hard Rules
- MCP-S is for: classification + internal docs/ownership hints.
- Octocode is for: authoritative cross-repo code proof.
- Any non-local symbol MUST be resolved to:
  (1) definition, (2) implementation, (3) side-effect boundary snippet.

## Octocode Escalation Triggers (MANDATORY)
Use `/octocode/research` immediately when:
- import is from external package not in local workspace (`@wix/*`, SDKs, generated clients)
- you hit a facade (`documentServices.*`, `viewerServices.*`, `platformServices.*`)
- you can’t show implementation within 2 hops locally
- you hit generated outputs (`proto-generated`, `dist`, `*.pb.ts`)

## Procedure (repeat until done)
For EACH newly encountered abstraction/symbol/call boundary:

### A) Classify (MCP-S)
Call `user-mcp-s-mcp` and record:
- layer (UI/BFF/service/SDK/runtime)
- generated vs runtime
- owner/team/domain
- doc/spec links (hints only)

Write results into:
`.cursor/deep-search/<feature>/mcp-s-notes.md`

### B) Resolve (Octocode)
Run `/octocode/research` to fetch:
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

## NOT FOUND Rule
If unresolved after exhaustive attempts:
- mark NOT FOUND
- list exact queries attempted (MCP-S + Octocode)
- list closest candidate files
- state scope searched (repos/packages)
