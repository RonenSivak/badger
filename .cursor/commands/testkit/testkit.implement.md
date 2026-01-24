---
description: Implement BDD tests (plain-English specs) using drivers + builders + WDS testkits (DRY + mandatory MCP proof)
globs:
alwaysApply: false
---

# /testkit.implement — Implement 🧪

Inputs (must read):
- `.cursor/testkit/<feature>/TEST-SPEC.md`
- `.cursor/testkit/<feature>/EXAMPLES.md`
- `.cursor/testkit/<feature>/MCP-EVIDENCE.md`
- `.cursor/testkit/<feature>/AMBASSADOR-BUILDERS.md` (if exists)

## Hard Rules
- Specs are plain-English:
  - specs may only call: `driver.given.*`, `driver.when.*`, `driver.get.*` + `expect(...)`
  - NO: `querySelector`, `baseElement`, `container`, DOM traversal, wrapper plumbing in specs
- Driver pattern only: namespaced `given/when/get`
- WDS testkits only for UI interaction (no RTL event firing)
- Builders only (no inline object literals)
- Comments forbidden in spec/driver/builder files
- Table tests: `it.each([{...}])`
- Lint + typecheck must pass (enforced in verify)

## Folder conventions (MANDATORY)
Pick conventions from the best proven example in `EXAMPLES.md` and follow it exactly:
- Drivers: `test/drivers/` (or the example’s canonical driver folder)
- Builders: `test/builders/` (or the example’s canonical builder folder)
- Specs: colocated with the component or in the example’s canonical tests folder

## Ambassador Builders Preference (Mandatory)
If `AMBASSADOR-BUILDERS.md` proves builders exist:
- Use them as the base builders.
- If missing fields:
  - wrap them with a tiny local adapter in `test/builders/` (no forked copies).

## Implementation Steps
1) Mirror the structure of the strongest ecosystem example (from `EXAMPLES.md`):
   - same folder naming
   - same import style
   - same driver shape
2) Build drivers that expose behavior-focused queries:
   - `get.*` returns:
     - a WDS testkit (preferred), OR
     - a small “query object” with `exists()/text()/href()` methods (so specs don’t touch DOM)
   - If you need data-hook checks, put them behind `driver.get.dataHook.*()` (no DOM usage in spec)
3) Builders:
   - create under `test/builders/`
   - expose `aXxx()` / `aXxxWithDefaults()` style factories returning `{ build(): T }`
4) Specs:
   - read like a script:
     - `given` setup
     - `when` render/act
     - `get` values
     - `expect` assertions
5) DRY pass:
   - repeated init → `setup()`
   - repeated driver utils → `BaseDriver`

Output:
- create/modify test files in repo
- write `.cursor/testkit/<feature>/IMPLEMENTATION-NOTES.md` (no comments, just bullets)
