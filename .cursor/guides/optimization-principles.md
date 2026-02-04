# Optimization Principles

Core principles for simplifying TypeScript and React code.

## 12 TypeScript Core Principles

| # | Principle | Rule |
|---|-----------|------|
| 1 | Single Responsibility | Functions do one thing. No "and" in names. |
| 2 | Clear Naming | Avoid `data`, `obj`, `handle`. Be specific. |
| 3 | Immutability | Return new values, don't mutate. |
| 4 | Guard Clauses | Early returns to flatten nesting. |
| 5 | No Flag Params | Split functions instead of boolean switches. |
| 6 | Leverage Types | Discriminated unions, exhaustive checks. |
| 7 | Use Built-ins | `.map`, `.filter`, `.reduce` over loops. |
| 8 | DRY Carefully | Abstract only after 3+ repetitions. |
| 9 | Composition | Small functions over class hierarchies. |
| 10 | Separation | Keep UI, data, logic separate. |
| 11 | Error Handling | Fail fast. Consider Result types. |
| 12 | Simple Tests | One concept per test. Table-driven. |

## TypeScript Quick Patterns

```typescript
// Guard clause - flatten nesting
if (!order) return;
if (!order.items.length) return;
// flat logic here

// Discriminated union - type-safe branching
type Result<T> = { ok: true; value: T } | { ok: false; error: Error };

// Lookup over conditionals
const handlers = { a: handleA, b: handleB };
return handlers[type]();

// Extract function - single responsibility
const total = calculateTotal(items);
```

## Type Assertion Removal

When removing unnecessary type assertions (`as Type`):

| Scenario | Action |
|----------|--------|
| `fn() as string` where `fn` returns `string` | Just remove `as string` |
| `fn() as string` where `fn` returns `string \| null` | Keep assertion OR fix with narrowing |
| `fn() as string` where `fn` returns `unknown` | Fix upstream type, not the assertion |

**Rule:** Don't replace compile-time assertions with runtime wrappers (`String()`, `Number()`).

## 10 React Principles

| # | Principle | Rule |
|---|-----------|------|
| 1 | SRP Components | Split data fetching from UI rendering. |
| 2 | State Colocation | Local state unless sharing truly needed. |
| 3 | Limit Prop Drilling | Context or composition for 3+ levels. |
| 4 | Composition | Separate components for variants, not flags. |
| 5 | Custom Hooks | Extract shared logic (fetch, subscriptions). |
| 6 | Minimal Props | Lean interfaces. Discriminated unions. |
| 7 | TypeScript Safety | Explicit types at boundaries only. |
| 8 | YAGNI/KISS | `useState` before Redux. Build for now. |
| 9 | Readability | Clear JSX over clever one-liners. |
| 10 | Testability | Error boundaries. Pure logic separation. |

## React Quick Patterns

```tsx
// Split hook + component
function useSaveUser() {
  const [saved, setSaved] = useState(false);
  const saveUser = async (data) => { await api.save(data); setSaved(true); };
  return { saveUser, saved };
}

// Local state for local concerns
const [isOpen, setOpen] = useState(false);

// Context for deep access
<CurrentUserProvider value={user}>
  <Page><UserMenu /></Page>
</CurrentUserProvider>

// Flatten conditionals
const showAdvanced = user.isAdmin && mode === 'advanced';
return <>{showAdvanced && <AdvancedOptions />}</>;

// Provider pattern with safety
export function useAuth() {
  const ctx = useContext(AuthContext);
  if (!ctx) throw new Error("useAuth must be inside AuthProvider");
  return ctx;
}
```

## React Query Principles

1. Keep query keys consistent and structured
2. Use `select` for transforming data
3. Prefer `useMutation` for side effects
4. Use `enabled` to prevent premature fetches
5. Invalidate queries after mutations

## React Hook Form Principles

1. Use `useForm` with typed schemas (Zod/Yup)
2. `watch` sparingly - it causes re-renders
3. Use `Controller` for custom components
4. Validate at the field level when possible
5. Handle form state transitions explicitly
