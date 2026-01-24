---
description: Find similar implementations/tests and check conformance to existing patterns (Octocode + MCP-S mandatory)
globs:
alwaysApply: false
---

# /review.conform — Pattern & Structure Conformance (MANDATORY)

Goal:
Ensure the change follows the same design patterns/structure/flow used by similar features in the ecosystem.

Inputs:
- `.cursor/review/<target>/SCAN.md`

Steps:
1) Identify the "feature family" (domain + layer: UI/BFF/service/runtime/tests).
2) MCP-S: pull internal conventions/ownership hints for this family (then prove via code).
3) Octocode: find 3–7 closest “golden” examples:
   - same feature family
   - same layer
   - similar data shape/contract
   - similar tests style
4) Extract patterns:
   - folder layout and entrypoints
   - naming conventions
   - dependency usage (SDKs, services, helpers)
   - error/flag semantics (presence vs omitted)
   - test style (drivers/builders/BDD if relevant)
5) Diff your change vs patterns:
   - If diverges: create issues with severity (HIGH/MOD/LOW) + suggested fix.

Output:
Write `.cursor/review/<target>/CONFORMANCE.md`

Format:
- Golden examples (repo/path + proof snippets)
- Expected pattern summary
- Deviations list (severity + evidence + fix options)
