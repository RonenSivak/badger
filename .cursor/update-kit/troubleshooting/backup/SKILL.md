---
name: troubleshooting
description: "Cross-ecosystem debugging with runtime evidence and proof-driven root cause analysis. Use when debugging frontend bugs, backend errors, performance issues, or deployment problems."
---

# Troubleshooting

Cross-ecosystem debugging: trace → resolve → hypothesize → fix plan → verify.

## Quick Start
1. Clarify the bug (use clickable options below)
2. Trace runtime evidence (DevTools, logs, metrics)
3. Resolve code connections (Octocode)
4. Build hypothesis tree
5. Create fix plan (no code yet)
6. Verify the fix
7. Publish report

## Clarify (ALWAYS use AskQuestion tool)
Start by asking with clickable options:
```
AskQuestion:
  title: "Troubleshoot Setup"
  questions:
    - id: "bug_type"
      prompt: "What type of issue?"
      options:
        - { id: "frontend", label: "Frontend/UI bug" }
        - { id: "backend", label: "Backend/API error" }
        - { id: "perf", label: "Performance issue" }
        - { id: "deploy", label: "Deployment problem" }
    - id: "has_request_id"
      prompt: "Do you have a request ID (x-wix-request-id)?"
      options:
        - { id: "yes", label: "Yes — I have the request ID" }
        - { id: "no", label: "No — I'll need to reproduce" }
```
Then gather: bug description, repro steps, expected vs actual.

## Workflow Checklist
Copy and track your progress:
```
- [ ] Bug spec clarified (description, repro, expected)
- [ ] Runtime evidence gathered
- [ ] Request ID traced (if applicable)
- [ ] Code connections resolved (Octocode)
- [ ] Hypothesis tree built
- [ ] Fix plan created
- [ ] Fix verified (tests/tsc/lint)
- [ ] Report published
```

## Input Modes

| Mode | Input | Primary Tools |
|------|-------|---------------|
| **Frontend/UI** | Console errors, visual glitches | Chrome DevTools |
| **Backend/API** | HTTP errors, failed requests | Grafana, Request ID Tracing |
| **Performance** | Slow responses, timeouts | DevTools perf, Prometheus |
| **Deployment** | Rollback, failed deploy | DevEx, Grafana Incidents |

## Required MCPs

| MCP | Purpose |
|-----|---------|
| `user-chrome-devtools` | Network, console, performance (PRIMARY for frontend) |
| `user-MCP-S` | Grafana logs, DevEx ownership, Jira/Slack |
| `user-MCP-S-root-cause` | AI-powered RCA from request ID |
| `user-octocode` | Cross-repo code proof |

## 4 Mandatory Sources (ALWAYS Search ALL)

When investigating a bug, **ALWAYS search ALL 4**:

```
- [ ] Slack: `slack__search-messages` (prior discussions, similar issues)
- [ ] Jira: `jira__get-issues` (related bugs, requirements)
- [ ] Docs: `docs-schema__search_docs` (architecture, known issues)
- [ ] wix-private/*: Octocode (implementation, related code)
```

**Rules:**
- Search all 4 even if DevTools/RCA already shows the error
- If not found → expand search (synonyms, older dates) before giving up
- Cross-reference: error message → search Slack for discussions

See [internal-knowledge-search.md](../../guides/internal-knowledge-search.md) for complete protocol.

## Trace Strategy

### Frontend Bugs
1. `list_network_requests` → `get_network_request`
2. `list_console_messages` for errors
3. Extract `x-wix-request-id` from failed requests

### Backend Bugs
1. `find_error_pattern_logs` in Grafana
2. `query_loki_logs` for details
3. Use request ID for RCA if available

### Request ID Tracing (CRITICAL)
If you have `x-wix-request-id`:
1. **PRIMARY**: `start_root_cause_analysis` → `await_root_cause_analysis`
2. **FALLBACK**: Grafana logs only if RCA non-informative

See [request-id-tracing.md](../../guides/request-id-tracing.md) for details.

## Hypothesis Tree Format
For each hypothesis:
- Statement (what might be wrong)
- Supporting evidence
- Refuting evidence
- Experiment to test

## Fix Plan (No Code Yet)
Plan must include:
- Root cause confirmed (with proof)
- Fix approach
- Files to modify
- Risks and edge cases
- Rollback strategy

## Artifacts
All outputs go to `.cursor/troubleshoot/<topic>/`:
- `TROUBLESHOOT-SPEC.md` - Bug description
- `E2E-TRACE.md` - Runtime evidence
- `octocode-queries.md` - Code proofs
- `mcp-s-notes.md` - Internal context
- `HYPOTHESIS-TREE.md` - Hypotheses
- `FIX-PLAN.md` - Fix approach
- `TROUBLESHOOT-REPORT.md` - Final report

## Hard-fail Conditions
- Publishing before verify passes
- **Skipping any of the 4 mandatory sources** (Slack, Jira, Docs, wix-private/*)
- Non-local symbols without Octocode proof
- "It's fixed" without verification signals
- Frontend bug without console log query
- Backend bug without `find_error_pattern_logs`
- Request ID found but RCA not called
- Missing `mcp-s-notes.md`
- Marking NOT FOUND without trying 3+ query variations per source
