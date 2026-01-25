---
description: Clarify smart-merge intent into a Merge Spec
globs:
alwaysApply: false
---

# /smart-merge.clarify — Clarification Loop 🧩

Ask short questions until you have a complete **Merge Spec**.

Required:
- Target branch (where changes should land)
- Source (master or sibling branch) + exact ref (branch/commit range)
- Goal: “forward-port”, “sync”, “backport”, or “compose both”
- Constraints: history policy (rebase allowed?), CI requirements, rollout constraints

Produce `.cursor/smart-merge/<name>/MERGE-SPEC.md` with:

- Branches:
  - target: <branch>
  - source: <branch or commit range>
  - sibling context: <optional other branch>
- Preferred strategy:
  - merge | rebase | cherry-pick | range-diff guided
- Risk areas:
  - refactors/renames? shared packages? generated code?
- Verification:
  - commands to run (repo standard)
  - “must not break” surfaces (public APIs, configs, schema, exports)

Stop only when the spec is complete.
