---
description: Deep forensic E2E search (clarify → resolve → draft → verify → publish)
globs: ".cursor/commands/deep-search/**/*.md"
alwaysApply: false
---

# /deep-search — Orchestrator 🧬🔎

**Purpose:** produce a **provable, cross-repo E2E** architecture report (chat + file), with **mandatory validation** before publish.

**Agent loop:** clarify → plan → execute → verify → publish.

## Enforces (rules)
- [Deep-Search Laws](../rules/deep-search/deep-search-laws.mdc)
- [Octocode Mandate (shared)](../rules/shared/octocode-mandate.mdc)
- [MCP-S Mandate (shared)](../rules/shared/mcp-s-mandate.mdc)
- [Proof Discipline (shared)](../rules/shared/proof-discipline.mdc)
- [Workflow Primitives (shared)](../rules/shared/workflow-primitives.mdc)

## Delegates to (sub-commands)
- `/deep-search.clarify`  → `.cursor/commands/deep-search/deep-search.clarify.md`
- `/deep-search.resolve`  → `.cursor/commands/deep-search/deep-search.resolve.md`
- `/deep-search.report`   → `.cursor/commands/deep-search/deep-search.report.md` (DRAFT ONLY)
- `/deep-search.verify`   → `.cursor/commands/deep-search/deep-search.verify.md`
- `/deep-search.publish`  → `.cursor/commands/deep-search/deep-search.publish.md` (FINAL)

---

## 🚨 DEBUG INTENT = SLACK + DEVEX VERIFICATION (CRITICAL)

**If intent is "debug" (something doesn't work):**

### Step A: Search Slack FIRST
```
toolName: slack__search-messages
arguments:
  searchText: "<feature> <error-keywords>"
  after: "YYYY-MM-DD"  # last 30-60 days
```

If thread found, get full context:
```
toolName: slack__slack_get_thread_replies
arguments:
  channel_id: "<from search>"
  thread_ts: "<from search>"
```

### Step B: CHECK IF DEVEX APPLIES, THEN VERIFY
After finding Slack context, **try to verify** with DevEx:

```
# First: detect if project is DevEx-tracked
toolName: search_projects
arguments:
  search:
    filter: { "name": { "$contains": "<project-name>" } }
    cursorPaging: { limit: 5 }

# Or if you know the exact name:
toolName: get_project
arguments:
  projectName: "<groupId>.<artifactId>"
```

**If DevEx returns data** → use these tools to verify:
```
# Rollout history (actual deployment)
toolName: get_rollout_history
arguments:
  groupId: "<groupId>"
  artifactId: "<artifactId>"

# Commit deployment status
toolName: where_is_my_commit
arguments:
  project_name: "<project>"
  commit_hash: "<sha>"
  repo_url: "git@github.com:wix-private/<repo>.git"
```

**If DevEx returns empty/error** → project not tracked, proceed to Step C.

### Step C: USER CONFIRMATION (if DevEx unavailable or incomplete)
If DevEx doesn't apply to this project, fails, or returns insufficient data, **ASK before concluding**:
```
toolName: AskQuestion
arguments:
  title: "Verify before concluding"
  questions:
    - id: "deploy_state"
      prompt: "Slack suggests X. Is this deployed/GA'd?"
      options:
        - { id: "deployed", label: "Yes - deployed and still broken" }
        - { id: "not_deployed", label: "No - not deployed yet" }
        - { id: "preview_only", label: "Deploy preview only" }
    - id: "matches"
      prompt: "Does this match your issue?"
      options:
        - { id: "yes", label: "Exactly" }
        - { id: "partial", label: "Partially" }
        - { id: "no", label: "Different issue" }
```

| ❌ Slack only | ✅ Slack + DevEx (if available) | ✅ Slack + User (fallback) |
|--------------|--------------------------------|---------------------------|
| Thread says "fixed" → conclude | Thread says "fixed" → DevEx confirms deploy → accurate | Thread says "fixed" → DevEx N/A → ask user → accurate |

> **Rule**: Slack provides *context*, DevEx provides *deployment truth* (when project is tracked), User confirms (when DevEx unavailable).

---

## Step 0 — Clarify Loop (MANDATORY) 🧠
Ask: **"What would you like to deep-search?"**  
Run `/deep-search.clarify` until a complete **Search Spec** exists:
- feature + intent (E2E understand | **debug** | clone/add)
- 1–3 breadcrumbs
- required consumers + boundaries (network/persistence/render/throw)
- **SDKs involved (if any)** (e.g. `@wix/ambassador-*`, `ctx.ambassador.request`, `/rpc`, `/types`)

Persist:
- `.cursor/deep-search/<feature>/SEARCH-SPEC.md`

---

## Step 1 — Plan (MANDATORY) 🗺️
Write a short execution plan and persist it:
- `.cursor/plans/deep-search.<feature>.md`

Plan must include:
- contract chain (source IDL → generated → runtime)
- write path E2E
- read path E2E
- SDK generation chain (if any)
- verification gates

---

## Step 2 — Deep Research Loop (MANDATORY, UNLIMITED) 🌍🛰️
Run `/deep-search.resolve` repeatedly until:
- **ALL** external/non-local/uncertain symbols are **resolved** OR marked **NOT FOUND** (with searches + scope)
- **ALL** non-local symbols are resolved via **`/octocode/research`** (def + impl + side-effect boundary)
- **ALL** features/services have MCP-S context (internal docs, Slack, Jira)

🔎 **MCP-S Internal Knowledge Gate (MANDATORY)**
For every major feature/service/SDK, you MUST search:
- **Internal Docs** (`docs-schema__search_docs`) — architecture, ownership, design specs
- **Slack** (`slack__search-messages`) — team discussions, decisions, context
- **Jira** (`jira__get-issues`) — requirements, tickets, acceptance criteria
- **DevEx** (when applicable):
  - `code_owners_for_path` — who owns the code
  - `get_project` / `search_projects` — project metadata
  - `get_build` / `search_builds` — CI/CD status
  - `where_is_my_commit` — commit tracking
  - `release_notes` / `get_rollout_history` — release info
  - `get_devex_fqdn` — service endpoints

MCP-S provides context; Octocode provides code proof. Both are required.

🚨 **SDK Generation Chain Gate**
If any SDK/client is mentioned (especially `@wix/ambassador-*`), you MUST also resolve:
- source IDL that generated it (proto/openapi/graphql)
- generator/config & "package generation" trigger
- runtime transport boundary (auth/baseUrl/retries + request execution)
- types package proof (generated from same IDL)

Persist evidence:
- `.cursor/deep-search/<feature>/trace-ledger.md`
- `.cursor/deep-search/<feature>/octocode-queries.md`
- `.cursor/deep-search/<feature>/mcp-s-notes.md` (MANDATORY — must have queries for docs/Slack/Jira/DevEx)

---

## Step 3 — Draft Report (MANDATORY, FILE-ONLY) 🧾
Run `/deep-search.report` to generate:
- `.cursor/deep-search/<feature>/ARCHITECTURE-REPORT.draft.md`

**Do NOT print the draft in chat.** (Write to files to avoid context loss.)

---

## Step 4 — Verify (MANDATORY, BEFORE ANY PUBLISH) ✅
Run `/deep-search.verify` against the DRAFT to prove:
- edges connect by **imports/calls/bindings**, not naming similarity
- every flow arrow has snippet-backed proof (or NOT FOUND)
- **SDK Generation Chain is connected end-to-end** (IDL → generated → runtime)

Outputs:
- `.cursor/deep-search/<feature>/VALIDATION-REPORT.md`

If broken claims exist:
1) fix ledger/report
2) re-run `/deep-search.verify`
Repeat until **PASS** or items become **NOT FOUND**.

---

## Step 5 — Publish (MANDATORY) 📣
Run `/deep-search.publish`:
- writes `.cursor/deep-search/<feature>/ARCHITECTURE-REPORT.md` (FINAL)
- prints the FINAL report to chat

---

## Hard-fail conditions 🚫
- publish attempted without a **passing** `/deep-search.verify`
- `octocode-queries.md` is empty (Octocode not used when required)
- `mcp-s-notes.md` is empty or missing (MCP-S not used for internal knowledge)
- any non-local symbol lacks Octocode **def + impl + boundary**
- any SDK mention lacks **SDK Generation Chain proof**
- any E2E arrow asserted without evidence (or NOT FOUND)
- any major feature/service lacks MCP-S context (docs/Slack/Jira/DevEx search)
- ownership claims without DevEx `code_owners_for_path` proof
- **stating root cause without MCP-S verification (for debug intent)**
- **presenting hypothesis as conclusion without proof**
- **(debug intent) concluding without attempting DevEx verification** (must try `search_projects`/`get_project` first)
- **(debug intent) concluding without user confirmation when DevEx doesn't apply or returns incomplete data**
