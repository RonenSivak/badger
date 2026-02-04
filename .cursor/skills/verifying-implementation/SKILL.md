---
name: verifying-implementation
description: "Verify an implementation is correct and that the story connects in code (import→usage, callsite→impl, binding→handler), including Octocode proof for cross-repo hops and running standard checks. Use before publish."
---

# Verifying Implementation

This skill is intentionally minimal. Verification guidance is **passive context**:
- [verify-checklist.md](../../guides/verify-checklist.md)
- Proof Discipline (in AGENTS.md)
- Cross-Repo Resolution / Octocode (in AGENTS.md)

Use it as a quick pointer: verify edges connect (import/call/binding), prove cross-repo hops with Octocode, run the repo’s checks, and write a validation report artifact.
