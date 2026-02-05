---
name: deep-searching
description: "E2E architecture forensics with cross-repo resolution. Use when you need to understand how a feature works end-to-end, trace data flows, find all connected code, or debug production issues."
---

# Deep Searching

Produce a provable, cross-repo E2E architecture report with **mandatory verification before publish**.

## Quick Start
1. Clarify the search spec (use clickable options below)
2. Plan the resolution approach
3. Execute deep research with MCP-S + Octocode
4. Draft the report (file-only)
5. **VERIFY (MANDATORY GATE)** — complete proof certification
6. Publish final report (only after verification passes)

## Clarify (ALWAYS use AskQuestion tool)
Start by asking with clickable options:
```
AskQuestion:
  title: "Deep Search Setup"
  questions:
    - id: "intent"
      prompt: "What's your goal?"
      options:
        - { id: "understand", label: "Understand how it works E2E" }
        - { id: "debug", label: "Debug an issue" }
        - { id: "clone", label: "Clone/add similar feature" }
    - id: "scope"
      prompt: "What's the scope?"
      options:
        - { id: "single_repo", label: "Single repository" }
        - { id: "cross_repo", label: "Cross-repo (uses external packages)" }
        - { id: "sdk", label: "Involves SDKs (@wix/ambassador-*, etc.)" }
    - id: "boundaries"
      prompt: "Which boundaries matter? (select all that apply)"
      allow_multiple: true
      options:
        - { id: "network", label: "Network calls (API, fetch, RPC)" }
        - { id: "persistence", label: "Database/storage" }
        - { id: "render", label: "UI rendering" }
        - { id: "errors", label: "Error handling/throwing" }
```
Then gather breadcrumbs (file paths, symbols, URLs, error strings).

## Workflow Checklist
Copy and track your progress:
```
- [ ] Search spec defined (feature, intent, breadcrumbs, boundaries)
- [ ] Plan written (.cursor/plans/deep-search.<feature>.md)
- [ ] MCP-S context gathered (docs, Slack, Jira, DevEx)
- [ ] Octocode proofs collected (def + impl + boundary)
- [ ] Draft report written (ARCHITECTURE-REPORT.draft.md)
- [ ] **VERIFICATION GATE PASSED** (VALIDATION-REPORT.md complete)
- [ ] Final report published (ARCHITECTURE-REPORT.md)
```

## Intent Types

| Intent | Focus |
|--------|-------|
| **E2E understand** | Full data flow, all hops |
| **Debug** | Slack/DevEx first, then code proof |
| **Clone/add** | Pattern extraction + change surface |

## Debug Intent (CRITICAL)
If debugging, search Slack FIRST, then verify with DevEx:
1. `slack__search-messages` for prior discussions
2. `search_projects` / `get_project` to check DevEx availability
3. `get_rollout_history` / `where_is_my_commit` for deployment state
4. If DevEx unavailable → use AskQuestion for user confirmation

## 4 Mandatory Sources (ALWAYS Search ALL)

For every major feature/service/SDK, **ALWAYS search ALL 4**:

```
- [ ] Slack: `slack__search-messages` (decisions, discussions, debugging threads)
- [ ] Jira: `jira__get-issues` (requirements, acceptance criteria, bugs)
- [ ] Docs: `docs-schema__search_docs` (architecture, design docs)
- [ ] wix-private/*: Octocode `githubSearchCode` (implementation, SDK sources)
```

**Plus DevEx** for ownership: `code_owners_for_path`, `get_project`, `get_build`, `release_notes`

**Rules:**
- Do NOT skip any source — search all 4 even if you think you found the answer
- If not found → expand search (synonyms, older date ranges) before marking NOT FOUND
- Take time to deeply search — try 3-5 query variations per source
- Cross-reference: Slack mentions Jira ticket? → fetch it. Docs mention repo? → search it.

See [internal-knowledge-search.md](../../guides/internal-knowledge-search.md) for complete protocol.

## SDK Generation Chain
If `@wix/ambassador-*` or generated SDK appears, resolve:
- Source IDL (proto/openapi/graphql)
- Generator trigger/config
- Runtime transport (auth/baseUrl/retries)
- Types package proof

## Artifacts
All outputs go to `.cursor/deep-search/<feature>/`:
- `SEARCH-SPEC.md` - Clarified requirements
- `trace-ledger.md` - Evidence trail
- `octocode-queries.md` - Cross-repo proofs
- `mcp-s-notes.md` - Internal knowledge (MANDATORY)
- `VALIDATION-REPORT.md` - **Proof certification (MANDATORY)**
- `ARCHITECTURE-REPORT.md` - Final report

---

## MANDATORY VERIFICATION GATE (BLOCKER)

**You CANNOT publish without completing this gate.**

### Step 1: STOP and Self-Check

Before verification, answer these questions:

1. **Did I retrieve every proof in THIS session?** (not from memory/training)
2. **Can I cite `repo/path:line` for every claim?**
3. **Did I actually read the code/docs I'm citing?**

If NO to any → go back and gather proof first.

### Step 2: Complete Proof Certification

Create `VALIDATION-REPORT.md` with this EXACT structure:

```markdown
## VALIDATION-REPORT.md

### Claims & Proofs (REQUIRED)
| # | Claim | Proof (`repo/path:line`) | Tool Used | Retrieved This Session |
|---|-------|--------------------------|-----------|------------------------|
| 1 | <your claim> | `<repo/path:line>` | <tool name> | ✅ Yes |
| 2 | <your claim> | `<repo/path:line>` | <tool name> | ✅ Yes |
| ... | ... | ... | ... | ... |

### Edge Connectivity (REQUIRED)
| Edge | From (`file:line`) | To (`file:line`) | Proof Type | Verified |
|------|-------------------|-----------------|------------|----------|
| import | `A.ts:5` | `B.ts` | import statement | ✅ |
| call | `A.ts:23` | `B.ts:10` | function call | ✅ |
| cross-repo | `local/A.ts:30` | `wix-private/X:15` | Octocode proof | ✅ |

### 4 Mandatory Sources Check
- [ ] Slack searched: <queries tried> → <results or NOT FOUND>
- [ ] Jira searched: <queries tried> → <results or NOT FOUND>
- [ ] Docs searched: <queries tried> → <results or NOT FOUND>
- [ ] wix-private/* searched: <queries tried> → <results or NOT FOUND>

### NOT FOUND Items (if any)
| Item | Search 1 | Search 2 | Search 3 | Conclusion |
|------|----------|----------|----------|------------|
| <item> | `query` in `scope` | `query` in `scope` | `query` in `scope` | NOT FOUND |

### Anti-Hallucination Certification
- [ ] Every proof citation was retrieved using a tool in THIS session
- [ ] No proof was cited from memory or training data
- [ ] All unverified theories are marked as `⚠️ HYPOTHESIS (unverified)`
- [ ] NOT FOUND items have 3+ documented search attempts
- [ ] No claim is presented as fact without proof

### Final Certification
☐ I certify that ALL claims are backed by proofs I retrieved in this session.
☐ I can re-run the tools and get the same results.
```

### Step 3: Verification Decision

**If ALL checkboxes complete** → Proceed to publish
**If ANY checkbox incomplete** → STOP. Go back and:
- Gather missing proofs
- Mark unverified claims as `⚠️ HYPOTHESIS`
- Document NOT FOUND with 3+ search attempts

---

## Hard-fail Conditions (INSTANT BLOCK)

Publishing is **BLOCKED** if ANY of these are true:

- ❌ Publishing without `VALIDATION-REPORT.md` completed
- ❌ **Any claim without proof citation**
- ❌ **Proof cited from memory** (not retrieved this session)
- ❌ **Hypothesis presented as conclusion** (missing `⚠️ HYPOTHESIS` marker)
- ❌ **Skipping any of the 4 mandatory sources** (Slack, Jira, Docs, wix-private/*)
- ❌ Empty `octocode-queries.md` when cross-repo symbols exist
- ❌ Empty `mcp-s-notes.md`
- ❌ Stating root cause without MCP-S verification (debug intent)
- ❌ NOT FOUND marked without 3+ query variations documented
- ❌ Edge connectivity claimed without proof (import/call/binding)

---

## Proof Format Reference

### Correct Proof Citation
```
**Claim**: The `handleSubmit` function validates input before saving.

**Proof**: `editor-platform/packages/sdk/src/form.ts:45-52`
```typescript
function handleSubmit(data: FormData) {
  if (!validateInput(data)) {
    throw new ValidationError('Invalid input');
  }
  return save(data);
}
```
**Tool**: `localGetFileContent` / `Read`
```

### Correct Hypothesis (unverified)
```
⚠️ HYPOTHESIS (unverified): The error might be caused by a race condition.
Requires: [runtime test | Slack search for similar reports]
```

### Correct NOT FOUND
```
**NOT FOUND**: Database schema for user preferences
**Searches**:
1. `grep "user_preferences"` in `editor-platform/` → 0 results
2. `localSearchCode("preferences schema")` → 0 results
3. Slack search "user preferences schema" → 0 results
**Conclusion**: NOT FOUND after 3 variations
```

---

## Detailed Guidance
- See [clarify-patterns.md](../../guides/clarify-patterns.md) for clarification
- See [resolve-workflow.md](../../guides/resolve-workflow.md) for resolution
- See [verify-checklist.md](../../guides/verify-checklist.md) for verification template
- See [proof-discipline.md](../../guides/proof-discipline.md) for proof format
- See [octocode-patterns.md](../../guides/octocode-patterns.md) for cross-repo resolution
- See [mcp-s-patterns.md](../../guides/mcp-s-patterns.md) for internal knowledge
