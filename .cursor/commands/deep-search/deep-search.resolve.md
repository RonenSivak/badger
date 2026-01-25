---
description: Resolve non-local symbols via MCP-S + /octocode/research (unlimited)
globs:
alwaysApply: false
---

# /deep-search.resolve — Cross-Repo Proof Loop 🌍🛰️

## Hard Rules
- **MCP-S** is for: internal knowledge (docs, Slack, Jira, DevEx) + classification + ownership.
- **Octocode** is for: authoritative cross-repo code proof via **`/octocode/research`**.
- Any non-local symbol MUST be resolved to:
  (1) definition, (2) implementation, (3) side-effect boundary snippet.
- Any feature/service MUST have MCP-S context (docs/Slack/Jira/DevEx search).

> Don't stop early. Unlimited iteration is REQUIRED.

---

## MCP-S Escalation Triggers (MANDATORY)
Use **MCP-S tools** (`user-MCP-S` server) when:
- new service/package/SDK encountered (search docs for architecture)
- ownership or team responsibility unclear (search docs/Slack + **DevEx code_owners**)
- feature purpose unclear from code alone (search Jira for requirements)
- debugging a bug (search Jira for related tickets, Slack for discussions)
- generated code encountered (search docs for generation pipeline)
- "why was this built this way?" questions (search Slack/docs for decisions)
- **need to know who owns code** (DevEx `code_owners_for_path`)
- **need build/CI status** (DevEx `get_build`, `search_builds`)
- **need commit tracking** (DevEx `where_is_my_commit`, `get_commit_information`)
- **need release/deployment info** (DevEx `release_notes`, `get_rollout_history`)
- **need service endpoint** (DevEx `get_devex_fqdn`)

### MCP-S Tools Quick Reference
| Tool | Use When |
|------|----------|
| `docs-schema__search_docs` | Architecture, design specs, ownership |
| `slack__search-messages` | Team discussions, decisions, context |
| `jira__get-issues` | Requirements, tickets, acceptance criteria |
| `code_owners_for_path` | **Who owns this code** |
| `get_project` / `search_projects` | Project metadata |
| `get_build` / `search_builds` | CI/CD build status |
| `get_commit_information` | Commit details |
| `where_is_my_commit` | Commit deployment status |
| `release_notes` | What changed in a release |
| `get_rollout_history` | Deployment history |
| `get_devex_fqdn` | Service endpoint discovery |
| `fleets_pods_overview` | Infrastructure status |
| `project_quality_service_get_scores` | Quality metrics |

---

## Octocode Escalation Triggers (MANDATORY)
Use **`/octocode/research` immediately** when:
- import is from external package not in local workspace (`@wix/*`, SDKs, generated clients)
- you hit a facade (`documentServices.*`, `viewerServices.*`, `platformServices.*`)
- you can't show implementation within 2 hops locally
- you hit generated outputs (`proto-generated`, `dist`, `*.pb.ts`)
- **SDK signals:** `@wix/ambassador-*`, `ctx.ambassador.request`, imports from `.../rpc` or `.../types`
- **Metro signals:** "metro", "package generation", "fqdn", `(.wix.api.entity)`, "platformization"

---

## Procedure (repeat until done)
For EACH newly encountered abstraction/symbol/call boundary:

### A) Gather Internal Knowledge (MCP-S) — FIRST
Search internal sources for context before diving into code:

**1) Search Internal Docs**
```
server: user-MCP-S
toolName: docs-schema__search_docs
arguments:
  query: "<feature/service name>"
  limit: 10
```

**2) Search Slack**
```
server: user-MCP-S
toolName: slack__search-messages
arguments:
  searchText: "<feature/service name>"
  in: "#relevant-channel"  # optional
```

**3) Search Jira**
```
server: user-MCP-S
toolName: jira__get-issues
arguments:
  projectKey: "PROJECT"
  jql: "text ~ '<feature name>'"
  maxResults: 10
```

**4) DevEx: Code Ownership (MANDATORY for ownership questions)**
```
server: user-MCP-S
toolName: code_owners_for_path
arguments:
  path: "<file or directory path>"
```

**5) DevEx: Project Info**
```
server: user-MCP-S
toolName: get_project
arguments:
  projectName: "<project name>"
```

**6) DevEx: Build Status (when debugging CI/CD)**
```
server: user-MCP-S
toolName: search_builds
arguments:
  projectName: "<project>"
```

**7) DevEx: Commit Tracking (when tracing changes)**
```
server: user-MCP-S
toolName: where_is_my_commit
arguments:
  commitSha: "<sha>"
```

**8) DevEx: Release Info**
```
server: user-MCP-S
toolName: release_notes
arguments:
  projectName: "<project>"
  version: "<version>"
```

**9) DevEx: Service FQDN (for endpoint discovery)**
```
server: user-MCP-S
toolName: get_devex_fqdn
arguments:
  serviceName: "<service>"
```

Record findings in:
`.cursor/deep-search/<feature>/mcp-s-notes.md`

Format:
```markdown
## [Topic/Symbol]
- **Source**: docs | Slack | Jira | DevEx
- **Tool**: <tool name>
- **Query**: <exact query/arguments>
- **Findings**: <key insights>
- **Links**: <URLs if available>
- **Follow-up**: <what to verify via code>
```

### B) Classify (from MCP-S findings)
Record:
- layer (UI/BFF/service/SDK/runtime)
- generated vs runtime
- owner/team/domain (from DevEx `code_owners_for_path`)
- doc/spec links (hints only)

### C) Resolve Code Proof (Octocode)
Run **`/octocode/research`** to fetch:
- definition (repo/path + lines + snippet)
- implementation (repo/path + lines + snippet)
- side-effect boundary snippet (network/persist/render/throw)

Write queries + results into:
`.cursor/deep-search/<feature>/octocode-queries.md`

### D) Update Trace Ledger
Append to:
`.cursor/deep-search/<feature>/trace-ledger.md`
with:
Symbol | MCP-S context | Owner (DevEx) | Def | Impl | Boundary | Status

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

### 4) Generation trigger/config ("package generation")
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
- mcp-s-notes (context from docs/Slack/Jira/DevEx about the SDK)

---

## NOT FOUND Rule
If unresolved after exhaustive attempts:
- mark NOT FOUND
- list exact queries attempted:
  - MCP-S: docs query, Slack query, Jira query
  - DevEx: code_owners query, project query, build query
  - Octocode: search queries
- list closest candidate files
- state scope searched (repos/packages/docs/channels/DevEx)
