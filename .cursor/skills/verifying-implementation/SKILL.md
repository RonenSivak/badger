---
name: verifying-implementation
description: "Verify an implementation is correct and that the story connects in code (import→usage, callsite→impl, binding→handler), including Octocode proof for cross-repo hops and running standard checks. Use before publish."
---

# Verifying Implementation

This skill is intentionally minimal. Verification guidance is **passive context**:
- `@.cursor/guides/verify-checklist.md`
- `@.cursor/rules/shared/proof-discipline.mdc`
- `@.cursor/rules/shared/octocode-mandate.mdc`

Use it as a quick pointer: verify edges connect (import/call/binding), prove cross-repo hops with Octocode, run the repo’s checks, and write a validation report artifact.
