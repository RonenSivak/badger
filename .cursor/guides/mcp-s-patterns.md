# MCP-S Patterns

Internal knowledge gathering patterns for docs, Slack, Jira, DevEx, and observability.

> **IMPORTANT**: MCP-S is part of the **4 Mandatory Sources** for internal knowledge.
> See [internal-knowledge-search.md](internal-knowledge-search.md) for complete search protocol.

## The 4 Mandatory Sources (Search ALL)

When searching for internal Wix knowledge, **ALWAYS search ALL 4**:

| # | Source | Tool | What It Provides |
|---|--------|------|------------------|
| 1 | **Slack** | `slack__search-messages` | Decisions, discussions, debugging threads |
| 2 | **Jira** | `jira__get-issues` | Requirements, acceptance criteria, bugs |
| 3 | **Internal Docs** | `docs-schema__search_docs` | Architecture, design docs, ownership |
| 4 | **wix-private/* repos** | Octocode | Implementation, SDK sources, generated code |

Plus **DevEx** for ownership/CI/CD and **Observability** for debugging.

## Purpose

MCP-S provides access to **internal knowledge sources** that code alone cannot reveal:

| Source | What It Provides |
|--------|-----------------|
| **Internal Docs** | Architecture specs, design docs, ownership |
| **Slack** | Team discussions, decisions, debugging threads |
| **Jira** | Requirements, acceptance criteria, bug reports |
| **DevEx** | Code ownership, CI/CD, commits, releases, rollouts |
| **Observability** | Root cause analysis, Grafana logs/metrics/incidents |

## When MCP-S is REQUIRED

Run MCP-S tools when:

- New service/package/SDK encountered (docs for architecture)
- Unclear ownership or team responsibility (DevEx code owners)
- Feature purpose unclear from code alone (Jira for requirements)
- Debugging a bug/perf/deployment issue (observability + Jira/Slack + DevEx)
- Generated code encountered (docs for generation pipeline)
- "Why was this built this way?" questions (Slack/docs)
- Need CI/build status or rollout history (DevEx)

## Core Tools

### Internal Docs
```
Tool: docs-schema__search_docs
Use when: Architecture/design/ownership context needed
```

### Slack Search
```
Tool: slack__search-messages
Use when: Decisions/discussions/debugging threads needed
Arguments:
  searchText: "<feature> <keywords>"
  after: "YYYY-MM-DD"  # last 30-60 days
```

### Jira Issues
```
Tool: jira__get-issues
Use when: Requirements/acceptance criteria/bug context needed
```

### DevEx Tools

| Tool | Purpose |
|------|---------|
| `code_owners_for_path` | Who owns the code |
| `get_project` / `search_projects` | Project metadata |
| `get_build` / `search_builds` | CI/CD status |
| `get_commit_information` | Commit details |
| `where_is_my_commit` | Is commit deployed? |
| `release_notes` / `available_rcs` | What changed |
| `get_rollout_history` | Deployment timeline |
| `get_devex_fqdn` | Service endpoints |

## Observability Tools (for debugging)

### Root Cause Analysis (Primary)
If you have `x-wix-request-id`:
```
Tool: start_root_cause_analysis
→ Then poll: await_root_cause_analysis
```

### Grafana (Fallback)
Use when RCA is non-informative:
- `query_loki_logs` - Log search
- `find_error_pattern_logs` - Error patterns
- `find_slow_requests` - Performance issues
- `list_incidents` - Active incidents
- `query_prometheus` - Metrics

## What MCP-S Must Contribute

For each researched topic, record:
- **Source type**: docs | Slack | Jira | DevEx | Observability
- **Query used**: exact search terms or arguments
- **Key findings**: ownership/decisions/requirements/status/links

## Logging Requirement

Append MCP-S queries + findings to the workflow's evidence artifact:
- deep-searching: `.cursor/deep-search/<feature>/mcp-s-notes.md`
- troubleshooting: `.cursor/troubleshoot/<topic>/mcp-s-notes.md`

## Expand Search Protocol (Before Marking NOT FOUND)

**If any source returns no results, DON'T mark NOT FOUND yet.** Try:

| Source | Expansion Strategies |
|--------|---------------------|
| **Slack** | Try synonyms, older date ranges (90+ days), different channels, team names |
| **Jira** | Try different projects, linked issues, component names, labels |
| **Docs** | Try broader terms, related product names, team names |
| **wix-private** | Try Octocode with different repos, package names, interface names |

**Take your time.** Try 3-5 different query variations per source before giving up.

## If MCP-S is Unavailable

If MCP-S tools are unavailable or yield no results after expansion:
- Mark as **MCP-S: NOT FOUND**
- List ALL queries attempted (per source)
- List ALL expansion strategies tried
- Suggest next steps (ask user, escalate, check wix-private via Octocode)

## Debug Intent Flow

For debugging (something doesn't work):

1. **Search Slack FIRST** for prior discussions
2. **Check DevEx** - is the project tracked?
3. **If DevEx applies** → verify deployment state
4. **If DevEx doesn't apply** → ask user for confirmation
5. **THEN** analyze code

> **Rule**: Slack provides *context*, DevEx provides *deployment truth*, code provides *proof*.
