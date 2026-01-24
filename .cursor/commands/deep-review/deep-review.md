---
description: Deep review a change (clarify → scan → impact-sweep → resolve → packet → verify → publish)
globs:
alwaysApply: false
---

# /deep-review — Orchestrator

Workflow:
1) Clarify
2) Scan (change surface)
3) Impact Sweep (MANDATORY cross-repo consumer discovery)
4) Resolve (MCP-S + Octocode proof loop)
5) Draft packet (file-only)
6) Verify (connectivity + build/lint/tsc/tests incl. key consumers)
7) Publish (chat + file)

Enforces:
- `.cursor/rules/deep-review-laws.mdc`
- `.cursor/rules/octocode-mandate.mdc`

Delegates to:
- `/deep-review.clarify`
- `/deep-review.scan`
- `/deep-review.impact`
- `/deep-review.resolve`
- `/deep-review.packet`
- `/deep-review.verify`
- `/deep-review.publish`

Hard-fail:
- Impact Sweep not produced
- Any contract-shaped change without Consumer Matrix + Octocode evidence
- Verify not PASS
