---
description: Validate that all report claims connect by code + MCP-S evidence + required checks
globs:
alwaysApply: false
---

# /debug.verify — Verify ✅

Goal: write `.cursor/debug/<topic>/VALIDATION-REPORT.md`

---

## Connectivity Checks (must be proven)
- import → usage
- call site → implementation
- route/RPC binding → handler
- cross-repo claim → Octocode proof (def+impl+boundary)

---

## 🔎 MCP-S Validation (MANDATORY)

### 1) Evidence File Check
Verify `.cursor/debug/<topic>/mcp-s-notes.md`:
- **EXISTS**: file must be present
- **NOT EMPTY**: must contain tool queries
- **COVERAGE**: every debug phase should have queries

### 2) Required Tool Usage by Bug Type

**Frontend/UI Bug — MUST have:**
- [ ] `list-console-messages` query logged
- [ ] `list-network-requests` query logged
- [ ] `take-screenshot` in evidence

**Backend/API Bug — MUST have:**
- [ ] `find_error_pattern_logs` query logged
- [ ] `query_loki_logs` query logged
- [ ] `list_incidents` checked

**Performance Bug — MUST have:**
- [ ] `performance-*` traces (frontend) OR `find_slow_requests` (backend)
- [ ] `query_prometheus` metrics

**All Bugs — MUST have:**
- [ ] `code_owners_for_path` for affected files
- [ ] `jira__get-issues` for related tickets

### 3) Evidence Quality Check
For each claim in the debug report:
- Has supporting MCP-S evidence? (log snippet, screenshot, metric)
- Evidence is reproducible? (query can be re-run)

---

## Outcome

Write `.cursor/debug/<topic>/VALIDATION-REPORT.md`:

```markdown
## Validation Summary

### MCP-S Evidence Coverage
- mcp-s-notes.md exists: ✅ / ❌
- Tool queries logged: N
- Frontend tools used: ✅ / ❌ / N/A
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
1. Run more MCP-S queries for evidence
2. Re-run `/debug.resolve` for missing proofs
3. Update `/debug.hypothesize` if needed
4. Re-run `/debug.verify`

Until verify passes or all items are NOT FOUND-justified.
