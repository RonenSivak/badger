---
name: troubleshoot
description: "Turn a symptom into a proven end-to-end root cause and fix plan across repos using runtime evidence (Chrome DevTools first, BrowserMCP fallback) plus MCP-S + Octocode proof. Use when debugging frontend/backend/perf issues."
---

# Troubleshoot Skill 🐛

## Goal
Turn a symptom into a proven E2E root-cause + fix plan across repos, using runtime evidence from MCP-S tools (Chrome DevTools first, BrowserMCP as fallback).

---

## Tool Priority Order

**ALWAYS TRY Chrome DevTools FIRST, FALLBACK to BrowserMCP if unavailable.**

```
TRY Chrome DevTools → SUCCESS? → Continue with Chrome DevTools
                   → FAILED?  → FALLBACK to BrowserMCP
```

---

## Tool Options for Debugging

### 🔴 Evidence Gathering (Use FIRST)

**Frontend/UI Bugs — Chrome DevTools (PRIMARY):**
| Tool | Purpose | Priority |
|------|---------|----------|
| `list-console-messages` | JS errors, warnings | **P0 - TRY FIRST** |
| `list-network-requests` | Failed/slow requests | **P0 - NO FALLBACK** |
| `take-screenshot` | Visual evidence | **P0 - TRY FIRST** |
| `take-snapshot` | DOM state | P1 |
| `evaluate-script` | Inspect JS variables | P1 - NO FALLBACK |

**Frontend/UI Bugs — BrowserMCP (FALLBACK only):**
| Tool | Purpose | Priority |
|------|---------|----------|
| `browser_snapshot` | DOM with element refs (uid) | **FALLBACK** |
| `browser_get_console_logs` | JS console output | **FALLBACK** |
| `browser_screenshot` | Visual capture | **FALLBACK** |
| `browser_navigate` | Go to bug URL | **FALLBACK** |

**Backend/API Bugs — Grafana:**
| Tool | Purpose | Priority |
|------|---------|----------|
| `find_error_pattern_logs` | Find error patterns | P0 |
| `query_loki_logs` | Search detailed logs | P0 |
| `get_sift_analysis` | Automated RCA | P0 |
| `list_incidents` | Check active incidents | P1 |

### Tool Selection Logic

| Task | Chrome DevTools (PRIMARY) | BrowserMCP (FALLBACK) |
|------|---------------------------|----------------------|
| Network requests | ✅ ONLY | ❌ NO FALLBACK |
| Performance trace | ✅ ONLY | ❌ NO FALLBACK |
| Evaluate JS | ✅ ONLY | ❌ NO FALLBACK |
| Console errors | ✅ TRY FIRST | ✅ FALLBACK |
| DOM structure | ✅ TRY FIRST | ✅ FALLBACK |
| Screenshot | ✅ TRY FIRST | ✅ FALLBACK |
| Click/interact | ✅ TRY FIRST | ✅ FALLBACK |

**Use Chrome DevTools when:** Always try first — it has network, performance, and JS eval  
**Use BrowserMCP when:** Chrome DevTools unavailable/fails — fallback only

### 🟡 Performance Investigation

**Frontend (Chrome DevTools):**
| Tool | Purpose |
|------|---------|
| `performance-start-trace` | Begin profiling |
| `performance-stop-trace` | End profiling |
| `performance-analyze-insight` | Get insights |
| `emulate-cpu` | Test CPU throttling |
| `emulate-network` | Test slow network |

**Backend:**
| Tool | Purpose |
|------|---------|
| `find_slow_requests` | Find slow endpoints |
| `query_prometheus` | Query metrics |

### 🟢 Ownership & Escalation

| Tool | Purpose |
|------|---------|
| `code_owners_for_path` | Who owns this code |
| `get_current_oncall_users` | Who's on call |
| `where_is_my_commit` | Is fix deployed |
| `get_build` | Build status |
| `jira__get-issues` | Related tickets |
| `slack__search-messages` | Team discussions |

### 🔵 Reproduction (Chrome DevTools)

| Tool | Purpose |
|------|---------|
| `navigate-page` | Go to URL |
| `click` | Click elements |
| `fill` / `fill-form` | Fill inputs |
| `wait-for` | Wait for condition |
| `handle-dialog` | Handle alerts |

### 🔵 Reproduction (BrowserMCP — Playwright-style)

| Tool | Purpose |
|------|---------|
| `browser_navigate` | Go to URL |
| `browser_snapshot` | Get element refs (REQUIRED before interaction) |
| `browser_click` | Click by ref |
| `browser_type` | Type text |
| `browser_hover` | Trigger hover |
| `browser_wait` | Wait N seconds |

**BrowserMCP Workflow:**
```
1. browser_navigate(url) → go to bug location
2. browser_snapshot() → get element refs (uid)
3. browser_click(ref=uid) → interact with element
4. browser_get_console_logs() → check for errors
5. browser_screenshot() → capture result
```

---

## Strong Signals to Prefer
- Trace IDs / span linkage (best for E2E)
- **`x-wix-request-id`** from network requests (links frontend to backend)
- **AI Root Cause Analysis** from request ID (PRIMARY for request ID tracing)
- Logs correlated to trace/span IDs (from Grafana — FALLBACK)
- Console errors (from Chrome DevTools or BrowserMCP)
- Error codes + exact strings
- Explicit route/RPC bindings

## 🔗 Request ID Tracing (Critical Workflow)

Extract `x-wix-request-id` from failed network requests and use AI-powered root cause analysis:

### PRIMARY: AI Root Cause Analysis (MANDATORY)

```
1. list-network-requests → find failed request
2. get-network-request(url) → get headers, extract x-wix-request-id
3. start_root_cause_analysis(requestId) → get analysisId
4. await_root_cause_analysis(analysisId) → poll until COMPLETED/FAILED
5. Use findings from markdown report
```

**start_root_cause_analysis:**
```
server: user-MCP-S-root-cause
arguments:
  requestId: "<x-wix-request-id>"     # REQUIRED
  artifactIds: ["<service>"]         # OPTIONAL: filter services
  hint: "<context>"                  # OPTIONAL: guide analysis
```

**await_root_cause_analysis:**
```
server: user-MCP-S-root-cause
arguments:
  analysisId: "<from start>"         # REQUIRED
  timeoutSeconds: 25                 # Repeat if RUNNING
```

**Status responses:**
- `RUNNING` → call again with same analysisId
- `COMPLETED` → use markdown report
- `FAILED` → proceed to fallback

### FALLBACK: Grafana Logs (ONLY if RCA non-informative)

Use ONLY when:
- `start_root_cause_analysis` fails
- `await_root_cause_analysis` returns FAILED
- Analysis completes but findings are not actionable

```
1. list_datasources(type: "loki") → get UID
2. query_loki_logs with |= "{request_id}"
   Or: grafana.wixpress.com/d/38cCoLymz/error-analytics-traceid
       ?var-request_id={id}&from={time}&to={time}
```

**MUST log:** Why fallback was needed in mcp-s-notes.md

This bridges frontend evidence to backend root cause.

---

## Workflow

### 1) Clarify
Until you can name:
- Symptom, where (frontend/backend), repro/conditions
- Evidence anchors (trace IDs, error messages, service names)
- **Service name for Grafana, URL for Chrome DevTools/BrowserMCP**

### 2) Gather Evidence (Chrome DevTools FIRST, BrowserMCP FALLBACK)
**Frontend bug:**
```
# STEP 1: TRY Chrome DevTools FIRST
list-console-messages → list-network-requests → take-screenshot

# STEP 2: IF FAILED, FALLBACK to BrowserMCP
browser_snapshot → browser_get_console_logs → browser_screenshot
# Log: "Chrome DevTools unavailable, using BrowserMCP fallback"
```

**Backend bug:**
```
find_error_pattern_logs → query_loki_logs → get_sift_analysis
```

**Request ID found:**
```
start_root_cause_analysis(requestId) → await_root_cause_analysis(analysisId)
  → COMPLETED? Use findings
  → FAILED/non-informative? Fallback to query_loki_logs
```

### 3) Build E2E Trace Map
Entry → network → validation → persistence → consumer → failure boundary

### 4) Resolve Non-Local Symbols
For every non-local symbol:
- MCP-S: classify (layer / generated vs runtime / ownership)
- DevEx: `code_owners_for_path` for ownership
- Octocode: resolve (def + impl + boundary)

### 5) Hypothesize
3–7 hypotheses, each with:
- What evidence supports it (from MCP-S/BrowserMCP queries)
- A falsifiable experiment (using MCP-S/BrowserMCP tools)
- Expected outcome

### 6) Fix Plan
Smallest safe change + verification gates + rollback

### 7) Verify
- Edges connect by code (imports/calls/bindings)
- MCP-S/BrowserMCP evidence logged
- Checks: tests/tsc/lint

---

## Output Discipline
- Keep conclusions gated by verification
- Log all MCP-S tool queries to `mcp-s-notes.md`
- Log all BrowserMCP tool queries to `mcp-s-notes.md`
- If unknown: NOT FOUND + exact searches (Octocode + MCP-S + BrowserMCP) + scope

---

## Quick Decision Tree

```
Bug Type?
│
├─ Frontend/UI
│  ├─ TRY: Chrome DevTools FIRST
│  │  └─ list-console-messages → list-network-requests → take-screenshot
│  │  └─ If perf: performance-* tools
│  │  └─ If request ID found: start_root_cause_analysis (see below)
│  │
│  └─ IF UNAVAILABLE: FALLBACK to BrowserMCP
│     └─ browser_snapshot → browser_get_console_logs → browser_screenshot
│     └─ (No network/performance in BrowserMCP)
│
├─ Request ID Found (from any network request)
│  ├─ PRIMARY (MANDATORY): AI Root Cause Analysis
│  │  └─ start_root_cause_analysis(requestId)
│  │  └─ await_root_cause_analysis(analysisId) → poll until done
│  │  └─ Use findings from markdown report
│  │
│  └─ FALLBACK (only if RCA non-informative):
│     └─ query_loki_logs OR Grafana dashboard
│     └─ MUST LOG: Why fallback was needed
│
├─ Backend/API
│  └─ find_error_pattern_logs → query_loki_logs → get_sift_analysis
│     └─ list_incidents → get_current_oncall_users
│
├─ Performance
│  └─ Frontend: emulate-cpu + performance traces (Chrome DevTools ONLY - no fallback)
│  └─ Backend: find_slow_requests → query_prometheus
│
└─ Unknown
   └─ jira__get-issues + slack__search-messages
      └─ code_owners_for_path
      └─ list_incidents
```
