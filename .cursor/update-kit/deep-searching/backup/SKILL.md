---
name: deep-searching
description: "E2E architecture forensics with cross-repo resolution. Use when you need to understand how a feature works end-to-end, trace data flows, find all connected code, or debug production issues."
---

# Deep Searching

Produce a provable, cross-repo E2E architecture report with mandatory validation before publish.

## Quick Start
1. Clarify the search spec (use clickable options below)
2. Plan the resolution approach
3. Execute deep research with MCP-S + Octocode
4. Draft the report (file-only)
5. Verify all connections
6. Publish final report

## Clarify (ALWAYS use AskQuestion tool)
Start by asking with clickable options:
```
AskQuestion:
  title: "Deep Search Setup"
  questions:
    - id: "intent"
      prompt: "What's your goal?"
      options:
        - { id: "understand", label: "Understand how it works E2E" }
        - { id: "debug", label: "Debug an issue" }
        - { id: "clone", label: "Clone/add similar feature" }
    - id: "scope"
      prompt: "What's the scope?"
      options:
        - { id: "single_repo", label: "Single repository" }
        - { id: "cross_repo", label: "Cross-repo (uses external packages)" }
        - { id: "sdk", label: "Involves SDKs (@wix/ambassador-*, etc.)" }
    - id: "boundaries"
      prompt: "Which boundaries matter? (select all that apply)"
      allow_multiple: true
      options:
        - { id: "network", label: "Network calls (API, fetch, RPC)" }
        - { id: "persistence", label: "Database/storage" }
        - { id: "render", label: "UI rendering" }
        - { id: "errors", label: "Error handling/throwing" }
```
Then gather breadcrumbs (file paths, symbols, URLs, error strings).

## Workflow Checklist
Copy and track your progress:
```
- [ ] Search spec defined (feature, intent, breadcrumbs, boundaries)
- [ ] Plan written (.cursor/plans/deep-search.<feature>.md)
- [ ] MCP-S context gathered (docs, Slack, Jira, DevEx)
- [ ] Octocode proofs collected (def + impl + boundary)
- [ ] Draft report written (ARCHITECTURE-REPORT.draft.md)
- [ ] Verification passed (VALIDATION-REPORT.md)
- [ ] Final report published (ARCHITECTURE-REPORT.md)
```

## Intent Types

| Intent | Focus |
|--------|-------|
| **E2E understand** | Full data flow, all hops |
| **Debug** | Slack/DevEx first, then code proof |
| **Clone/add** | Pattern extraction + change surface |

## Debug Intent (CRITICAL)
If debugging, search Slack FIRST, then verify with DevEx:
1. `slack__search-messages` for prior discussions
2. `search_projects` / `get_project` to check DevEx availability
3. `get_rollout_history` / `where_is_my_commit` for deployment state
4. If DevEx unavailable → use AskQuestion for user confirmation

## 4 Mandatory Sources (ALWAYS Search ALL)

For every major feature/service/SDK, **ALWAYS search ALL 4**:

```
- [ ] Slack: `slack__search-messages` (decisions, discussions, debugging threads)
- [ ] Jira: `jira__get-issues` (requirements, acceptance criteria, bugs)
- [ ] Docs: `docs-schema__search_docs` (architecture, design docs)
- [ ] wix-private/*: Octocode `githubSearchCode` (implementation, SDK sources)
```

**Plus DevEx** for ownership: `code_owners_for_path`, `get_project`, `get_build`, `release_notes`

**Rules:**
- Do NOT skip any source — search all 4 even if you think you found the answer
- If not found → expand search (synonyms, older date ranges) before marking NOT FOUND
- Take time to deeply search — try 3-5 query variations per source
- Cross-reference: Slack mentions Jira ticket? → fetch it. Docs mention repo? → search it.

See [internal-knowledge-search.md](../../guides/internal-knowledge-search.md) for complete protocol.

## SDK Generation Chain
If `@wix/ambassador-*` or generated SDK appears, resolve:
- Source IDL (proto/openapi/graphql)
- Generator trigger/config
- Runtime transport (auth/baseUrl/retries)
- Types package proof

## Artifacts
All outputs go to `.cursor/deep-search/<feature>/`:
- `SEARCH-SPEC.md` - Clarified requirements
- `trace-ledger.md` - Evidence trail
- `octocode-queries.md` - Cross-repo proofs
- `mcp-s-notes.md` - Internal knowledge (MANDATORY)
- `ARCHITECTURE-REPORT.md` - Final report

## Verification Gates
Before publish, verify:
- Edges connect by imports/calls/bindings (not naming similarity)
- Every flow arrow has snippet-backed proof (or NOT FOUND)
- SDK generation chain is connected end-to-end

## Hard-fail Conditions
- Publishing without passing verification
- **Skipping any of the 4 mandatory sources** (Slack, Jira, Docs, wix-private/*)
- Empty `octocode-queries.md` when cross-repo symbols exist
- Empty `mcp-s-notes.md`
- Stating root cause without MCP-S verification (debug intent)
- Presenting hypothesis as conclusion without proof
- Marking NOT FOUND without trying 3+ query variations per source

## Detailed Guidance
- See [clarify-patterns.md](../../guides/clarify-patterns.md) for clarification
- See [resolve-workflow.md](../../guides/resolve-workflow.md) for resolution
- See [verify-checklist.md](../../guides/verify-checklist.md) for verification
- See [octocode-patterns.md](../../guides/octocode-patterns.md) for cross-repo resolution
- See [mcp-s-patterns.md](../../guides/mcp-s-patterns.md) for internal knowledge
