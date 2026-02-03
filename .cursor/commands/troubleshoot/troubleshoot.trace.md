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

When you find a failed network request, extract the `x-wix-request-id` and use AI-powered root cause analysis.

See [Chrome DevTools Mandate](../../rules/troubleshoot/chrome-devtools-mandate.mdc) for detailed workflow.

### PRIMARY: AI Root Cause Analysis (MANDATORY)

```
1. list_network_requests (user-chrome-devtools) → find failed request
2. get_network_request (user-chrome-devtools) → extract x-wix-request-id from response headers
3. start_root_cause_analysis (user-MCP-S-root-cause) → start AI analysis with request ID
4. await_root_cause_analysis (user-MCP-S-root-cause) → poll until complete
```

**start_root_cause_analysis arguments:**
```
server: user-MCP-S-root-cause
toolName: start_root_cause_analysis
arguments:
  requestId: "<x-wix-request-id>"           # REQUIRED: from network response headers
  artifactIds: ["<service-name>"]           # OPTIONAL: filter to specific services
  hint: "<context about the issue>"         # OPTIONAL: guide the analysis
  fromDate: "<ISO8601>"                     # OPTIONAL: defaults to 2 min before request
  toDate: "<ISO8601>"                       # OPTIONAL: defaults to 11 min after request
```

**await_root_cause_analysis arguments:**
```
server: user-MCP-S-root-cause
toolName: await_root_cause_analysis
arguments:
  analysisId: "<from start response>"       # REQUIRED: from start_root_cause_analysis
  timeoutSeconds: 25                        # OPTIONAL: defaults to 25s, max 600s
```

**Polling workflow:**
- Call `await_root_cause_analysis` repeatedly until status is `COMPLETED` or `FAILED`
- `RUNNING` status means analysis in progress — call again with same `analysisId`
- `COMPLETED` returns markdown report with root cause findings
- `FAILED` returns reason — proceed to fallback

### FALLBACK: Grafana Logs (ONLY if RCA non-informative)

Use this ONLY when:
- `start_root_cause_analysis` fails to start
- `await_root_cause_analysis` returns `FAILED`
- Analysis completes but findings are not actionable (e.g., "no issues found" but error clearly exists)

**Fallback steps:**
1. `list_datasources` (user-MCP-S) → get Loki datasource UID
2. `query_loki_logs` OR open Grafana dashboard

**Grafana Dashboard URL (FALLBACK):**
```
https://grafana.wixpress.com/d/38cCoLymz/error-analytics-traceid?orgId=1&var-request_id={REQUEST_ID}
```

**MUST log in mcp-s-notes.md:**
- RCA tool call with arguments and response
- If using fallback: reason why RCA was insufficient

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
