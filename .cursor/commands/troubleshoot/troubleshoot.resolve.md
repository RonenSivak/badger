---
description: Cross-repo proof loop via MCP-S + Octocode to resolve all non-local symbols
globs:
alwaysApply: false
---

# /troubleshoot.resolve — Proof Loop

Goal: Resolve all non-local symbols from E2E-TRACE with code proof.

## Prerequisites

- E2E-TRACE exists at `.cursor/troubleshoot/<topic>/E2E-TRACE.md`

## Outputs

- `.cursor/troubleshoot/<topic>/mcp-s-notes.md` — All MCP queries and findings
- `.cursor/troubleshoot/<topic>/octocode-queries.md` — All Octocode queries
- `.cursor/troubleshoot/<topic>/trace-ledger.md` — Symbol resolution table

---

## Mandatory Loop (unlimited iterations)

For EVERY unresolved / non-local symbol in E2E-TRACE:

### Step 1: Gather Context (MCP-S)

See [MCP-S Mandate](../../rules/troubleshoot/mcp-s-mandate.mdc) for tool details.

| Query | Tool |
|-------|------|
| Who owns this code? | `devex__code_owners_for_path` (MANDATORY) |
| Related tickets? | `jira__get-issues` |
| Team discussions? | `slack__search-messages` |
| Active incidents? | `grafana-mcp__list_incidents` |
| Who to escalate to? | `grafana-mcp__get_current_oncall_users` |

### Step 2: Classification

Record from MCP-S findings:
- **Layer**: sdk / client / service / facade / runtime
- **Type**: generated vs runtime
- **Owner**: team from `code_owners_for_path`
- **Related**: incidents / tickets / discussions

### Step 3: Code Proof (Octocode)

See [Octocode Mandate](../../rules/troubleshoot/octocode-mandate.mdc) for usage.

Run **`/octocode/research`** to fetch:
- Definition (repo/path + lines + snippet)
- Implementation (repo/path + lines + snippet)
- Side-effect boundary (network/persist/render/throw)

### Step 4: Update Trace Ledger

Append to `.cursor/troubleshoot/<topic>/trace-ledger.md`:

| Symbol | Owner | Layer | Def | Impl | Boundary | Evidence | Status |
|--------|-------|-------|-----|------|----------|----------|--------|
| X | @team | SDK | link | link | link | trace #123 | ✅ |

---

## Additional Investigation (when needed)

| Need | Tool | Mandate |
|------|------|---------|
| More backend logs | `grafana-mcp__query_loki_logs` | MCP-S Mandate |
| Backend metrics | `grafana-mcp__query_prometheus` | MCP-S Mandate |
| Dashboard context | `grafana-mcp__search_dashboards` | MCP-S Mandate |
| Reproduce in browser | Chrome DevTools or BrowserMCP | Chrome DevTools / BrowserMCP Mandate |
| Network request details | `list_network_requests` → `get_network_request` | Chrome DevTools Mandate |

---

## Rules

- Generated wrappers do NOT count — find generator source + runtime implementer
- Record every Octocode query in `octocode-queries.md`
- Record every MCP-S query in `mcp-s-notes.md`
- Add every symbol to `trace-ledger.md` with proof pointers
- Use `code_owners_for_path` for EVERY affected file

---

## Stop Conditions

All symbols resolved, OR marked NOT FOUND with:
- Exact Octocode searches + scope attempted
- Exact MCP-S tool queries attempted
- Chrome DevTools / BrowserMCP / Grafana queries tried

When complete, say: "Resolution complete. Run `/troubleshoot.hypothesize`."
