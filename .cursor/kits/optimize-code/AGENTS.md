# optimize-code Kit - Agent Instructions

IMPORTANT: Prefer retrieval-led reasoning. Analyze existing code patterns before optimizing.

## Commands
```bash
/optimize-code               # Orchestrator
/optimize-code.clarify      # Gather scope + constraints
/optimize-code.analyze      # Profile and identify bottlenecks
/optimize-code.plan         # Create optimization strategy
/optimize-code.execute      # Apply optimizations
/optimize-code.verify       # Benchmark + regression test
/optimize-code.publish      # Summary with metrics
```

## Code Style
- TypeScript strict mode
- Functional React with hooks
- Prefer pure functions
- Minimize re-renders (useMemo, useCallback)

## Optimization Patterns

### ✅ Prefer
- `useMemo` for expensive calculations
- `useCallback` for stable references
- Lazy loading for large components
- Virtual lists for long data

### ⚠️ Measure First
- Premature optimization
- Adding complexity for marginal gains

### 🚫 Avoid
- Breaking existing functionality
- Removing type safety
- Micro-optimizations without profiling

## Boundaries

### ✅ Always
- Profile before optimizing
- Run tests after changes
- Document performance gains

### ⚠️ Ask First
- Changing public APIs
- Adding new dependencies
- Architectural changes

### 🚫 Never
- Skip verification
- Optimize without metrics
- Break existing tests

## Verification
- [ ] All tests pass
- [ ] No type errors
- [ ] Performance metrics improved
- [ ] No regression in functionality
