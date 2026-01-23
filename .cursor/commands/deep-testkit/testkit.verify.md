---
description: Verify BDD compliance + plain-English specs + DRY extraction + correctness + lint/tsc/test pass before publish
globs:
alwaysApply: false
---

# /testkit.verify — Validate ✅

Inputs:
- `.cursor/testkit/<feature>/MCP-EVIDENCE.md`
- `.cursor/testkit/<feature>/EXAMPLES.md`
- repo test files created/edited

## Gates (hard)
- MCP Evidence must exist and be non-empty
- Non-local symbols must have Octocode proof in MCP Evidence
- Tests must follow proven stack imports (no guessing)
- Specs must be plain-English (no DOM plumbing)
- Lint + typecheck + tests must pass (or become NOT RUN + reason)

## Verify Checklist
### 1) Imports / stack correctness
- WDS testkit imports match the proven examples
- No forbidden RTL event APIs
- If ambassador builders were proven → confirm they’re used

### 2) Spec readability enforcement
Fail if any `.spec.*` contains:
- `querySelector`
- `baseElement` / `container` / `wrapper`
- direct DOM traversal
Specs should only use driver APIs + expect.

### 3) Driver API enforcement
- Driver must expose:
  - `given.*`
  - `when.*`
  - `get.*`
- Fail if driver uses flat methods (`getFoo()` / `clickBar()`)
- Fail if driver exposes `get.baseElement()` or wrapper access intended for specs

### 4) Comments ban
Fail if spec/driver/builder contains `//` or `/**` blocks.
(Use naming; no commentary.)

### 5) Builders folder enforcement
- Builders must exist under the canonical folder chosen from examples:
  - `test/builders/` (or equivalent proven folder)
- Fail if builders are inline in driver/spec

### 6) DRY enforcement
- If 3+ tests repeat init/render/stubs → require `setup()`
- If 2+ drivers share helper logic → require `BaseDriver` or shared helpers

### 7) Run the real checks (MANDATORY)
Run (from the relevant package/workspace root):
- lint (repo standard)
- typecheck/tsc (repo standard)
- test (jest/vitest etc.)

Write the exact commands you ran + results to:
- `.cursor/testkit/<feature>/VALIDATION-REPORT.md`

If a command cannot be run:
- mark it `NOT RUN`
- include reason
- include what should be run by the developer

Write:
- `.cursor/testkit/<feature>/VALIDATION-REPORT.md`
(include PASS/FAIL + violations + required refactors + command outputs)
