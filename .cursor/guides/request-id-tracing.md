---
description: Request ID tracing workflow (x-wix-request-id → root cause analysis → fallback)
globs:
alwaysApply: false
---

# Request ID Tracing (Shared)

## Goal
Use `x-wix-request-id` to bridge frontend evidence to backend root cause.

## PRIMARY (mandatory): AI Root Cause Analysis
1. Extract `x-wix-request-id` from the failed/suspicious network request headers.
2. Run `start_root_cause_analysis(requestId)` to get `analysisId`.
3. Poll with `await_root_cause_analysis(analysisId)` until `COMPLETED` or `FAILED`.
4. Use the markdown report as the primary evidence trail.

## FALLBACK (only if RCA is non-informative)
Use Grafana logs only when:
- RCA fails to start
- RCA returns `FAILED`
- RCA completes but findings are not actionable

Then:
- locate Loki datasource
- query logs by request ID / trace ID

## Discipline
- Always log why fallback was required.
- Treat findings as evidence anchors; prove code edges separately (see proof discipline + Octocode mandate).

