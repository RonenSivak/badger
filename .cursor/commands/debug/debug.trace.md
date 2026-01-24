---
description: Build an E2E trace map from evidence (trace/logs) or from code breadcrumbs
globs:
alwaysApply: false
---

# /debug.trace — Evidence Trace 🌐

Goal: produce `.cursor/debug/<topic>/E2E-TRACE.md`

Rules:
- Prefer evidence anchors (trace/log correlation) when available. Traces give an E2E view across services.
- If no traces/log IDs exist, start from the strongest breadcrumb in DEBUG-SPEC and trace via code.

Deliverables:
1) E2E System Map (one screen):
   Entry → transport → validation → persistence → consumer/runtime → failure boundary
2) Boundary list (each must later be proven with code):
   - network boundary
   - persistence boundary
   - render/execute boundary
   - thrown/error boundary
3) “Next resolution targets” list:
   - symbols/methods/services you must resolve cross-repo (feeds `/debug.resolve`)
