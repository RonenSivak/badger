---
description: Map the change surface from the diff and pick review breadcrumbs
globs:
alwaysApply: false
---

# /deep-review.scan — Change Surface Scan

Inputs:
- `.cursor/deep-review/<target>/REVIEW-SPEC.md`

Do:
1) List touched files grouped by package/service.
2) Identify:
   - entrypoints changed (routes/handlers/init)
   - schema/contract changes (proto/openapi/types)
   - behavior changes (logic branches, defaults)
   - risk zones (auth, validation, persistence, caching, migrations)
3) Extract **top breadcrumbs** for DFS (unique strings/type names/endpoints/config keys/errors).

Write: `.cursor/deep-review/<target>/SCAN.md` with:
- Files touched (grouped)
- Suspected E2E flow impact
- Risk hypotheses
- Breadcrumb list for DFS
