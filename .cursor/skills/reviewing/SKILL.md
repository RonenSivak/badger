---
name: reviewing
description: "Deep code review with impact sweep and pattern conformance. Use when reviewing a change, PR, or diff to identify risks, verify patterns, and assess downstream impact."
---

# Reviewing

Deep review workflow: scan → conform → impact → resolve → **verify (MANDATORY)** → publish.

## Quick Start
1. Clarify review scope and goals
2. Scan the change surface
3. Conform: match existing patterns/structure/flow
4. Impact Sweep: downstream consumers + semantic contract risks
5. Resolve with MCP-S + Octocode proof
6. Draft review packet (file-only)
7. **VERIFY (MANDATORY GATE)** — prove all claims
8. Publish (HIGH/MOD/LOW + next actions)

## Workflow Checklist
Copy and track your progress:
```
- [ ] Review scope clarified
- [ ] Change surface scanned
- [ ] Pattern conformance checked
- [ ] Impact sweep completed (consumers, contracts)
- [ ] MCP-S + Octocode proofs gathered
- [ ] Review packet drafted
- [ ] **VERIFICATION GATE PASSED** (all claims proven)
- [ ] Review published (risk level + actions)
```

## Output Format
Simple and actionable:
- **Risk Level**: HIGH / MODERATE / LOW
- **Key Concerns**: Bullet list
- **Required Changes**: What must change
- **Suggested Improvements**: Nice to have
- **Next Actions**: Specific steps

## Conformance Checks
- Does the change match existing patterns?
- Does it follow the established structure?
- Are naming conventions respected?
- Is the flow consistent with similar code?

## Impact Sweep (MANDATORY)
For every changed contract/interface:
- Who are the downstream consumers?
- Will this break existing callers?
- Are there semantic contract risks?
- Use Octocode to prove consumer connections

## Artifacts
All outputs go to `.cursor/review/<change>/`:
- `REVIEW-SPEC.md` - Scope and goals
- `CHANGE-SURFACE.md` - What changed
- `IMPACT-ANALYSIS.md` - Downstream effects
- `VALIDATION-REPORT.md` - **Proof certification (MANDATORY)**
- `REVIEW-PACKET.md` - Final review

---

## MANDATORY VERIFICATION GATE (BLOCKER)

**You CANNOT publish a review without proving your claims.**

### Impact Claim Requirements

Before claiming "This change affects X consumers", you MUST have:

1. **Consumer proof**: `repo/path:line` showing the import/usage
2. **Connection proof**: How the changed code is reached
3. **Octocode proof**: For cross-repo consumers

### Create VALIDATION-REPORT.md

```markdown
## VALIDATION-REPORT.md

### Review Claims & Proofs
| # | Claim | Proof (`repo/path:line`) | Tool Used | Retrieved This Session |
|---|-------|--------------------------|-----------|------------------------|
| 1 | "Change affects X" | `<consumer:line>` | <tool> | ✅ Yes |
| 2 | "Pattern mismatch in Y" | `<file:line>` | <tool> | ✅ Yes |

### Impact Analysis Proofs
| Changed Code | Consumer | Connection Proof | Verified |
|--------------|----------|------------------|----------|
| `A.ts:10` | `B.ts:25` | import + call | ✅ |
| `A.ts:10` | `external/C.ts` | Octocode proof | ✅ |

### Conformance Proofs
| Pattern Claim | Similar Code Reference | Verified |
|---------------|------------------------|----------|
| "Should use X pattern" | `existing/file.ts:30` | ✅ |

### Anti-Hallucination Certification
- [ ] Every impact claim backed by consumer proof from THIS session
- [ ] No pattern claim without existing code reference
- [ ] All cross-repo impacts proven via Octocode

### Certification
☐ I certify all review claims are backed by proofs retrieved this session.
```

---

## Hard-fail Conditions (INSTANT BLOCK)

Publishing is **BLOCKED** if ANY of these are true:

- ❌ Publishing without `VALIDATION-REPORT.md` completed
- ❌ **Impact claimed without consumer proof**
- ❌ **Pattern violation claimed without reference to existing pattern**
- ❌ Missing Octocode for non-local symbol impacts
- ❌ Risk level assigned without evidence
- ❌ "Breaking change" claimed without proving who breaks

---

## Detailed Guidance
- See [verify-checklist.md](../../guides/verify-checklist.md) for verification template
- See [proof-discipline.md](../../guides/proof-discipline.md) for proof format
- See [octocode-patterns.md](../../guides/octocode-patterns.md) for cross-repo resolution
