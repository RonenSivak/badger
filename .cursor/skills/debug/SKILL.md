# Debug Skill 🐛

## Goal
Turn a symptom into a proven E2E root-cause + fix plan across repos, using runtime evidence from MCP-S tools.

---

## MCP-S Tools for Debugging

### 🔴 Evidence Gathering (Use FIRST)

**Frontend/UI Bugs — Chrome DevTools:**
| Tool | Purpose | Priority |
|------|---------|----------|
| `list-console-messages` | JS errors, warnings | P0 |
| `list-network-requests` | Failed/slow requests | P0 |
| `take-screenshot` | Visual evidence | P0 |
| `take-snapshot` | DOM state | P1 |
| `evaluate-script` | Inspect JS variables | P1 |

**Backend/API Bugs — Grafana:**
| Tool | Purpose | Priority |
|------|---------|----------|
| `find_error_pattern_logs` | Find error patterns | P0 |
| `query_loki_logs` | Search detailed logs | P0 |
| `get_sift_analysis` | Automated RCA | P0 |
| `list_incidents` | Check active incidents | P1 |

### 🟡 Performance Investigation

**Frontend:**
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

---

## Strong Signals to Prefer
- Trace IDs / span linkage (best for E2E)
- **`x-wix-request-id`** from network requests (links frontend to backend)
- Logs correlated to trace/span IDs (from Grafana)
- Console errors (from Chrome DevTools)
- Error codes + exact strings
- Explicit route/RPC bindings

## 🔗 Request ID Tracing (Critical Workflow)

Extract `x-wix-request-id` from failed network requests and trace in Grafana:

```
1. list-network-requests → find failed request
2. get-network-request(url) → get headers
3. Extract: x-wix-request-id
4. Trace: grafana.wixpress.com/d/38cCoLymz/error-analytics-traceid
         ?var-request_id={id}&from={time}&to={time}
   Or: query_loki_logs with |= "{request_id}"
```

This bridges frontend evidence to backend logs.

---

## Workflow

### 1) Clarify
Until you can name:
- Symptom, where (frontend/backend), repro/conditions
- Evidence anchors (trace IDs, error messages, service names)
- **Service name for Grafana, URL for Chrome DevTools**

### 2) Gather Evidence (MCP-S FIRST)
**Frontend bug:**
```
list-console-messages → list-network-requests → take-screenshot
```

**Backend bug:**
```
find_error_pattern_logs → query_loki_logs → get_sift_analysis
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
- What evidence supports it (from MCP-S queries)
- A falsifiable experiment (using MCP-S tools)
- Expected outcome

### 6) Fix Plan
Smallest safe change + verification gates + rollback

### 7) Verify
- Edges connect by code (imports/calls/bindings)
- MCP-S evidence logged
- Checks: tests/tsc/lint

---

## Output Discipline
- Keep conclusions gated by verification
- Log all MCP-S tool queries to `mcp-s-notes.md`
- If unknown: NOT FOUND + exact searches (Octocode + MCP-S) + scope

---

## Quick Decision Tree

```
Bug Type?
│
├─ Frontend/UI
│  └─ list-console-messages → list-network-requests → take-screenshot
│     └─ If perf: performance-* tools
│
├─ Backend/API
│  └─ find_error_pattern_logs → query_loki_logs → get_sift_analysis
│     └─ list_incidents → get_current_oncall_users
│
├─ Performance
│  └─ Frontend: emulate-cpu + performance traces
│  └─ Backend: find_slow_requests → query_prometheus
│
└─ Unknown
   └─ jira__get-issues + slack__search-messages
      └─ code_owners_for_path
      └─ list_incidents
```
