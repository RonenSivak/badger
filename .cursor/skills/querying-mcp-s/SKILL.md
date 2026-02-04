---
name: querying-mcp-s
description: "Use MCP-S internal knowledge tools (docs, Slack, Jira, DevEx) to answer questions code cannot, then verify claims via code/Octocode. Use when ownership, intent, requirements, or generated pipelines are unclear."
---

# Querying MCP-S

This skill is intentionally minimal. Critical rules are **passive context**:
- `@.cursor/rules/shared/mcp-s-mandate.mdc`
- `@.cursor/rules/shared/proof-discipline.mdc`

## 4 Mandatory Sources (ALWAYS Search ALL)

When searching for internal knowledge, **ALWAYS search ALL 4**:

| Source | Tool |
|--------|------|
| Slack | `slack__search-messages` |
| Jira | `jira__get-issues` |
| Docs | `docs-schema__search_docs` |
| wix-private/* | Octocode |

**Do NOT skip any source.** If not found → expand search before marking NOT FOUND.

See [internal-knowledge-search.md](../../guides/internal-knowledge-search.md) for complete protocol.

## Usage

Use MCP-S to gather **internal context**, then treat it as **hints** and prove code edges separately (Octocode when non-local).

Log queries + findings to the kit's evidence artifact (kit-specific).
