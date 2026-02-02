---
description: Deep-debug: Build an E2E trace map from evidence (trace/logs/devtools/grafana) with BrowserMCP fallback
globs:
alwaysApply: false
---

# /troubleshoot.trace — Evidence Trace 🌐

Goal: produce `.cursor/troubleshoot/<topic>/E2E-TRACE.md`

---

## 🔴 STEP 1: Gather Runtime Evidence (Chrome DevTools FIRST, BrowserMCP FALLBACK)

Before tracing code, gather runtime evidence using available tools.

### For Frontend/UI Bugs — Chrome DevTools FIRST, BrowserMCP as FALLBACK

**PRIORITY ORDER:**
1. **TRY Chrome DevTools FIRST** — Full capabilities (network, performance, JS eval)
2. **FALLBACK to BrowserMCP** — Only if Chrome DevTools unavailable/fails

#### PRIMARY: Chrome DevTools (TRY FIRST)

**1) Console Errors (MANDATORY)**
```
server: user-MCP-S
toolName: chrome-devtools__list-console-messages
arguments: {}
```
→ Captures JS errors, warnings, failed assertions

**2) Network Requests (MANDATORY)**
```
server: user-MCP-S
toolName: chrome-devtools__list-network-requests
arguments: {}
```
→ Captures failed requests, slow requests, CORS issues

**2b) Get Specific Request Details (for request ID)**
```
server: user-MCP-S
toolName: chrome-devtools__get-network-request
arguments:
  url: "<failed or suspicious request URL>"
```
→ Returns headers including `x-wix-request-id` for Grafana tracing

**3) Screenshot (MANDATORY)**
```
server: user-MCP-S
toolName: chrome-devtools__take-screenshot
arguments: {}
```
→ Visual state at failure point

**4) DOM Snapshot (if UI state matters)**
```
server: user-MCP-S
toolName: chrome-devtools__take-snapshot
arguments: {}
```

**5) Evaluate JS State (if inspecting variables)**
```
server: user-MCP-S
toolName: chrome-devtools__evaluate-script
arguments:
  expression: "window.__DEBUG_STATE__"  # or relevant expression
```

#### FALLBACK: BrowserMCP (Use ONLY if Chrome DevTools unavailable)

**When to use BrowserMCP:**
- Chrome DevTools MCP tools return errors
- Chrome DevTools MCP is not connected
- Browser tab is not accessible via DevTools

**1) Navigate to Bug Location (if needed)**
```
server: user-browsermcp
toolName: browser_navigate
arguments:
  url: "<URL where bug occurs>"
```

**2) DOM/Accessibility Snapshot (MANDATORY)**
```
server: user-browsermcp
toolName: browser_snapshot
arguments: {}
```
→ Returns DOM tree with element refs (uid) for interaction
→ Use refs in subsequent click/type/hover calls

**3) Console Logs (MANDATORY)**
```
server: user-browsermcp
toolName: browser_get_console_logs
arguments: {}
```
→ Captures JS console output (logs, errors, warnings)

**4) Screenshot (MANDATORY)**
```
server: user-browsermcp
toolName: browser_screenshot
arguments: {}
```
→ Visual capture of current state

**5) Reproduce Bug via Interaction**
```
# Get snapshot first to find element refs
server: user-browsermcp
toolName: browser_snapshot
arguments: {}

# Click element by ref (from snapshot)
server: user-browsermcp
toolName: browser_click
arguments:
  ref: "<uid from snapshot>"
  element: "Button that triggers bug"

# Check console after interaction
server: user-browsermcp
toolName: browser_get_console_logs
arguments: {}
```

#### Tool Selection Logic

```
TRY Chrome DevTools FIRST
│
├─ SUCCESS → Continue with Chrome DevTools
│  - Network requests: ✅ ONLY in Chrome DevTools
│  - Performance: ✅ ONLY in Chrome DevTools
│  - Console: ✅ list-console-messages
│  - DOM: ✅ take-snapshot
│  - Screenshot: ✅ take-screenshot
│  - Evaluate JS: ✅ evaluate-script
│
└─ FAILED/UNAVAILABLE → FALLBACK to BrowserMCP
   - Console: ✅ browser_get_console_logs
   - DOM: ✅ browser_snapshot (with refs)
   - Screenshot: ✅ browser_screenshot
   - Network: ❌ NOT AVAILABLE
   - Performance: ❌ NOT AVAILABLE
   - Evaluate JS: ❌ NOT AVAILABLE
```

**Rule:** Always try Chrome DevTools first. Only fallback to BrowserMCP if Chrome DevTools is unavailable.

---

### For Backend/API Bugs — Grafana

**1) Error Pattern Search (MANDATORY)**
```
server: user-MCP-S
toolName: grafana__find_error_pattern_logs
arguments:
  service: "<service-name>"
  timeRange: "1h"  # or relevant range
```
→ Finds recurring error patterns

**2) Log Query (MANDATORY)**
```
server: user-MCP-S
toolName: grafana__query_loki_logs
arguments:
  query: '{service="<service>"} |= "<error text or trace ID>"'
  limit: 100
```
→ Detailed log entries

**3) Automated RCA (HIGHLY RECOMMENDED)**
```
server: user-MCP-S
toolName: grafana__get_sift_analysis
arguments:
  service: "<service>"
  timeRange: "1h"
```
→ AI-powered root cause analysis

**4) Check Incidents**
```
server: user-MCP-S
toolName: grafana__list_incidents
arguments:
  status: "active"  # or "resolved"
```

---

### For Performance Issues

**Frontend Performance:**
```
server: user-MCP-S
toolName: chrome-devtools__performance-start-trace
arguments: {}
# ... reproduce the slow action ...
toolName: chrome-devtools__performance-stop-trace
arguments: {}
toolName: chrome-devtools__performance-analyze-insight
arguments: {}
```

**Backend Performance:**
```
server: user-MCP-S
toolName: grafana__find_slow_requests
arguments:
  service: "<service>"
  threshold: "500ms"
```

```
server: user-MCP-S
toolName: grafana__query_prometheus
arguments:
  query: 'histogram_quantile(0.99, rate(http_request_duration_seconds_bucket{service="<service>"}[5m]))'
```

---

## 🔗 Request ID Tracing (Frontend → Backend Correlation)

When you find a failed/suspicious network request, extract the `x-wix-request-id` from response headers and trace it in Grafana.

### Workflow:
```
1. chrome-devtools__list-network-requests → find failed request
2. chrome-devtools__get-network-request → get details + headers
3. Extract: x-wix-request-id from response headers
4. Trace in Grafana:
   - Dashboard: https://grafana.wixpress.com/d/38cCoLymz/error-analytics-traceid
     ?orgId=1&var-request_id={req_id}&from={time}&to={time}
   - Or: grafana__query_loki_logs with query: '{service="*"} |= "{req_id}"'
```

### Record in mcp-s-notes.md:
```markdown
## Request ID Trace
- **Request URL**: <URL that failed>
- **x-wix-request-id**: <extracted ID>
- **Grafana Dashboard**: <link with request ID>
- **Backend Logs Found**: <yes/no>
- **Error Pattern**: <what backend shows>
```

---

## 🟡 STEP 2: Build E2E System Map

Using evidence + code breadcrumbs, map:

```
Entry → Transport → Validation → Persistence → Consumer/Runtime → Failure Boundary
```

---

## 🟢 STEP 3: Identify Boundaries

List each boundary (must later be proven with code):

| Boundary Type | Location | Evidence |
|---------------|----------|----------|
| Network boundary | API call from X to Y | Network request #N |
| Persistence boundary | DB write/read | Log line showing query |
| Render/execute boundary | Component/handler | Console error |
| Thrown/error boundary | Error handler | Stack trace |

---

## 🔵 STEP 4: Output "Next Resolution Targets"

List symbols/methods/services that must be resolved cross-repo in `/troubleshoot.resolve`:

```markdown
## Next Resolution Targets
1. `@wix/ambassador-*` client — needs Octocode proof
2. `ServiceX.methodY` — needs implementation proof
3. Error handler at boundary — needs code location
```

---

## Deliverables

Write `.cursor/troubleshoot/<topic>/E2E-TRACE.md` with:

1. **Runtime Evidence Summary**
   - Console errors found
   - Failed network requests
   - Log patterns
   - Metrics anomalies
   - Screenshots/snapshots

2. **E2E System Map** (one screen)

3. **Boundary List** (with evidence pointers)

4. **Next Resolution Targets** (feeds `/troubleshoot.resolve`)

---

## Rules
- **Prefer evidence anchors** (trace/log/request IDs) when available
- **If no traces/log IDs exist**, start from strongest breadcrumb in TROUBLESHOOT-SPEC
- **Log all MCP-S queries** to `.cursor/troubleshoot/<topic>/mcp-s-notes.md`
