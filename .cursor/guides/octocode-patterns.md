# Octocode Patterns

Cross-repo resolution patterns for non-local symbols.

> **IMPORTANT**: Octocode (wix-private/* repos) is one of the **4 Mandatory Sources** for internal knowledge.
> When searching for internal Wix knowledge, ALWAYS search: Slack + Jira + Docs + **wix-private/***.
> See [internal-knowledge-search.md](internal-knowledge-search.md) for complete search protocol.

## When Octocode is REQUIRED

Run Octocode as soon as any of these triggers appear:

- **Non-local symbol**: imported from a package/repo not in current workspace
- **Not provable locally**: can't show implementation within 2 local hops
- **Generated artifacts**: `proto-generated`, `dist`, `*.pb.ts`, generated clients
- **Service facades/SDK boundaries**:
  - `documentServices.*`, `viewerServices.*`, `platformServices.*`
  - `@wix/ambassador-*`
  - imports from `.../rpc` or `.../types`
  - `ctx.ambassador.request(...)`
- **SDK generation signals**:
  - "metro", "package generation", "fqdn", `(.wix.api.entity)`, "platformization"
- **Testkit/driver reuse**:
  - WDS testkit factories/classes
  - Shared BaseDriver helpers

## What Octocode Must Return (Minimum)

For each required symbol, get:

| Element | Required | Example |
|---------|----------|---------|
| **Definition** | repo/path + lines + snippet | Where the type/interface is declared |
| **Implementation** | repo/path + lines + snippet | Where the logic lives |
| **Boundary** | side-effect snippet | network/persist/render/throw |

## SDK Generation Chain

If `@wix/ambassador-*` or equivalent generated SDK appears, also resolve:

1. **Source IDL** (proto/openapi/graphql)
2. **Generator trigger/config** ("package generation")
3. **Runtime transport** (auth/baseUrl/retries + request execution)
4. **Types package proof** (generated from same IDL)

## Logging Requirement

Append all Octocode queries + proof snippets to the workflow's evidence artifact:

- deep-searching: `.cursor/deep-search/<feature>/octocode-queries.md`
- testing: `MCP-EVIDENCE.md`
- troubleshooting: `.cursor/troubleshoot/<topic>/octocode-queries.md`

## If Octocode is Unavailable

If Octocode is not available or fails:
- Downgrade claims to **NOT FOUND**
- List the exact intended queries + scope that would have been searched

## Query Patterns

### Find Definition
```
"Where is <symbol> defined?"
→ Should return: repo, file path, line numbers, snippet
```

### Find Implementation
```
"How is <symbol> implemented?"
→ Should return: repo, file path, implementation snippet
```

### Find Boundary
```
"What side-effects does <symbol> have?"
→ Should return: network calls, persistence, rendering, error throwing
```

### SDK Chain
```
"What IDL generates <package>?"
"How is the transport configured?"
"Where are the types generated from?"
```
