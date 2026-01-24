# Deep Debug Skill 🐛

## Goal
Turn a symptom into a proven E2E root-cause + fix plan across repos.

## Strong signals to prefer
- Trace IDs / span linkage (best for E2E). :contentReference[oaicite:6]{index=6}
- Logs correlated to trace/span IDs (when available).
- Error codes + exact strings.
- Explicit route/RPC bindings.

## Workflow
1) Clarify until you can name:
   - symptom, where, repro/conditions, evidence anchors
2) Build an E2E trace map:
   - entry → network → validation → persistence → consumer → failure boundary
3) For every non-local symbol:
   - MCP-S classify (layer / generated vs runtime / ownership hint)
   - Octocode resolve (def + impl + boundary)
4) Hypothesize:
   - 3–7 hypotheses, each with a falsifiable experiment
5) Fix plan:
   - smallest safe change + verification gates + rollback
6) Verify:
   - edges connect by code (imports/calls/bindings)
   - checks: tests/tsc/lint

## Output discipline
- Keep conclusions gated by verification.
- If unknown: NOT FOUND + exact searches + scope.
