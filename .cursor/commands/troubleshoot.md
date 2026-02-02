---
description: Troubleshoot across the ecosystem (clarify → trace → resolve → hypothesize → fixplan → verify → publish)
globs:
alwaysApply: false
---

# /troubleshoot — Orchestrator 🐛🔎

This command is the ONLY entrypoint.

Workflow (must follow in order):
1) Clarify (interactive loop) → `/troubleshoot.clarify`
2) Evidence Trace (E2E) → `/troubleshoot.trace`
3) Cross-repo Resolution (MCP-S + Octocode) → `/troubleshoot.resolve`
4) Hypothesis Tree + Experiments → `/troubleshoot.hypothesize`
5) Fix Plan (no code yet) → `/troubleshoot.fixplan`
6) Verify (connectivity + checks) → `/troubleshoot.verify`
7) Publish (chat + file) → `/troubleshoot.publish`

## Enforces (rules)
- [Troubleshoot Laws](../rules/troubleshoot/troubleshoot-laws.mdc)
- [Octocode Mandate](../rules/troubleshoot/octocode-mandate.mdc)
- [MCP-S Mandate](../rules/troubleshoot/mcp-s-mandate.mdc) — Jira/Slack/DevEx/Chrome DevTools/Grafana
- [BrowserMCP Mandate](../rules/troubleshoot/browsermcp-mandate.mdc) — Fallback browser automation

---

## 🔧 Tool Categories (Know When to Use)

### 🔴 Frontend/UI Bugs → Chrome DevTools FIRST, BrowserMCP as FALLBACK

**PRIORITY ORDER:**
1. **TRY Chrome DevTools (MCP-S) FIRST** — Full debugging capabilities
2. **FALLBACK to BrowserMCP** — Only if Chrome DevTools unavailable/fails

**Chrome DevTools (PRIMARY):**
```
list-console-messages → list-network-requests → take-screenshot
→ performance-start-trace (if perf) → evaluate-script (inspect state)
```

**BrowserMCP (FALLBACK only):**
```
browser_snapshot → browser_get_console_logs → browser_screenshot
→ browser_click → browser_type → browser_wait (reproduce bugs)
```

**Tool Capabilities:**
| Task | Chrome DevTools (PRIMARY) | BrowserMCP (FALLBACK) |
|------|---------------------------|----------------------|
| Console errors | ✅ `list-console-messages` | ✅ `browser_get_console_logs` |
| Network requests | ✅ `list-network-requests` | ❌ NOT AVAILABLE |
| Performance trace | ✅ `performance-*` | ❌ NOT AVAILABLE |
| DOM/accessibility | ✅ `take-snapshot` | ✅ `browser_snapshot` |
| Screenshots | ✅ `take-screenshot` | ✅ `browser_screenshot` |
| Click/interact | ✅ `click` | ✅ `browser_click` |
| Evaluate JS | ✅ `evaluate-script` | ❌ NOT AVAILABLE |

### 🔴 Backend/API Errors → Grafana FIRST
```
find_error_pattern_logs → query_loki_logs → get_sift_analysis
→ list_incidents → get_current_oncall_users
```

### 🟡 Performance Issues
- **Frontend:** `emulate-cpu`, `emulate-network`, `performance-*` tools (Chrome DevTools ONLY)
- **Backend:** `find_slow_requests`, `query_prometheus`

### 🟢 Ownership & Escalation → DevEx
```
code_owners_for_path → where_is_my_commit → get_build → get_rollout_history
```

### 🔵 Context & History → Jira/Slack
```
jira__get-issues → slack__search-messages → docs-schema__search_docs
```

---

## 🚨 Frontend Tool Selection Logic

```
START Frontend Debug
│
├─ TRY: Chrome DevTools MCP tools
│  └─ list-console-messages, list-network-requests, take-screenshot
│
├─ SUCCESS? → Continue with Chrome DevTools
│  └─ Use: click, fill, navigate-page, evaluate-script, performance-*
│
└─ FAILED/UNAVAILABLE? → FALLBACK to BrowserMCP
   └─ Use: browser_snapshot, browser_get_console_logs, browser_screenshot
   └─ Use: browser_click, browser_type, browser_navigate, browser_wait
```

**Detection:** If Chrome DevTools tools return errors or are not connected, switch to BrowserMCP.

---

## 🌐 BrowserMCP Fallback Reference

**Use ONLY when Chrome DevTools is unavailable.**

**Evidence Gathering:**
```
browser_snapshot         # Get DOM with element refs
browser_get_console_logs # JS errors and logs
browser_screenshot       # Visual state capture
```

**Reproduction & Interaction:**
```
browser_navigate   # Go to URL
browser_click      # Click by ref (from snapshot)
browser_type       # Type text into input
browser_hover      # Trigger hover states
browser_wait       # Wait N seconds
```

**Workflow:**
1. `browser_navigate` → go to URL
2. `browser_snapshot` → get element refs
3. `browser_click(ref)` → interact (ref from step 2)
4. `browser_get_console_logs` → check for errors
5. `browser_screenshot` → capture result

---

## Hard-fail conditions 🚫
- publishing before verify passes
- non-local symbols without Octocode proof
- "it's fixed" claims without verification signals (tests/tsc/lint + connected edges)
- **Frontend bug without console log query** (try `list-console-messages`, fallback `browser_get_console_logs`)
- **Frontend bug without DOM/snapshot** (try `take-snapshot`, fallback `browser_snapshot`)
- **Backend bug without `find_error_pattern_logs` or `query_loki_logs` query**
- **No `code_owners_for_path` query for affected code**
- **`mcp-s-notes.md` missing or empty**

---

## Start
Ask: "What would you like to debug?"
Then run `/troubleshoot.clarify` until the Debug Spec is complete.
