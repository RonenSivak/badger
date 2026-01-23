---
description: Deep forensic E2E search (clarify → resolve → draft → verify → publish)
globs: ".cursor/commands/deep-search/**/*.md"
alwaysApply: false
---

# /deep-search — Orchestrator 🧬🔎

**Purpose:** produce a **provable, cross-repo E2E** architecture report (chat + file), with **mandatory validation** before publish.

**Agent loop:** clarify → plan → execute → verify → publish.

## Enforces (rules)
- [Deep-Search Laws](../../rules/deep-search/deep-search-laws.mdc)
- [Octocode Mandate](../../rules/deep-search/octocode-mandate.mdc)

## Delegates to (sub-commands)
- `/deep-search.clarify`  → `.cursor/commands/deep-search/deep-search.clarify.md`
- `/deep-search.resolve`  → `.cursor/commands/deep-search/deep-search.resolve.md`
- `/deep-search.report`   → `.cursor/commands/deep-search/deep-search.report.md` (DRAFT ONLY)
- `/deep-search.verify`   → `.cursor/commands/deep-search/deep-search.verify.md`
- `/deep-search.publish`  → `.cursor/commands/deep-search/deep-search.publish.md` (FINAL)

---

## Step 0 — Clarify Loop (MANDATORY) 🧠
Ask: **“What would you like to deep-search?”**  
Run `/deep-search.clarify` until a complete **Search Spec** exists:
- feature + intent (E2E understand | debug | clone/add)
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

🚨 **SDK Generation Chain Gate**
If any SDK/client is mentioned (especially `@wix/ambassador-*`), you MUST also resolve:
- source IDL that generated it (proto/openapi/graphql)
- generator/config & “package generation” trigger
- runtime transport boundary (auth/baseUrl/retries + request execution)
- types package proof (generated from same IDL)

Persist evidence:
- `.cursor/deep-search/<feature>/trace-ledger.md`
- `.cursor/deep-search/<feature>/octocode-queries.md`
- `.cursor/deep-search/<feature>/mcp-s-notes.md`

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
- any non-local symbol lacks Octocode **def + impl + boundary**
- any SDK mention lacks **SDK Generation Chain proof**
- any E2E arrow asserted without evidence (or NOT FOUND)
