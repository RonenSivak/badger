---
description: Deep debug across the ecosystem (clarify → trace → resolve → hypothesize → fixplan → verify → publish)
globs:
alwaysApply: false
---

# /deep-debug — Orchestrator 🐛🔎

This command is the ONLY entrypoint.

Workflow (must follow in order):
1) Clarify (interactive loop) → `/deep-debug.clarify`
2) Evidence Trace (E2E) → `/deep-debug.trace`
3) Cross-repo Resolution (MCP-S + Octocode) → `/deep-debug.resolve`
4) Hypothesis Tree + Experiments → `/deep-debug.hypothesize`
5) Fix Plan (no code yet) → `/deep-debug.fixplan`
6) Verify (connectivity + checks) → `/deep-debug.verify`
7) Publish (chat + file) → `/deep-debug.publish`

Enforces:
- `.cursor/rules/deep-debug-laws.mdc`
- `.cursor/rules/octocode-mandate.mdc` (if present)

Hard fails:
- publishing before verify passes
- non-local symbols without Octocode proof
- “it’s fixed” claims without verification signals (tests/tsc/lint + connected edges)

Start:
Ask: “What would you like to deep-debug?”
Then run `/deep-debug.clarify` until the Debug Spec is complete.
