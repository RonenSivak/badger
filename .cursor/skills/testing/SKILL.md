---
name: testing
description: "Generate BDD tests using proven patterns from the ecosystem. Use when you need to add tests for a feature, following the codebase's testing stack and conventions."
---

# Testing (Testkit)

Generate BDD tests via: Clarify → Resolve → Implement → Verify → Publish.

## Quick Start
1. Clarify what to test (Test Spec)
2. Resolve testing stack + proven examples (MCP-S + Octocode)
3. Implement tests (drivers/builders aligned to examples)
4. Verify imports/calls match chosen examples
5. Publish with MCP Evidence

## Workflow Checklist
Copy and track your progress:
```
- [ ] Test spec clarified (what to test, acceptance criteria)
- [ ] Testing stack resolved (packages, versions)
- [ ] Best ecosystem examples found and proven
- [ ] Non-local symbols resolved (or NOT FOUND)
- [ ] Tests implemented (drivers/builders/specs)
- [ ] Verification passed (imports, packages, BDD structure)
- [ ] Published with MCP Evidence
```

## Clarify Phase
Ask: "What would you like to add tests for?"
Until Test Spec includes:
- Feature/component to test
- Expected behaviors (BDD scenarios)
- Edge cases to cover
- Testing stack constraints

## Resolve Phase (MANDATORY, UNLIMITED)
Resolve until:
- Testing stack + versions are proven
- Best in-ecosystem examples are found
- All non-local symbols are resolved OR marked NOT FOUND

Use MCP-S for:
- Package versions in use
- Testing patterns in codebase
- Driver/builder conventions

Use Octocode for:
- WDS testkit factories/classes
- Shared driver helpers
- Ambassador builders (if generated)

## Implement Phase
Generate tests aligned to proven examples:
- Prefer generated Ambassador builders if they exist
- Follow existing driver patterns
- Use correct testkit factories

## Verify Phase
Confirm:
- [ ] Imports match chosen examples
- [ ] Packages/versions match repo reality
- [ ] BDD structure rules satisfied
- [ ] Tests actually run (ALWAYS GREEN gate)

## ALWAYS GREEN Gate (CRITICAL)
Tests must pass before publish:
```bash
yarn test <test-file>
# OR
npm test -- <test-file>
```
If tests fail, fix them before publishing.

## Artifacts
- `MCP-EVIDENCE.md` - Queries + results
- Test files following codebase conventions

## Hard-fail Conditions
- Empty MCP Evidence
- Non-local symbols without Octocode proof
- Tests that don't pass (ALWAYS GREEN violated)
- Wrong package versions

## Detailed Guidance
- See [octocode-patterns.md](../../guides/octocode-patterns.md) for testkit resolution
