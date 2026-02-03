# Feature Implementation Workflow

A multi-step process for implementing new features with proper planning and verification.

## Prerequisites
- Clear understanding of the feature requirements
- Access to relevant MCPs (octocode, etc.)

## Steps

### 1. Create Spec
```
Create .cursor/kits/<kit-name>/<feature>/spec.md with:
- Intent: implement
- Requirements list
- Acceptance criteria
- Out of scope items
- Chunked tasks
```

### 2. Research Existing Patterns
```
Run /deep-search to find:
- Similar implementations in codebase
- Relevant utilities/helpers
- Patterns to follow
```

### 3. Plan Implementation
```
Enter Plan Mode (Shift+Tab):
- Review spec.md
- Create detailed implementation plan
- Identify files to modify
- Map dependencies
```

### 4. Implement in Chunks
```
For each task in spec.md:
1. Implement the change
2. Run verification (test/lint/build)
3. Commit if passing
4. Update memory.md progress
```

### 5. Verify All Acceptance Criteria
```
Run /verify or equivalent:
- All tests pass
- No lint errors
- Build succeeds
- Manual verification if needed
```

### 6. Create PR
```
Run /pr command:
- Generates PR description
- Links to spec.md
- Lists all changes
```

## Notes
- Use grind-loop hook to auto-iterate on failing tests
- Commit after each successful chunk
- Update memory.md at end of session
