---
description: Scan code for violations, measure metrics, identify pain points
globs:
alwaysApply: false
---

# /optimize-code.analyze — Code Analysis

Scan target code against the 12 core principles. Produce `ANALYSIS-REPORT.md`.

## Input
- `OPTIMIZATION-SPEC.md` (from clarify)

## Analysis Checklist

### Metrics to Measure
- [ ] Total lines of code
- [ ] Function count
- [ ] Max function length (lines)
- [ ] Cyclomatic complexity (estimate)
- [ ] `any` type count
- [ ] Nesting depth (max levels)

### TypeScript Principle Violations to Detect

| # | Principle | What to Look For |
|---|-----------|------------------|
| 1 | Single Responsibility | Functions doing multiple things, "and" in names |
| 2 | Clear Naming | Vague names (`data`, `obj`, `handle`), acronyms |
| 3 | Immutability | Mutations, `.push()`, reassignments |
| 4 | Reduce Nesting | Deep if/else, arrowhead pattern |
| 5 | No Flag Params | Boolean parameters, mode switches |
| 6 | Leverage Types | `any`, missing discriminated unions |
| 7 | Use Built-ins | Manual loops instead of `.map`/`.filter` |
| 8 | DRY Carefully | Duplicated code blocks |
| 9 | Composition | Deep inheritance, class hierarchies |
| 10 | Separation | Mixed concerns (UI + data + logic) |
| 11 | Error Handling | Nested try/catch, swallowed errors |
| 12 | Simple Tests | (if test file exists) Multiple assertions per test |

### React-Specific Violations (for .tsx files)

| # | Principle | What to Look For |
|---|-----------|------------------|
| R1 | SRP Components | Component doing fetch + state + complex UI |
| R2 | State Colocation | Global store for local UI state |
| R3 | Prop Drilling | Props passed through 3+ levels unused |
| R4 | Conditional Bloat | Large if/else blocks in JSX |
| R5 | Hook Duplication | Same useEffect pattern in multiple components |
| R6 | Props Overload | 10+ props, many optional/related |
| R7 | Missing Types | Props typed as `any` or missing interface |
| R8 | Over-engineering | Redux for simple state, factories for one use |
| R9 | Clever JSX | Complex ternaries/logic inside JSX return |
| R10 | Missing Boundaries | No ErrorBoundary, side effects in render |

### Data Fetching Analysis

#### If React Query IS installed:
Check for these violations:

| # | Principle | What to Look For |
|---|-----------|------------------|
| Q1 | Manual fetch+useEffect | `useEffect` + `fetch` when React Query available |
| Q2 | Object query keys | Objects as query keys instead of arrays |
| Q3 | Conditional hooks | `if (x) useQuery()` instead of `enabled` option |
| Q4 | Missing invalidation | `useMutation` without `invalidateQueries`/`setQueryData` |
| Q5 | Duplicate server state | Server data stored in Redux/Zustand AND React Query |
| Q6 | Manual loading state | `useState` for loading when hook provides it |
| Q7 | Unstable query keys | Query keys that change on every render |
| Q8 | Missing staleTime | Default staleTime=0 causing excessive refetches |

#### If React Query NOT installed:
Detect patterns that WOULD benefit from React Query:

| Pattern | Benefit from RQ? | Why |
|---------|------------------|-----|
| `useEffect` + `fetch` + `useState(loading)` | Yes | Built-in loading/error states |
| Same endpoint fetched in multiple components | Yes | Automatic deduplication + caching |
| Manual cache/memoization of API responses | Yes | Built-in cache management |
| Complex error retry logic | Yes | Built-in retry with backoff |
| Polling with `setInterval` | Yes | Built-in `refetchInterval` |

**If 2+ beneficial patterns found:**
1. Note in ANALYSIS-REPORT.md under "Potential Improvements"
2. **Check React version first:**
   ```bash
   grep '"react":' package.json
   grep -A1 '"react@' yarn.lock | head -5
   ```
3. Determine compatible version:
   - React 16.x/17.x → `@tanstack/react-query@^4`
   - React 18+ → `@tanstack/react-query@^5`
4. ASK user: "Found X patterns that could benefit from React Query. Your React version is Y, so I'd install React Query vZ. Proceed?"
5. If yes: Check lockfile for existing transitive dep, install compatible version

### Form Handling Analysis

#### If React Hook Form IS installed:
Check for these violations:

| # | Principle | What to Look For |
|---|-----------|------------------|
| F1 | Controller overuse | `Controller` for plain `<input>` instead of `register()` |
| F2 | watch() abuse | `watch()` without field name (re-renders entire form) |
| F3 | Wrong validation mode | `onChange` mode on large forms (performance) |
| F4 | Missing defaultValues | `useForm` without `defaultValues` |
| F5 | undefined defaults | `undefined` as default value (controlled/uncontrolled mismatch) |
| F6 | Manual value prop | `value={x}` on registered input |
| F7 | Prop drilling | Passing `register`/`errors` through many levels |
| F8 | Manual array state | `useState` for dynamic form fields |
| F9 | Inline complex validation | Long validation rules, no schema |
| F10 | Missing types | `useForm()` without generic type |

#### If React Hook Form NOT installed:
Detect patterns that WOULD benefit from RHF:

| Pattern | Benefit from RHF? | Why |
|---------|-------------------|-----|
| Multiple `useState` for form fields | Yes | Single form state management |
| Manual `onChange` + `setState` per field | Yes | Uncontrolled inputs, fewer re-renders |
| Manual touched/dirty/error tracking | Yes | Built-in `formState` |
| Manual form validation logic | Yes | Built-in + schema validation |
| Formik with perf issues | Yes | RHF uses refs, not state |

**If forms with 3+ fields using manual state found:**
1. Note in ANALYSIS-REPORT.md under "Potential Improvements"
2. Check React version (RHF v7 works with React 16.8+)
3. ASK user: "Found X forms using manual state management. React Hook Form would reduce boilerplate and re-renders. Install it?"
4. If yes: Check lockfile, install `react-hook-form@^7`

## Output

Create `.cursor/optimize-code/<target>/ANALYSIS-REPORT.md`:

```markdown
# ANALYSIS-REPORT

## Baseline Metrics
| Metric | Value |
|--------|-------|
| Lines | X |
| Functions | X |
| Max function length | X |
| any count | X |
| Max nesting | X |

## Violations Found

### High Priority
- [ ] <violation + location + principle #>

### Medium Priority
- [ ] <violation + location + principle #>

### Low Priority
- [ ] <violation + location + principle #>

## Pain Points
1. <description>
2. <description>

## Quick Wins Identified
- <quick fix that can be done immediately>
```

## Gate
- MUST identify at least one pain point OR explicitly state "No issues found - code follows principles"

## Next Step
When complete, instruct: "Run `/optimize-code.plan`."
