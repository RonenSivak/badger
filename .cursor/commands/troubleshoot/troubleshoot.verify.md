---
description: Deep-debug: Validate that all report claims connect by code + MCP-S/BrowserMCP evidence + required checks
globs:
alwaysApply: false
---

# /troubleshoot.verify — Verify ✅

Goal: write `.cursor/troubleshoot/<topic>/VERIFY-RESULT.md`

---

## Connectivity Checks (must be proven)
- import → usage
- call site → implementation
- route/RPC binding → handler
- cross-repo claim → Octocode proof (def+impl+boundary)

---

## 🔎 MCP-S + BrowserMCP Validation (MANDATORY)

### 1) Evidence File Check
Verify `.cursor/troubleshoot/<topic>/mcp-s-notes.md`:
- **EXISTS**: file must be present
- **NOT EMPTY**: must contain tool queries
- **COVERAGE**: every debug phase should have queries

### 2) Required Tool Usage by Bug Type

**Frontend/UI Bug — MUST have at least one from each category:**

Console logs (pick one or both):
- [ ] `list-console-messages` (Chrome DevTools) query logged
- [ ] `browser_get_console_logs` (BrowserMCP) query logged

Network (Chrome DevTools only):
- [ ] `list-network-requests` query logged

DOM/Snapshot (pick one or both):
- [ ] `take-snapshot` (Chrome DevTools) in evidence
- [ ] `browser_snapshot` (BrowserMCP) in evidence

Screenshot (pick one or both):
- [ ] `take-screenshot` (Chrome DevTools) in evidence
- [ ] `browser_screenshot` (BrowserMCP) in evidence

**Backend/API Bug — MUST have:**
- [ ] `find_error_pattern_logs` query logged
- [ ] `query_loki_logs` query logged
- [ ] `list_incidents` checked

**Performance Bug — MUST have:**
- [ ] `performance-*` traces (frontend, Chrome DevTools only) OR `find_slow_requests` (backend)
- [ ] `query_prometheus` metrics

**All Bugs — MUST have:**
- [ ] `code_owners_for_path` for affected files
- [ ] `jira__get-issues` for related tickets

### 3) Evidence Quality Check
For each claim in the debug report:
- Has supporting MCP-S/BrowserMCP evidence? (log snippet, screenshot, metric, DOM snapshot)
- Evidence is reproducible? (query can be re-run)

---

## Outcome

Write `.cursor/troubleshoot/<topic>/VERIFY-RESULT.md`:

```markdown
## Validation Summary

### MCP-S + BrowserMCP Evidence Coverage
- mcp-s-notes.md exists: ✅ / ❌
- Tool queries logged: N
- Chrome DevTools used: ✅ / ❌ / N/A
- BrowserMCP used: ✅ / ❌ / N/A
- Backend tools used: ✅ / ❌ / N/A
- Ownership verified: ✅ / ❌

### Code Connectivity
- Verified edges: N
- Broken claims: N
- NOT FOUND items: N

### Required Checks
- [ ] Unit tests pass
- [ ] TSC/typecheck clean
- [ ] Lint clean
- [ ] CI gates pass

### Evidence Artifacts
- Screenshots: N
- Log snippets: N
- Metric values: N
- Trace IDs: N

## Result: PASS / FAIL
```

---

## VERIFIED EDGES List
| From | To | Evidence | Proof Type |
|------|-----|----------|------------|
| A | B | console error #1 | import |
| B | C | log pattern | call site |

---

## BROKEN CLAIMS List
| Claim | Issue | MCP-S Query Attempted |
|-------|-------|----------------------|
| X calls Y | No import found | Octocode search: ... |

---

## NOT FOUND List
| Item | Searches Attempted | Scope |
|------|-------------------|-------|
| Z impl | Octocode: ..., Grafana: ... | repos X, Y |

---

## Gate
If verify fails → do not publish. 

Iterate:
1. Run more MCP-S or BrowserMCP queries for evidence
2. Re-run `/troubleshoot.resolve` for missing proofs
3. Update `/troubleshoot.hypothesize` if needed
4. Re-run `/troubleshoot.verify`

Until verify passes or all items are NOT FOUND-justified.
