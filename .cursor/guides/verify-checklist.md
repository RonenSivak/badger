---
description: Shared verification checklist (connectivity proofs + standard repo checks) used before publish — MANDATORY BLOCKER
globs:
alwaysApply: false
---

# Verify Checklist (Shared) — MANDATORY GATE

**This is a BLOCKER, not optional.** You CANNOT publish without completing verification.

## STOP — Pre-Verification Check

Before running verification, ask yourself:
1. Have I made any claims in my output?
2. Can I cite proof (repo/path:line) for EACH claim?
3. Have I actually retrieved this proof in THIS session (not from memory)?

**If NO to any → go back and gather proof first.**

## Core Principles
- **Proof-first**: Every claim needs `repo/path:line` + snippet
- **No hallucination**: If you didn't retrieve it, you can't cite it
- **Connectivity**: Prove edges connect (not just "exists")

See [proof-discipline.md](./proof-discipline.md) for detailed patterns.

## Edge Connectivity Checks (REQUIRED)

For every asserted hop, show evidence:

| Hop Type | Required Proof |
|----------|----------------|
| import → usage | Import line + usage line in same file |
| call → impl | Call site + function definition |
| binding → handler | Route/config + handler impl |
| cross-repo | Octocode: definition + implementation + boundary |

### Verification Format
```
**Hop**: A → B
**Proof (import)**: `repo/A.ts:5` → `import { foo } from './B'`
**Proof (call)**: `repo/A.ts:23` → `foo(data)`
**Proof (impl)**: `repo/B.ts:10-15` → `export function foo(data) { ... }`
```

## Standard Repo Checks (run what's relevant)
- build / typecheck → capture exit code
- lint → capture exit code  
- tests → capture pass/fail count

## Mandatory Proof Certification (BLOCKER)

**You MUST complete this before publishing:**

```markdown
## VALIDATION-REPORT.md

### Claims & Proofs
| # | Claim | Proof (`repo/path:line`) | Retrieved This Session |
|---|-------|--------------------------|------------------------|
| 1 | <claim> | `<proof>` | ✅ Yes |
| 2 | <claim> | `<proof>` | ✅ Yes |

### Edge Connectivity
| Edge | From | To | Proof |
|------|------|----|-------|
| import | `A.ts:5` | `B.ts` | ✅ |
| call | `A.ts:23` | `B.ts:10` | ✅ |

### Repo Checks
- [ ] TypeScript: `exit 0` / `exit 1` (actual output: ___)
- [ ] Lint: `exit 0` / `exit 1` (actual output: ___)
- [ ] Tests: ___ passed / ___ failed

### NOT FOUND Items
| Item | Searches Tried (3+ required) | Conclusion |
|------|------------------------------|------------|
| <item> | 1. `query` in `scope`, 2. `query` in `scope`, 3. `query` in `scope` | NOT FOUND |

### Anti-Hallucination Self-Check
- [ ] Every claim has a proof citation from THIS session
- [ ] No proof was cited from memory/training data
- [ ] All hypotheses are marked as `⚠️ HYPOTHESIS`
- [ ] NOT FOUND items have 3+ documented search attempts

### Certification
☐ I certify ALL proofs were retrieved in this session and are verifiable.
```

**If certification incomplete → DO NOT PUBLISH. Go back and gather missing proofs.**

## Hard-Fail Conditions

Publishing is BLOCKED if:
- ❌ Any claim without proof citation
- ❌ Any proof cited from memory (not retrieved this session)
- ❌ Hypothesis presented as conclusion
- ❌ NOT FOUND without 3+ search attempts documented
- ❌ Edge asserted without connectivity proof
- ❌ Certification checklist incomplete
