# Bug Fix Workflow

A systematic approach to debugging and fixing issues.

## Prerequisites
- Bug report or reproduction steps
- Access to logs/error messages

## Steps

### 1. Reproduce the Bug
```
Confirm the bug is reproducible:
- Follow exact steps from report
- Capture error messages
- Note environment details
```

### 2. Gather Evidence
```
Run /troubleshoot or manual investigation:
- Trace request IDs in logs
- Identify failing component
- Document stack traces
```

### 3. Write Failing Test
```
Create a test that reproduces the bug:
- Test should fail initially
- Captures exact failure condition
- Commit the test
```

### 4. Identify Root Cause
```
Analyze code path:
- Use /deep-search for connectivity
- Trace data flow
- Identify incorrect behavior
```

### 5. Implement Fix
```
Make minimal change to fix:
- Single responsibility fix
- No refactoring mixed in
- Run test to confirm green
```

### 6. Verify Fix
```
Ensure fix is complete:
- Original test passes
- No regression in other tests
- Build succeeds
```

### 7. Create PR
```
Run /pr command:
- Reference bug report/ticket
- Explain root cause
- Document fix approach
```

## Notes
- Use grind-loop hook for TDD cycle
- Minimal changes only - no opportunistic refactoring
- Update memory.md with findings for future reference
