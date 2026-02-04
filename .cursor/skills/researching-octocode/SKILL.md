---
name: researching-octocode
description: "Resolve non-local symbols with authoritative cross-repo proof: definition, implementation, and boundary evidence, recorded with repo/path + line ranges. Use whenever a symbol cannot be proven locally."
---

# Researching Octocode

This skill is intentionally minimal. Critical Octocode rules are **passive context**:
- `@.cursor/rules/shared/octocode-mandate.mdc`
- `@.cursor/rules/shared/proof-discipline.mdc`

## wix-private/* as Knowledge Source

Octocode (wix-private/* repos) is one of the **4 Mandatory Sources** for internal knowledge:

| Source | Tool |
|--------|------|
| Slack | `slack__search-messages` |
| Jira | `jira__get-issues` |
| Docs | `docs-schema__search_docs` |
| **wix-private/*** | **Octocode** |

When searching for internal knowledge, **search ALL 4 sources** — not just Octocode.

See [internal-knowledge-search.md](../../guides/internal-knowledge-search.md) for complete protocol.

## Usage

Use Octocode to resolve any non-local symbol with:
- **definition + implementation + boundary** (repo/path + line range + snippet)

Log results to the kit's evidence artifact (kit-specific; see shared mandate for examples).
