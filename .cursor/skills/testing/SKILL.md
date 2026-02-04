---
name: testing
description: "Generate BDD tests using proven patterns from the ecosystem. Use when you need to add tests for a feature, following the codebase's testing stack and conventions."
---

# Testing (Testkit)

Generate BDD tests via: Clarify → **Discover** → Resolve → Implement → Verify → Publish.

## Quick Start
1. Clarify what to test (Test Spec)
2. **Discover existing test patterns in the repo FIRST**
3. Resolve only if discovery insufficient (MCP-S + Octocode)
4. Implement tests (imitating discovered patterns)
5. Verify imports/calls match chosen examples
6. Publish with evidence

## Workflow Checklist
Copy and track your progress:
```
- [ ] Test spec clarified (what to test, acceptance criteria)
- [ ] DISCOVERY: Repo scanned for existing test patterns
- [ ] DISCOVERY: Testing stack identified from repo (or NOT FOUND)
- [ ] DISCOVERY: Exemplary test files found to imitate (or NOT FOUND)
- [ ] Testing stack resolved (from discovery OR MCP-S/Octocode)
- [ ] Best examples proven (local OR ecosystem)
- [ ] Non-local symbols resolved (or NOT FOUND)
- [ ] Tests implemented (imitating discovered patterns)
- [ ] Verification passed (imports, packages, BDD structure)
- [ ] Published with evidence
```

## Clarify Phase
Ask: "What would you like to add tests for?"
Until Test Spec includes:
- Feature/component to test
- Expected behaviors (BDD scenarios)
- Edge cases to cover
- Testing stack constraints (if any)

## Discovery Phase (MANDATORY FIRST STEP)

**Before any external resolution, scan the repository for existing test patterns.**

### Step 1: Find Test Files
```bash
# Find all test files in the repo
find . -type f \( -name "*.spec.ts" -o -name "*.spec.tsx" -o -name "*.test.ts" -o -name "*.test.tsx" -o -name "*.spec.js" -o -name "*.test.js" \) | head -30
```

Or use tools:
- `localSearchCode` with patterns: `describe(`, `it(`, `test(`, `expect(`
- `localFindFiles` with name patterns: `*.spec.*`, `*.test.*`

### Step 2: Identify Testing Stack
Look for in `package.json` or config files:
- **Framework**: Jest, Vitest, Mocha, Jasmine, specs2
- **Assertion library**: expect, chai, should
- **Test utilities**: Testing Library, Enzyme, driver patterns
- **Mocking**: jest.mock, vi.mock, sinon

### Step 3: Find Exemplary Tests
Prioritize tests that are:
1. **Near your target** — Same package/module as what you're testing
2. **Similar type** — If testing a React component, find component tests; if testing a service, find service tests
3. **Well-structured** — Clear BDD structure, good coverage

### Step 4: Extract Patterns to Imitate
From discovered tests, note:
- File naming convention (`*.spec.ts` vs `*.test.ts`)
- Directory structure (`__tests__/` vs co-located)
- Import patterns (what's imported, from where)
- Describe/it structure and naming style
- Setup/teardown patterns (beforeEach, afterEach)
- Mock/driver patterns in use
- Assertion style

### Discovery Output
Document findings in `DISCOVERY.md`:
```markdown
## Testing Stack
- Framework: [jest/vitest/mocha/etc]
- Utilities: [testing-library/enzyme/custom drivers/etc]
- File pattern: [*.spec.ts / *.test.ts / etc]
- Location: [__tests__/ / co-located / etc]

## Exemplary Tests Found
1. `path/to/example.spec.ts` — Why it's a good example
2. `path/to/another.spec.ts` — What patterns to imitate

## Patterns to Imitate
- Import style: [example]
- Describe structure: [example]
- Setup pattern: [example]
- Mock/driver pattern: [example]
```

### Discovery Decision Gate
| Discovery Result | Next Action |
|------------------|-------------|
| Patterns found + clear stack | **Skip Resolve**, proceed to Implement using discovered patterns |
| Partial patterns (unclear) | Resolve Phase to fill gaps |
| No patterns found | Full Resolve Phase (MCP-S + Octocode) |

## Resolve Phase (ONLY IF DISCOVERY INSUFFICIENT)
Resolve only when discovery didn't yield:
- Clear testing stack + versions
- Exemplary patterns to imitate
- Non-local symbol definitions

Use MCP-S for:
- Package versions in use
- Testing patterns in codebase
- Driver/builder conventions

Use Octocode for:
- WDS testkit factories/classes
- Shared driver helpers
- Ambassador builders (if generated)

## Implement Phase
Generate tests **imitating discovered patterns**:
- Match file naming convention from discovery
- Follow import patterns from exemplary tests
- Use same describe/it structure
- Apply same setup/teardown patterns
- Use discovered mock/driver patterns

**Critical**: The new test should look like it belongs with the existing tests.

## Verify Phase
Confirm:
- [ ] File naming matches repo convention
- [ ] Imports match discovered examples
- [ ] Structure matches repo patterns
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
- `DISCOVERY.md` — Local patterns found
- `MCP-EVIDENCE.md` — External queries + results (if Resolve was needed)
- Test files following discovered conventions

## Hard-fail Conditions
- Skipping Discovery phase
- Tests that don't match repo conventions when patterns exist
- Empty Discovery without documented search effort
- Non-local symbols without Octocode proof
- Tests that don't pass (ALWAYS GREEN violated)
- Wrong package versions

## Detailed Guidance
- See [octocode-patterns.md](../../guides/octocode-patterns.md) for testkit resolution
