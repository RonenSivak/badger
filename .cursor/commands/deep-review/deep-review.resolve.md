---
description: Resolve uncertainties (MCP-S classify + Octocode cross-repo proof), build Trace Ledger
globs:
alwaysApply: false
---

# /deep-review.resolve — Proof Loop (UNLIMITED)

Goal:
- No uncertain symbol crosses a boundary without proof.

For EACH uncertain / non-local symbol found in scan or during review:
1) MCP-S (MANDATORY):
   - classify: layer (UI/BFF/service/sdk/runtime), owner/domain, generated vs runtime
   - pull internal docs/spec hints (then prove in code)

2) Octocode (MANDATORY):
   - run `/octocode/research` until you have:
     - definition (repo/path + lines + snippet)
     - implementation (repo/path + lines + snippet)
     - side-effect boundary snippet (network/persistence/render/throw)

3) Record everything:
- `.cursor/deep-review/<target>/mcp-s-notes.md`
- `.cursor/deep-review/<target>/octocode-queries.md`

Maintain Trace Ledger (MANDATORY):
Write: `.cursor/deep-review/<target>/trace-ledger.md`

Ledger table:
| Symbol | MCP-S classification | Def (Octocode) | Impl (Octocode) | Boundary snippet | Status |
|---|---|---|---|---|---|
| ... | ... | repo/path:Lx-Ly | repo/path:Lx-Ly | ... | RESOLVED / NOT FOUND |

NOT FOUND rule (allowed only after real attempts):
- mark NOT FOUND
- list exact MCP-S + Octocode queries attempted
- list scope searched (repos/packages)
- list closest candidates
