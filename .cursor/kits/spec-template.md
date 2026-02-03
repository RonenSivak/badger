# Spec: [Feature/Task Name]

> Create this spec before implementing any non-trivial feature. It ensures clear targets, enables TDD, and prevents scope creep.

## Intent
<!-- Choose one: understand | debug | implement | review | test | refactor -->
[intent]

## Summary
[1-2 sentence description of what we're building/fixing]

## Requirements
1. [Requirement 1]
2. [Requirement 2]
3. [Requirement 3]

## Acceptance Criteria
- [ ] [Criterion 1 - must be verifiable]
- [ ] [Criterion 2 - must be verifiable]
- [ ] [Criterion 3 - must be verifiable]

## Architecture
<!-- Describe components, data flow, key decisions -->
- **Component**: [description]
- **Data Flow**: [description]
- **Key Files**: [list target files]

## Dependencies
- [Dependency 1]: [version if relevant]
- [Dependency 2]

## Out of Scope
<!-- Explicitly list what we're NOT doing -->
- [Not doing X]
- [Deferring Y to future work]

## Tasks (Chunked)
<!-- Each task should be small and verifiable. Commit after each. -->
1. [ ] [Task 1] - verify via: [test/lint/build]
2. [ ] [Task 2] - verify via: [test/lint/build]
3. [ ] [Task 3] - verify via: [test/lint/build]
4. [ ] [Task 4] - verify via: [test/lint/build]

## Risks & Mitigations
| Risk | Mitigation |
|------|------------|
| [Risk 1] | [How to address] |

## Success Metrics
- [How we know this is done and working]

---

## Usage

1. Copy this template to `.cursor/kits/<kit-name>/<task>/spec.md`
2. Fill in all sections before implementing
3. Use Tasks section to guide incremental development
4. Check off Acceptance Criteria as verification passes
5. Reference this spec in memory.md for continuity
