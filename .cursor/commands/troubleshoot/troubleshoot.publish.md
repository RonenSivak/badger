---
description: Publish final debug report to chat + file (only after verify passes)
globs:
alwaysApply: false
---

# /troubleshoot.publish — Publish 📣

## Hard Gates
- MUST have a passing VERIFY-RESULT
- MUST have `mcp-s-notes.md` with tool queries
- MUST have ownership verified via `code_owners_for_path`
- Frontend bugs MUST have Chrome DevTools evidence
- Backend bugs MUST have Grafana evidence

---

## Write
- `.cursor/troubleshoot/<topic>/TROUBLESHOOT-REPORT.md` (final)

Also print the same report in chat.

---

## Format

### 1) Executive Summary (2–5 lines)
- What was the bug
- Root cause (or NOT FOUND)
- Impact/severity

### 2) Evidence Summary
| Source | Findings |
|--------|----------|
| Chrome DevTools | Console errors, network failures |
| Grafana | Log patterns, metrics |
| Jira | Related tickets |
| DevEx | Code owners, deployment status |

### 3) Proven E2E Flow (short)
Entry → ... → Failure boundary
(with pointer references to trace-ledger)

### 4) Root Cause
- Proven cause with evidence
- OR NOT FOUND with searches + scope

### 5) Fix Plan
(from FIX-PLAN)
- Smallest safe change
- Verification gates
- Rollback plan

### 6) MCP-S Evidence Artifacts
- Screenshots: [links]
- Log snippets: [excerpts]
- Metric values: [data]
- Trace IDs: [IDs]

### 7) Ownership
- Code owners: @team (from `code_owners_for_path`)
- On-call: @person (from `get_current_oncall_users`)

### 8) Next Actions Prompt
- "Implement fix"
- "Gather more evidence"
- "Escalate to on-call"
- "Accept risk / defer"
