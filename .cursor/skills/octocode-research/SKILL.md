# Octocode Research Skill 🛰️

## Purpose
Use **`/octocode/research`** as the authoritative cross-repo resolver for any non-local symbol.
Record proof as: **repo/path + line range + snippet**, plus boundary evidence.

## Always log results
Append to:
- `.cursor/deep-search/<feature>/octocode-queries.md`

Each entry:
- Symbol
- Query
- Top hits + snippets
- What it proves (def/impl/boundary)

## Query patterns (recommended)

### Generic symbol resolution
- `symbol:<Name> definition`
- `file:<filename> <unique_string>`
- `<functionName>(` and then pivot to definition
- `<error_code>` or `<endpoint_path>`

### Runtime boundary hunting
- `fetch(` / `axios.` / `grpc` / `request(` / `db.` / `insert` / `update` / `render` / `throw new`

### SDK / Ambassador / Metro chain (MANDATORY when detected)
When you see:
- `@wix/ambassador-*`
- imports from `.../rpc` or `.../types`
- `ctx.ambassador.request(...)`

You MUST find:
1) callsite usage (import + call)
2) generated package exports (`/rpc`, `/types`)
3) source IDL (proto/openapi/graphql)
4) generator trigger/config (“package generation”)
5) runtime transport execution (network boundary + auth/baseUrl/retries)
6) proof that types are generated from the same IDL

Suggested queries:
- `"from \"@wix/ambassador-"` + `/rpc`
- `"ctx.ambassador.request"` + `request` implementation
- `"option (.wix.api.entity)"` or `"fqdn:"`
- `"metro-package-generation"` or `"TriggerPackageGeneration"`

## Success criteria
A symbol is “resolved” only when you have:
- Definition snippet
- Implementation snippet
- Boundary snippet
All recorded with repo/path + line ranges.
