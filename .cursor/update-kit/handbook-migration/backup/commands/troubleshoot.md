---
description: Troubleshoot across the ecosystem (clarify → trace → resolve → hypothesize → fixplan → verify → publish)
globs:
alwaysApply: false
---

# /troubleshoot — Orchestrator

Cross-ecosystem debugging workflow with proof-driven root cause analysis.

## Input Modes

| Mode | Input | Primary Tools |
|------|-------|---------------|
| **Frontend/UI Bug** | Console errors, visual glitches | Chrome DevTools, BrowserMCP (fallback) |
| **Backend/API Bug** | HTTP errors, failed requests | Grafana, Request ID Tracing |
| **Performance Issue** | Slow responses, timeouts | Chrome DevTools (perf), Prometheus |
| **Deployment Issue** | Rollback, failed deploy | DevEx, Grafana Incidents |

## Required MCPs

| MCP | Purpose |
|-----|---------|
| `user-chrome-devtools` | Network requests, console, performance (PRIMARY for frontend) |
| `user-MCP-S` | Grafana logs, DevEx ownership, Jira/Slack context |
| `user-MCP-S-root-cause` | AI-powered root cause analysis from request ID (PRIMARY for request ID tracing) |
| `user-browsermcp` | DOM interaction, screenshots (FALLBACK for frontend) |
| `user-octocode` | Cross-repo code proof |

## Enforces (rules)

- [Troubleshoot Laws](../rules/troubleshoot/troubleshoot-laws.mdc)
- [Octocode Mandate (shared)](../rules/shared/octocode-mandate.mdc)
- [MCP-S Mandate (shared)](../rules/shared/mcp-s-mandate.mdc)
- [Proof Discipline (shared)](../rules/shared/proof-discipline.mdc)
- [Chrome DevTools Mandate](../rules/troubleshoot/chrome-devtools-mandate.mdc) — Network, Console, Request ID Tracing
- [BrowserMCP Mandate](../rules/troubleshoot/browsermcp-mandate.mdc) — Fallback browser automation

## Delegates to (sub-commands)

- `/troubleshoot.clarify` → `.cursor/commands/troubleshoot/troubleshoot.clarify.md`
- `/troubleshoot.trace` → `.cursor/commands/troubleshoot/troubleshoot.trace.md`
- `/troubleshoot.resolve` → `.cursor/commands/troubleshoot/troubleshoot.resolve.md`
- `/troubleshoot.hypothesize` → `.cursor/commands/troubleshoot/troubleshoot.hypothesize.md`
- `/troubleshoot.fixplan` → `.cursor/commands/troubleshoot/troubleshoot.fixplan.md`
- `/troubleshoot.verify` → `.cursor/commands/troubleshoot/troubleshoot.verify.md`
- `/troubleshoot.publish` → `.cursor/commands/troubleshoot/troubleshoot.publish.md`

---

## Step 0 — Clarify (MANDATORY)

Ask: **"What would you like to debug?"**

Run `/troubleshoot.clarify` until a complete **TROUBLESHOOT-SPEC** exists:
- Bug description + reproduction steps
- Expected vs actual behavior
- Affected area (frontend/backend/both)
- Known breadcrumbs (URLs, error messages, logs)

Outputs:
- `.cursor/troubleshoot/<topic>/TROUBLESHOOT-SPEC.md`

---

## Step 1 — Trace (MANDATORY)

Run `/troubleshoot.trace` to gather runtime evidence.

| Bug Type | Required Tools |
|----------|----------------|
| Frontend/UI | `list_network_requests` → `get_network_request` → `list_console_messages` |
| Backend/API | `find_error_pattern_logs` → `query_loki_logs` → `get_sift_analysis` |
| Performance | `performance_start_trace` (frontend) OR `find_slow_requests` (backend) |
| Request ID Analysis | `start_root_cause_analysis` → `await_root_cause_analysis` (PRIMARY) |

**Request ID Tracing (CRITICAL):** If network call fails, extract `x-wix-request-id` and:
1. **PRIMARY**: Use `start_root_cause_analysis` → `await_root_cause_analysis` for AI-powered RCA
2. **FALLBACK ONLY**: If RCA returns non-informative results, use Grafana logs/dashboards
See [Chrome DevTools Mandate](../rules/troubleshoot/chrome-devtools-mandate.mdc) for details.

Outputs:
- `.cursor/troubleshoot/<topic>/E2E-TRACE.md`
- `.cursor/troubleshoot/<topic>/mcp-s-notes.md`

---

## Step 2 — Resolve (MANDATORY)

Run `/troubleshoot.resolve` to get cross-repo code proof.

For each non-local symbol, use `/octocode/research` to fetch:
- Definition (repo/path + lines + snippet)
- Implementation (repo/path + lines + snippet)
- Side-effect boundary (network/persist/render/throw)

Outputs:
- `.cursor/troubleshoot/<topic>/octocode-queries.md`

---

## Step 3 — Hypothesize (MANDATORY)

Run `/troubleshoot.hypothesize` to build hypothesis tree.

For each hypothesis:
- Statement (what might be wrong)
- Supporting evidence
- Refuting evidence
- Experiment to test

Outputs:
- `.cursor/troubleshoot/<topic>/HYPOTHESIS-TREE.md`

---

## Step 4 — Fix Plan (MANDATORY)

Run `/troubleshoot.fixplan` to design the fix (NO CODE YET).

Plan must include:
- Root cause confirmed
- Fix approach
- Files to modify
- Risks and edge cases
- Rollback strategy

Outputs:
- `.cursor/troubleshoot/<topic>/FIX-PLAN.md`

---

## Step 5 — Verify (MANDATORY before publish)

Run `/troubleshoot.verify` to validate the fix.

Verification gates:
- [ ] Tests pass (new and existing)
- [ ] TypeScript compiles (`tsc`)
- [ ] Linter passes
- [ ] Connected edges proven (import→usage, call→impl)

Outputs:
- `.cursor/troubleshoot/<topic>/VERIFY-RESULT.md`

If failing: fix + re-run verify.

---

## Step 6 — Publish (MANDATORY)

Run `/troubleshoot.publish`:
- Writes `.cursor/troubleshoot/<topic>/TROUBLESHOOT-REPORT.md`
- Prints summary in chat

---

## Hard-fail conditions

- Publishing before verify passes
- Non-local symbols without Octocode proof
- "It's fixed" claims without verification signals (tests/tsc/lint)
- Frontend bug without console log query
- Frontend bug without DOM/snapshot
- Backend bug without `find_error_pattern_logs` or `query_loki_logs`
- No `code_owners_for_path` query for affected code
- `mcp-s-notes.md` missing or empty
- **Request ID found but `start_root_cause_analysis` NOT called** (MANDATORY for request ID tracing)
- Using Grafana logs/dashboard for request ID WITHOUT first trying RCA tools

---

## Start

Ask: **"What would you like to debug?"**
Then run `/troubleshoot.clarify` until the TROUBLESHOOT-SPEC is complete.
