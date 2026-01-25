---
description: Debug across the ecosystem (clarify → trace → resolve → hypothesize → fixplan → verify → publish)
globs:
alwaysApply: false
---

# /debug — Orchestrator 🐛🔎

This command is the ONLY entrypoint.

Workflow (must follow in order):
1) Clarify (interactive loop) → `/debug.clarify`
2) Evidence Trace (E2E) → `/debug.trace`
3) Cross-repo Resolution (MCP-S + Octocode) → `/debug.resolve`
4) Hypothesis Tree + Experiments → `/debug.hypothesize`
5) Fix Plan (no code yet) → `/debug.fixplan`
6) Verify (connectivity + checks) → `/debug.verify`
7) Publish (chat + file) → `/debug.publish`

## Enforces (rules)
- [Debug Laws](../rules/debug/debug-laws.mdc)
- [Octocode Mandate](../rules/debug/octocode-mandate.mdc)
- [MCP-S Mandate](../rules/debug/mcp-s-mandate.mdc) — Jira/Slack/DevEx/Chrome DevTools/Grafana

---

## 🔧 MCP-S Tool Categories (Know When to Use)

### 🔴 Frontend/UI Bugs → Chrome DevTools FIRST
```
list-console-messages → list-network-requests → take-screenshot
→ performance-start-trace (if perf) → evaluate-script (inspect state)
```

### 🔴 Backend/API Errors → Grafana FIRST
```
find_error_pattern_logs → query_loki_logs → get_sift_analysis
→ list_incidents → get_current_oncall_users
```

### 🟡 Performance Issues
- **Frontend:** `emulate-cpu`, `emulate-network`, `performance-*` tools
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

## Hard-fail conditions 🚫
- publishing before verify passes
- non-local symbols without Octocode proof
- "it's fixed" claims without verification signals (tests/tsc/lint + connected edges)
- **Frontend bug without `list-console-messages` query**
- **Backend bug without `find_error_pattern_logs` or `query_loki_logs` query**
- **No `code_owners_for_path` query for affected code**
- **`mcp-s-notes.md` missing or empty**

---

## Start
Ask: "What would you like to debug?"
Then run `/debug.clarify` until the Debug Spec is complete.
