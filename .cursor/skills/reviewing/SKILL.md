---
name: reviewing
description: "Deep code review with impact sweep and pattern conformance. Use when reviewing a change, PR, or diff to identify risks, verify patterns, and assess downstream impact."
---

# Reviewing

Deep review workflow: scan → conform → impact → resolve → verify → publish.

## Quick Start
1. Clarify review scope and goals
2. Scan the change surface
3. Conform: match existing patterns/structure/flow
4. Impact Sweep: downstream consumers + semantic contract risks
5. Resolve with MCP-S + Octocode proof
6. Draft review packet (file-only)
7. Verify connectivity + key consumers
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
- [ ] Verification passed
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
- `REVIEW-PACKET.md` - Final review

## Hard-fail Conditions
- Publishing without verification
- Impact claims without consumer proof
- Missing Octocode for non-local symbols

## Detailed Guidance
- See [verify-checklist.md](../../guides/verify-checklist.md) for verification
- See [octocode-patterns.md](../../guides/octocode-patterns.md) for cross-repo resolution
