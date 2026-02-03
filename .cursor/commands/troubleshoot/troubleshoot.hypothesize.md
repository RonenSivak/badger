---
description: Build hypothesis tree + design experiments to validate root cause
globs:
alwaysApply: false
---

# /troubleshoot.hypothesize — Hypothesis Tree

Goal: Build hypotheses from evidence and design experiments to validate.

## Prerequisites

- TROUBLESHOOT-SPEC exists
- E2E-TRACE exists
- trace-ledger (resolved symbols)
- mcp-s-notes (evidence from tools)

## Output

- `.cursor/troubleshoot/<topic>/HYPOTHESIS-TREE.md`

---

## Rules

- **3–7 hypotheses max**
- Each hypothesis must include:
  - What proven hop(s) it explains (link to trace-ledger)
  - What evidence supports it (from mcp-s-notes)
  - A minimal experiment to falsify it
  - Expected outcome if true/false

---

## Experiment Types

| Bug Type | Experiment Tools |
|----------|------------------|
| Frontend UI | Chrome DevTools: `navigate-page` → `click/fill` → `list-console-messages` |
| Frontend Performance | `performance-start-trace` → reproduce → `performance-stop-trace` |
| Backend Error | `find_error_pattern_logs` → `query_loki_logs` with specific filter |
| Backend Performance | `find_slow_requests` → `query_prometheus` |
| Deployment | `where_is_my_commit` → `get_rollout_history` |

See mandate files for detailed tool usage:
- [Chrome DevTools Mandate](../../rules/troubleshoot/chrome-devtools-mandate.mdc)
- [MCP-S Mandate (shared)](../../rules/shared/011-mcp-s-mandate.mdc)
- [BrowserMCP Mandate](../../rules/troubleshoot/browsermcp-mandate.mdc)

---

## Hypothesis Format

```markdown
## Hypothesis N: <title>

### What it explains
- Hop A → B shows <behavior> because of <cause>
- Links to: trace-ledger entry #X

### Evidence
- Console error: "<error message>"
- Log pattern: "<pattern>"
- Metric: <value>

### Experiment
**Tools:** <list of MCP tools to use>

**Expected if TRUE:**
- <specific observable outcome>

**Expected if FALSE:**
- <specific observable outcome>

### Status
- [ ] Experiment run
- [ ] Result: TRUE / FALSE / INCONCLUSIVE
```

---

## Prefer Experiments That

- Touch fewer repos
- Validate at boundaries (network/persist/throw/render)
- Produce objective signals:
  - Console messages
  - DOM snapshots
  - Log entries (Grafana Loki)
  - Metric changes (Grafana Prometheus)
  - Test results (tests/tsc/lint)
- Use MCP tools for reproducible evidence

---

## Output

Write `.cursor/troubleshoot/<topic>/HYPOTHESIS-TREE.md` with all hypotheses.

When complete, say: "Hypotheses complete. Run `/troubleshoot.fixplan`."
