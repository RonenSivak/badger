---
description: Deep review a change (clarify → scan → conform → impact → resolve → packet → verify → publish)
globs:
alwaysApply: false
---

# /deep-review — Orchestrator

Workflow:
1) Clarify (what are we reviewing + goals)
2) Scan (change surface)
3) Conform (MANDATORY: match existing patterns/structure/flow)
4) Impact Sweep (MANDATORY: downstream consumers + semantic contract risks)
5) Resolve (MCP-S + Octocode proof loop)
6) Draft packet (file-only)
7) Verify (connectivity + key consumers)
8) Publish (chat + file) — SIMPLE output (HIGH/MOD/LOW + next actions)

Enforces:
- `.cursor/rules/deep-review-laws.mdc`
- `.cursor/rules/octocode-mandate.mdc`

Delegates to:
- `/deep-review.clarify`
- `/deep-review.scan`
- `/deep-review.conform`
- `/deep-review.impact`
- `/deep-review.resolve`
- `/deep-review.packet`
- `/deep-review.verify`
- `/deep-review.publish`
