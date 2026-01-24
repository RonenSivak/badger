---
description: Enumerate downstream consumers for contract-shaped diffs (Octocode mandatory)
globs:
alwaysApply: false
---

# /deep-review.impact — Impact Sweep (MANDATORY)

Contract risks include:
- `{}` vs `undefined`/omitted vs `null`
- truthy/presence checks (`if (field)`, `in`, optional chaining patterns)
- default value shifts
- flag-gated shape changes

Rule:
Assume BREAKING until proven safe by:
- consumer verification OR
- Octocode proof that all consumers tolerate the new semantics.

Output:
- `.cursor/deep-review/<target>/CONSUMER-MATRIX.md`
