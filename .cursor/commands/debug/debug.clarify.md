---
description: Clarification loop to build DEBUG-SPEC (repeat until complete)
globs:
alwaysApply: false
---

# /debug.clarify — Clarify Loop 🧠

Goal: produce `.cursor/debug/<topic>/DEBUG-SPEC.md`

Ask iterative questions until you have:
- Symptom (exact error text / wrong behavior / perf regression)
- Where (surface + env): editor/viewer/service/cli + prod/stage/local
- When/Scope: first seen + suspect PR/commit range (if known)
- Repro OR Conditions: steps or triggering conditions
- Evidence anchors (any of):
  - trace IDs / request IDs
  - log keywords
  - feature flags/experiments/config keys
  - endpoint/RPC names
  - schema/type/field names
  - unique strings or error codes

Output: write DEBUG-SPEC with:
1) Problem statement
2) Constraints (must trace full E2E across ecosystem)
3) Starting breadcrumbs (ranked)
4) “Done =” verifiable signals (tests/tsc/lint + evidence reduced)

Stop only when DEBUG-SPEC has enough to start tracing.
