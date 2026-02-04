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

## ALWAYS Use Clickable Options (AskQuestion Tool)

When presenting choices, **ALWAYS** use the AskQuestion tool for clickable buttons.

### Single-Select (default)
User picks ONE option:
```
AskQuestion:
  title: "Clarify your request"
  questions:
    - id: "intent"
      prompt: "What's your goal?"
      options:
        - { id: "understand", label: "Understand how it works" }
        - { id: "debug", label: "Debug an issue" }
        - { id: "implement", label: "Implement a change" }
        - { id: "other", label: "Other — I'll explain" }
```

### Multi-Select (allow_multiple: true)
User can pick MULTIPLE options:
```
AskQuestion:
  title: "Define boundaries"
  questions:
    - id: "boundaries"
      prompt: "Which boundaries should we check? (select all that apply)"
      allow_multiple: true
      options:
        - { id: "network", label: "Network calls (API, fetch)" }
        - { id: "persistence", label: "Database/storage" }
        - { id: "render", label: "UI rendering" }
        - { id: "errors", label: "Error handling/throwing" }
    - id: "sdk_types"
      prompt: "Which SDK types are involved? (select all)"
      allow_multiple: true
      options:
        - { id: "ambassador", label: "@wix/ambassador-*" }
        - { id: "rpc", label: "RPC types (/rpc, /types)" }
        - { id: "platform", label: "Platform services" }
        - { id: "none", label: "No SDKs" }
```

### When to use each

| Use Case | Type | Example |
|----------|------|---------|
| Intent selection | Single | understand / debug / implement |
| Scope selection | Single | file / package / repo |
| Boundaries | **Multi** | network + persistence + render |
| SDK types | **Multi** | ambassador + rpc |
| Confirmation | Single | yes / no |
| Strategy | Single | approach A / approach B |
| Features to include | **Multi** | auth + logging + caching |

**Why clickable options:**
- Faster than typing
- Reduces ambiguity
- Guides user through decision points
- Multi-select captures complex requirements in one question

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

