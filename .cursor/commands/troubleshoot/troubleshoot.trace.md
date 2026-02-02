---
description: Deep-debug: Build an E2E trace map from evidence (Chrome DevTools/Grafana/BrowserMCP)
globs:
alwaysApply: false
---

# /troubleshoot.trace — Evidence Trace

Goal: produce `.cursor/troubleshoot/<topic>/E2E-TRACE.md`

## Prerequisites

- TROUBLESHOOT-SPEC exists at `.cursor/troubleshoot/<topic>/TROUBLESHOOT-SPEC.md`

---

## Step 1: Gather Runtime Evidence

### For Frontend/UI Bugs

**Use Chrome DevTools (PRIMARY)** — see [Chrome DevTools Mandate](../../rules/troubleshoot/chrome-devtools-mandate.mdc)

| Step | Tool | Purpose |
|------|------|---------|
| 1 | `list_console_messages` | Capture JS errors, warnings |
| 2 | `list_network_requests` | Find failed/slow requests |
| 3 | `get_network_request` | Get headers (x-wix-request-id) |
| 4 | `take_screenshot` | Visual state at failure |
| 5 | `take_snapshot` | DOM structure (if needed) |

**If Chrome DevTools unavailable:** Use BrowserMCP (FALLBACK) — see [BrowserMCP Mandate](../../rules/troubleshoot/browsermcp-mandate.mdc)

### For Backend/API Bugs

**Use Grafana (MCP-S)** — see [MCP-S Mandate](../../rules/troubleshoot/mcp-s-mandate.mdc)

| Step | Tool | Purpose |
|------|------|---------|
| 1 | `find_error_pattern_logs` | Find elevated error patterns |
| 2 | `query_loki_logs` | Detailed log entries |
| 3 | `get_sift_analysis` | AI-powered RCA |
| 4 | `list_incidents` | Check active incidents |

### For Performance Issues

| Area | Tools |
|------|-------|
| Frontend | `performance_start_trace` → reproduce → `performance_stop_trace` |
| Backend | `find_slow_requests` → `query_prometheus` |

---

## Step 2: Request ID Tracing (if network call failed)

When you find a failed network request, extract the `x-wix-request-id` and trace in Grafana.

See [Chrome DevTools Mandate](../../rules/troubleshoot/chrome-devtools-mandate.mdc) for detailed workflow.

**Quick reference:**
1. `list_network_requests` (user-chrome-devtools) → find failed request
2. `get_network_request` (user-chrome-devtools) → extract x-wix-request-id from response headers
3. `list_datasources` (user-MCP-S) → get Loki datasource UID
4. Trace: Open Grafana dashboard OR `query_loki_logs`

**Grafana Dashboard URL:**
```
https://grafana.wixpress.com/d/38cCoLymz/error-analytics-traceid?orgId=1&var-request_id={REQUEST_ID}
```

---

## Step 3: Build E2E System Map

Using evidence + code breadcrumbs, map the flow:

```
Entry → Transport → Validation → Persistence → Consumer/Runtime → Failure Boundary
```

Identify each boundary type:
- Network boundary (API calls)
- Persistence boundary (DB read/write)
- Render boundary (component render)
- Error boundary (thrown error)

---

## Step 4: Identify Resolution Targets

List symbols/methods/services that need cross-repo proof in `/troubleshoot.resolve`:

```markdown
## Next Resolution Targets
1. `@wix/ambassador-*` client — needs Octocode proof
2. `ServiceX.methodY` — needs implementation proof
3. Error handler at boundary — needs code location
```

---

## Outputs

Write `.cursor/troubleshoot/<topic>/E2E-TRACE.md` with:

1. **Runtime Evidence Summary**
   - Console errors found
   - Failed network requests (with request IDs)
   - Log patterns from Grafana
   - Screenshots/snapshots

2. **E2E System Map** (one screen)

3. **Boundary List** (with evidence pointers)

4. **Next Resolution Targets** (feeds `/troubleshoot.resolve`)

Write `.cursor/troubleshoot/<topic>/mcp-s-notes.md` with all MCP queries and findings.

---

## Rules

- Log all tool queries to `mcp-s-notes.md`
- Prefer evidence anchors (trace/log/request IDs)
- Always try Chrome DevTools before BrowserMCP
- Extract `x-wix-request-id` for any failed network request

When complete, say: "Trace complete. Run `/troubleshoot.resolve`."
