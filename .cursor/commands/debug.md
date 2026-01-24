---
description: Debug across the ecosystem (clarify → trace → resolve → hypothesize → fixplan → verify → publish)
globs:
alwaysApply: false
---

# /debug — Orchestrator 🐛🔎

This command is the ONLY entrypoint.

Workflow (must follow in order):
1) Clarify (interactive loop) → `/debug.clarify`
2) Evidence Trace (E2E) → `/debug.trace`
3) Cross-repo Resolution (MCP-S + Octocode) → `/debug.resolve`
4) Hypothesis Tree + Experiments → `/debug.hypothesize`
5) Fix Plan (no code yet) → `/debug.fixplan`
6) Verify (connectivity + checks) → `/debug.verify`
7) Publish (chat + file) → `/debug.publish`

Enforces:
- `.cursor/rules/debug/debug-laws.mdc`
- `.cursor/rules/debug/octocode-mandate.mdc` (if present)

Hard fails:
- publishing before verify passes
- non-local symbols without Octocode proof
- “it’s fixed” claims without verification signals (tests/tsc/lint + connected edges)

Start:
Ask: “What would you like to debug?”
Then run `/debug.clarify` until the Debug Spec is complete.
