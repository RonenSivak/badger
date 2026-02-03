---
description: Shared clarification loop patterns for Badger kits (Spec-first, persist artifacts)
globs:
alwaysApply: false
---

# Clarify Patterns (Shared)

Badger workflows require a **Spec** before any non-trivial execution.

## What a complete Spec contains
- **Intent**: understand | debug | implement | review | test | merge | other
- **Breadcrumbs** (1–3): file paths, symbols, URLs, error strings, PR link, request ID
- **Boundaries**: where the flow must cross (network/persistence/render/throw)
- **Scope**: what’s in / what’s out
- **Success criteria**: what “done” means

## Clarify loop discipline
- Keep asking until the Spec is explicit enough to plan + verify.
- Prefer **concrete anchors** (exact symbol names, exact strings, exact paths).
- If the work is cross-repo or includes SDKs, explicitly capture:
  - **non-local symbols list**
  - **SDK signals** (`@wix/ambassador-*`, `/rpc`, `/types`, `ctx.ambassador.request`)

## Minimal Spec template (copy into the kit’s spec artifact)
```markdown
# Spec

## Intent
- <intent>

## Breadcrumbs
- <breadcrumb 1>
- <breadcrumb 2>
- <breadcrumb 3>

## Boundaries
- [ ] network
- [ ] persistence
- [ ] render
- [ ] throw

## Scope
- In:
  - <...>
- Out:
  - <...>

## Success criteria
- <...>
```

