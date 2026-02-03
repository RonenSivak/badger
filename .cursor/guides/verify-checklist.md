---
description: Shared verification checklist (connectivity proofs + standard repo checks) used before publish
globs:
alwaysApply: false
---

# Verify Checklist (Shared)

Goal: verify correctness **and** prove the story connects in code.

## Mandatory references
- `@.cursor/rules/shared/proof-discipline.mdc`
- `@.cursor/rules/shared/octocode-mandate.mdc`

## Edge connectivity checks (required)
For every new/edited hop, show evidence:
- import → usage
- call site → implementation
- binding → handler (routing/RPC/events)

For cross-repo hops:
- `/octocode/research` proof (definition + implementation + boundary)

## Standard repo checks (run what’s relevant)
- build / typecheck
- lint
- tests aligned to acceptance criteria (and adjacent regression risks)

## Output expectation
Write a `VALIDATION-REPORT.md` (kit may name it differently) containing:
- passed checks
- failed checks (with error output)
- broken edges list (what’s missing evidence)
- remaining NOT FOUND items (with searches + scope)

