---
description: Proof-first discipline — mandatory verification with evidence format and anti-hallucination gates
globs:
alwaysApply: false
---

# Proof Discipline (Guide)

**Goal**: Every claim must be backed by verifiable evidence. No exceptions.

## Core Principle

> **If you can't cite it, you can't claim it.**

## Proof Format (REQUIRED)

Every non-trivial claim MUST include:

```
**Proof**: `<repo>/<path>:<startLine>-<endLine>`
```<snippet>
<relevant code or text>
```
```

### Example (CORRECT)
> The `handleSubmit` function validates input before saving.
>
> **Proof**: `wix-private/editor-platform/packages/sdk/src/form.ts:45-52`
> ```typescript
> function handleSubmit(data: FormData) {
>   if (!validateInput(data)) {
>     throw new ValidationError('Invalid input');
>   }
>   return save(data);
> }
> ```

### Example (WRONG — hallucinated)
> The `handleSubmit` function validates input before saving.
> *(No proof provided)*

## Hypothesis Discipline

If you haven't verified via tool/code proof:

1. **Mark as hypothesis**: `⚠️ HYPOTHESIS (unverified): <theory>`
2. **State verification needed**: "Requires: [code search | Slack | runtime test]"
3. **NEVER present hypothesis as conclusion**

### Pattern

```
⚠️ HYPOTHESIS (unverified): The error might be caused by missing null check.
Requires: [grep for null checks in handler | runtime test with null input]
```

After verification:
```
✅ CONFIRMED: Missing null check causes crash.
Proof: `repo/path:line` → <snippet>
```

OR:
```
❌ REFUTED: Null check exists at line 42, issue is elsewhere.
Proof: `repo/path:42` → <snippet showing null check>
```

## Connectivity Proof

When asserting an E2E hop, prove the **edge connects**:

| Assertion | Required Proof |
|-----------|----------------|
| "A imports B" | Show import statement + usage |
| "A calls B" | Show call site + function signature |
| "Route X → Handler Y" | Show binding config + handler impl |
| "Cross-repo hop" | Octocode: definition + implementation + boundary |

### Anti-pattern
> "File A uses File B" → ❌ (no proof of actual connection)

### Correct pattern
> "File A imports and calls File B"
> **Proof (import)**: `repo/A.ts:5` → `import { foo } from './B'`
> **Proof (usage)**: `repo/A.ts:23` → `foo(data)` → calls `repo/B.ts:10-15`

## NOT FOUND Protocol

If you cannot prove something:

```
**NOT FOUND**: <what was sought>
**Searches tried**:
- Pattern: `<query 1>` → Scope: <files/repos> → 0 results
- Pattern: `<query 2>` → Scope: <files/repos> → 0 results  
- Pattern: `<query 3>` → Scope: <files/repos> → 0 results
**Conclusion**: Symbol/connection not found after 3+ variations
```

**NEVER mark NOT FOUND without trying 3+ query variations.**

## "Exists" is NOT Proof

| Claim | Why it's insufficient |
|-------|----------------------|
| "File exists" | ≠ Edge is connected |
| "Name matches" | ≠ Same symbol/contract |
| "Pattern similar" | ≠ Same root cause |
| "I saw it before" | ≠ Current state verified |

## Mandatory Self-Certification (BLOCKER)

Before publishing ANY output, complete this certification:

```markdown
## Proof Certification (REQUIRED)

| # | Claim | Proof Location | Verified |
|---|-------|----------------|----------|
| 1 | <claim> | `repo/path:lines` | ✅ |
| 2 | <claim> | `repo/path:lines` | ✅ |
| ... | ... | ... | ... |

### Edge Connectivity
- [ ] Every import→usage proven
- [ ] Every call→impl proven  
- [ ] Every cross-repo hop has Octocode proof

### Anti-Hallucination Check
- [ ] No claim without proof citation
- [ ] All hypotheses marked as such
- [ ] NOT FOUND items have 3+ search attempts documented

### Certification
I certify that all claims above are backed by verifiable proof that I retrieved in this session.
```

**If you cannot fill this certification, DO NOT PUBLISH.**
