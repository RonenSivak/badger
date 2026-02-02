---
description: Deep-debug: MCP-S + Octocode + BrowserMCP proof loop (unlimited) to resolve all non-local symbols in the trace
globs:
alwaysApply: false
---

# /troubleshoot.resolve — Proof Loop 🛰️

Goal: produce:
- `.cursor/troubleshoot/<topic>/mcp-s-notes.md`
- `.cursor/troubleshoot/<topic>/octocode-queries.md`
- `.cursor/troubleshoot/<topic>/trace-ledger.md`

---

## MCP-S Tools Quick Reference

### 🔴 Evidence & Investigation Tools

| Tool | When to Use |
|------|-------------|
| `find_error_pattern_logs` | First tool for backend errors |
| `query_loki_logs` | Detailed log search |
| `get_sift_analysis` | Automated root cause |
| `find_slow_requests` | Performance issues |
| `list-console-messages` | Frontend JS errors |
| `list-network-requests` | HTTP request issues |
| `take-screenshot` | Visual evidence |
| `evaluate-script` | Inspect JS state |

### 🟡 Performance Tools

| Tool | When to Use |
|------|-------------|
| `performance-start-trace` | Begin frontend profiling |
| `performance-stop-trace` | End profiling |
| `performance-analyze-insight` | Get insights |
| `emulate-cpu` | Test CPU throttling |
| `emulate-network` | Test slow network |
| `query_prometheus` | Backend metrics |

### 🟢 Ownership & Context Tools

| Tool | When to Use |
|------|-------------|
| `code_owners_for_path` | Who owns this code |
| `where_is_my_commit` | Is fix deployed |
| `get_build` | Build status |
| `search_builds` | Find builds |
| `get_rollout_history` | Deployment timeline |
| `jira__get-issues` | Related tickets |
| `slack__search-messages` | Discussions |

### 🔵 Incident & On-Call Tools

| Tool | When to Use |
|------|-------------|
| `list_incidents` | Active incidents |
| `get_incident` | Incident details |
| `get_current_oncall_users` | Who to escalate to |
| `list_oncall_teams` | Team schedules |
| `list_alert_rules` | Alert configs |
| `search_dashboards` | Find dashboards |

### ⚪ Reproduction Tools (Chrome DevTools)

| Tool | When to Use |
|------|-------------|
| `click` | Simulate clicks |
| `fill` / `fill-form` | Fill inputs |
| `hover` | Trigger hover |
| `drag` | Drag & drop |
| `navigate-page` | Go to URL |
| `wait-for` | Wait for condition |
| `handle-dialog` | Handle alerts |
| `upload-file` | File upload |
| `resize-page` | Responsive test |

### ⚪ Reproduction Tools (BrowserMCP — Playwright-style)

| Tool | When to Use |
|------|-------------|
| `browser_navigate` | Navigate to URL |
| `browser_snapshot` | Get DOM with element refs (REQUIRED before interaction) |
| `browser_click` | Click by ref (from snapshot) |
| `browser_type` | Type text into input |
| `browser_hover` | Trigger hover states |
| `browser_press_key` | Keyboard input |
| `browser_wait` | Wait N seconds |
| `browser_screenshot` | Capture visual state |
| `browser_get_console_logs` | Check console after action |

**BrowserMCP Workflow:**
```
1. browser_navigate(url) → go to bug location
2. browser_snapshot() → get element refs (uid)
3. browser_click(ref=uid) → interact with element
4. browser_get_console_logs() → check for errors
5. browser_screenshot() → capture result
```

---

## Mandatory Loop (unlimited iterations)

For EVERY unresolved / non-local symbol found in E2E-TRACE:

### A) Gather Context (MCP-S)

**1) Ownership (MANDATORY)**
```
server: user-MCP-S
toolName: code_owners_for_path
arguments:
  path: "<file or directory path>"
```

**2) Related Issues**
```
server: user-MCP-S
toolName: jira__get-issues
arguments:
  projectKey: "PROJECT"
  jql: "text ~ '<error or feature>'"
  maxResults: 10
```

**3) Team Discussions**
```
server: user-MCP-S
toolName: slack__search-messages
arguments:
  searchText: "<error message or feature>"
```

**4) Check Incidents (if production issue)**
```
server: user-MCP-S
toolName: grafana__list_incidents
arguments:
  status: "active"
```

**5) Find Who to Escalate**
```
server: user-MCP-S
toolName: grafana__get_current_oncall_users
arguments:
  team: "<team name>"
```

### B) Classification (from MCP-S findings)

Record:
- Layer: sdk/client/service/facade/runtime
- Generated vs runtime
- Owner/team (from `code_owners_for_path`)
- Related incidents/tickets

### C) Code Proof (Octocode)

Run **`/octocode/research`** to fetch:
- Definition (repo/path + lines + snippet)
- Implementation (repo/path + lines + snippet)
- Side-effect boundary snippet (network/persist/render/throw)

Write queries + results into:
`.cursor/troubleshoot/<topic>/octocode-queries.md`

### D) Update Trace Ledger

Append to `.cursor/troubleshoot/<topic>/trace-ledger.md`:

| Symbol | Owner | Layer | Def | Impl | Boundary | Evidence | Status |
|--------|-------|-------|-----|------|----------|----------|--------|
| X | @team | SDK | link | link | link | trace #123 | ✅ |

---

## Additional Investigation (when needed)

### If you need more logs:
```
server: user-MCP-S
toolName: grafana__query_loki_logs
arguments:
  query: '{service="X"} |= "error" | json'
  limit: 100
```

### If you need metrics:
```
server: user-MCP-S
toolName: grafana__query_prometheus
arguments:
  query: 'rate(http_requests_total{service="X",status="500"}[5m])'
```

### If you need dashboard context:
```
server: user-MCP-S
toolName: grafana__search_dashboards
arguments:
  query: "<service name>"
```

### If you need to reproduce in browser (Chrome DevTools):
```
server: user-MCP-S
toolName: chrome-devtools__navigate-page
arguments:
  url: "<URL to reproduce>"
  
# Then interact
toolName: chrome-devtools__click
arguments:
  selector: "<button selector>"
  
# Check results
toolName: chrome-devtools__list-console-messages
arguments: {}
```

### If you need to reproduce in browser (BrowserMCP):
```
# Navigate to bug location
server: user-browsermcp
toolName: browser_navigate
arguments:
  url: "<URL to reproduce>"

# Get element refs from DOM
server: user-browsermcp
toolName: browser_snapshot
arguments: {}

# Interact by ref (get ref from snapshot above)
server: user-browsermcp
toolName: browser_click
arguments:
  ref: "<uid from snapshot>"
  element: "Button description"

# Check console for errors
server: user-browsermcp
toolName: browser_get_console_logs
arguments: {}

# Capture visual state
server: user-browsermcp
toolName: browser_screenshot
arguments: {}
```

---

## Rules
- **Generated wrappers do NOT count:** find generator source + runtime implementer
- **Record every Octocode query** in `octocode-queries.md`
- **Record every MCP-S query** in `mcp-s-notes.md`
- **Record every BrowserMCP query** in `mcp-s-notes.md`
- **Add every symbol** to `trace-ledger.md` with proof pointers

## Stop Conditions
- All symbols resolved, OR
- Marked NOT FOUND with:
  - Exact Octocode searches + scope
  - Exact MCP-S tool queries attempted
  - Chrome DevTools / BrowserMCP / Grafana queries tried
