---
description: Identify contract-shaped changes + enumerate downstream consumers cross-repo (Octocode mandatory)
globs:
alwaysApply: false
---

# /deep-review.impact — Impact Sweep (MANDATORY)

Goal:
Catch semantic contract breaks (e.g. `{}` vs `undefined`, presence checks, default changes, flag gating).

Inputs:
- `.cursor/deep-review/<target>/SCAN.md`

A) Detect contract-shaped diffs (from the change)
Flag any of these as "Contract Risk":
- value semantics: `undefined` ↔ `{}` ↔ `null` ↔ `[]` ↔ `""`
- field presence toggles (added/removed/conditionally included)
- experiment/feature-flag gating of response shape
- default value changes
- enum expansion/renames
- schema/IDL changes (proto/openapi/graphql/types)

B) Consumer Enumeration (Octocode MANDATORY)
For each Contract Risk item:
1) derive search keys:
   - field name + alt casing
   - type name
   - serializer output key
   - known feature flag name
2) run `/octocode/research` to find ALL consumers:
   - readers (presence checks, destructuring, truthy checks)
   - validators
   - mappers/normalizers
   - caches/persistence adapters

C) Build a Consumer Matrix
Write: `.cursor/deep-review/<target>/CONSUMER-MATRIX.md`

Table:
| Contract item | Consumer repo/package | How it interprets | Proof (repo/path:lines) | Risk | Needed action |
|---|---|---|---|---|---|

D) Verification targets list
Append to Review Spec:
- “Must run validation on these consumers” (by repo/package)
If cannot run: mark NOT FOUND with scope and still include Octocode proofs.

Rule:
If any consumer does `if (field) { ... }` or checks presence, `{}` vs `undefined` MUST be treated as a breaking semantic change until proven safe.
