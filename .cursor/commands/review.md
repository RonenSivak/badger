---
description: Deep review a change (clarify → scan → conform → impact → resolve → packet → verify → publish)
globs:
alwaysApply: false
---

# /review — Orchestrator

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
- `.cursor/rules/review/review-laws.mdc`
- `.cursor/rules/shared/octocode-mandate.mdc`
- `.cursor/rules/shared/proof-discipline.mdc`

Delegates to:
- `/review.clarify`
- `/review.scan`
- `/review.conform`
- `/review.impact`
- `/review.resolve`
- `/review.packet`
- `/review.verify`
- `/review.publish`
