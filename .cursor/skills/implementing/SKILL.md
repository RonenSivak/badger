---
name: implementing
description: "Implement changes using deep-search artifacts as the source of truth. Use when you have a deep-search report and need to implement a feature, fix, or clone safely with proof and validation."
---

# Implementing

Use an existing deep-search run as the source of truth to implement changes with proof + validation.

## Prerequisites
A deep-search folder must exist: `.cursor/deep-search/<feature>/`
- `ARCHITECTURE-REPORT.md` (or draft)
- `trace-ledger.md`
- Change surface identified

## Quick Start
1. Clarify the implementation request
2. Load deep-search artifacts into context
3. Write an implementation plan with verifiable gates
4. Execute in small diffs
5. **VERIFY (MANDATORY GATE)** — complete proof certification
6. Publish PR-ready summary (only after verification passes)

## Workflow Checklist
Copy and track your progress:
```
- [ ] Implementation spec clarified
- [ ] Deep-search artifacts loaded
- [ ] Plan written with verification gates
- [ ] Implementation executed (small diffs)
- [ ] **VERIFICATION GATE PASSED** (VALIDATION-REPORT.md complete)
- [ ] PR summary published
```

## Step Details

### 1. Clarify
Ask: "What would you like to implement, based on an existing deep-search report?"
Until Implementation Spec is complete (scope, acceptance criteria, boundaries).

### 2. Load
Create working artifacts:
- `.cursor/implement/<task>/IMPLEMENTATION-SPEC.md`
- `.cursor/implement/<task>/SCOPE.md`

### 3. Plan
Create plan with:
- Verification commands
- Acceptance criteria
- Files to modify
- Edge cases
Output: `.cursor/implement/<task>/PLAN.md`

### 4. Execute
- Keep diffs small
- Update plan if reality changes
- Use Octocode for non-local symbols

### 5. Verify (MANDATORY GATE)
**You CANNOT publish without completing verification.**

Run verification gates and create `VALIDATION-REPORT.md`:

```markdown
## VALIDATION-REPORT.md

### Implementation Claims & Proofs
| # | What I Changed | Proof (`file:line`) | Tool Used | Retrieved This Session |
|---|---------------|---------------------|-----------|------------------------|
| 1 | <change> | `<file:line>` | Read/StrReplace | ✅ Yes |

### Edge Connectivity (new/modified hops)
| Edge | From | To | Proof Type | Verified |
|------|------|----|------------|----------|
| import | `A.ts:5` | `B.ts` | import statement | ✅ |
| call | `A.ts:23` | `B.ts:10` | function call | ✅ |

### Repo Checks
- [ ] TypeScript: exit code ___ (output: ___)
- [ ] Lint: exit code ___ (output: ___)
- [ ] Tests: ___ passed / ___ failed

### Anti-Hallucination Certification
- [ ] Every proof was retrieved in THIS session
- [ ] No code was written based on memory/assumption
- [ ] All edge connections verified (import→usage, call→impl)

### Certification
☐ I certify all changes are backed by proofs retrieved this session.
```

### 6. Publish
- Print PR-ready summary in chat
- Write `.cursor/implement/<task>/PR-SUMMARY.md`
- Update deep-search artifacts if needed

---

## Hard-fail Conditions (INSTANT BLOCK)

Publishing is **BLOCKED** if ANY of these are true:

- ❌ Publishing without `VALIDATION-REPORT.md` completed
- ❌ **Any claim without proof citation**
- ❌ **Code written based on memory** (not verified this session)
- ❌ Non-local symbols without Octocode proof
- ❌ Implementing without loading deep-search context
- ❌ TypeScript/lint/tests failing without documented reason
- ❌ Edge connectivity claimed without proof

---

## Detailed Guidance
- See [verify-checklist.md](../../guides/verify-checklist.md) for verification template
- See [proof-discipline.md](../../guides/proof-discipline.md) for proof format
- See [octocode-patterns.md](../../guides/octocode-patterns.md) for cross-repo resolution
