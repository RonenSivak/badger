---
description: Turn the proven trace into hypotheses + minimal experiments using MCP-S tools
globs:
alwaysApply: false
---

# /debug.hypothesize — Hypothesis Tree 🌲

Input:
- DEBUG-SPEC
- E2E-TRACE
- trace-ledger (resolved symbols)
- mcp-s-notes (evidence from Chrome DevTools/Grafana)

Output:
- `.cursor/debug/<topic>/HYPOTHESES.md`

---

## Rules
- **3–7 hypotheses max**
- Each hypothesis must include:
  - What proven hop(s) it explains (link to trace-ledger pointers)
  - What evidence supports it (from MCP-S queries)
  - A minimal experiment to falsify it
  - Expected outcome if true/false

---

## Experiments Using MCP-S Tools

### Frontend Experiments (Chrome DevTools)

**Test UI behavior:**
```
# Navigate to repro URL
chrome-devtools__navigate-page → url

# Interact
chrome-devtools__click → selector
chrome-devtools__fill → selector, value

# Observe
chrome-devtools__list-console-messages
chrome-devtools__list-network-requests
chrome-devtools__take-screenshot
```

**Test performance hypothesis:**
```
# With throttling
chrome-devtools__emulate-cpu → rate: 4 (4x slowdown)
chrome-devtools__emulate-network → preset: "slow-3g"

# Profile
chrome-devtools__performance-start-trace
# ... reproduce action ...
chrome-devtools__performance-stop-trace
chrome-devtools__performance-analyze-insight
```

**Test responsive behavior:**
```
chrome-devtools__resize-page → width: 375, height: 667 (mobile)
chrome-devtools__take-screenshot
```

---

### Backend Experiments (Grafana)

**Test error hypothesis:**
```
# Check if error pattern exists
grafana__find_error_pattern_logs → service, timeRange

# Query specific logs
grafana__query_loki_logs → {service="X"} |= "hypothesis keyword"

# Check metrics
grafana__query_prometheus → rate(errors{service="X"}[5m])
```

**Test performance hypothesis:**
```
# Find slow requests
grafana__find_slow_requests → service, threshold

# Query latency metrics
grafana__query_prometheus → histogram_quantile(0.99, ...)
```

**Test deployment hypothesis:**
```
# Check if recent deployment
devex__get_rollout_history → project

# Check if commit is deployed
devex__where_is_my_commit → sha

# Check build status
devex__search_builds → project
```

---

## Hypothesis Format

```markdown
## Hypothesis N: <title>

### What it explains
- Hop A → B shows <behavior> because of <cause>
- Links to: trace-ledger entry #X

### Evidence
- Console error: "<error message>" (from list-console-messages)
- Log pattern: "<pattern>" (from find_error_pattern_logs)
- Metric: <value> (from query_prometheus)

### Experiment
**Tool sequence:**
1. `chrome-devtools__<tool>` with args: ...
2. `grafana__<tool>` with args: ...
3. Observe: <what to look for>

**Expected if TRUE:**
- <specific observable outcome>

**Expected if FALSE:**
- <specific observable outcome>

### Status
- [ ] Experiment run
- [ ] Result: TRUE / FALSE / INCONCLUSIVE
```

---

## Prefer Experiments That:
- Touch fewer repos
- Validate at boundaries (network/persist/throw/render)
- Produce objective signals:
  - Console messages (Chrome DevTools)
  - Log entries (Grafana Loki)
  - Metric changes (Grafana Prometheus)
  - Test results (tests/tsc/lint)
- Use MCP-S tools for reproducible evidence
