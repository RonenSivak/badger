---
description: Deep forensic E2E search (clarify → resolve → draft → verify → publish)
globs: ".cursor/commands/deep-search*.mdc"
alwaysApply: false
---

# /deep-search — Orchestrator 🧬🔎

**Purpose:** produce a **provable, cross-repo E2E** architecture report (chat + file), with **mandatory validation** before publish.

**Must follow Cursor’s agent loop:** clarify → plan → execute → verify → publish.

## Enforces (rules)
- [Deep-Search Laws](../rules/deep-search-laws.mdc)
- [Octocode Mandate](../rules/octocode-mandate.mdc)

## Delegates to (sub-commands)
- `/deep-search.clarify`  → `.cursor/commands/deep-search.clarify.mdc`
- `/deep-search.resolve`  → `.cursor/commands/deep-search.resolve.mdc`
- `/deep-search.report`   → `.cursor/commands/deep-search.report.mdc` (DRAFT ONLY)
- `/deep-search.verify`   → `.cursor/commands/deep-search.verify.mdc`
- `/deep-search.publish`  → `.cursor/commands/deep-search.publish.mdc` (FINAL)

---

## Step 0 — Clarify Loop (MANDATORY) 🧠
Ask: **“What would you like to deep-search?”**  
Run `/deep-search.clarify` until a complete **Search Spec** exists:
- feature + intent (E2E understand | debug | clone/add)
- 1–3 breadcrumbs
- required consumers + boundaries (network/persistence/render/throw)

Persist:
- `.cursor/deep-search/<feature>/SEARCH-SPEC.md`

---

## Step 1 — Plan (MANDATORY) 🗺️
Write a short execution plan before deep execution and persist it:
- `.cursor/plans/deep-search.<feature>.md`

Plan shape: contract → write path → storage → read path → consumers → risks → validation.

---

## Step 2 — Deep Research Loop (MANDATORY, UNLIMITED) 🌍🛰️
Run `/deep-search.resolve` repeatedly until:
- all external/non-local/uncertain symbols are **resolved** OR marked **NOT FOUND** (with searches + scope)
- **every** non-local symbol is resolved via **`/octocode/research`** (def + impl + side-effect boundary)

Persist evidence:
- `.cursor/deep-search/<feature>/trace-ledger.md`
- `.cursor/deep-search/<feature>/octocode-queries.md`
- `.cursor/deep-search/<feature>/mcp-s-notes.md`

---

## Step 3 — Draft Report (MANDATORY, FILE-ONLY) 🧾
Run `/deep-search.report` to generate:
- `.cursor/deep-search/<feature>/ARCHITECTURE-REPORT.draft.md`

**Do NOT print the draft in chat.**

---

## Step 4 — Verify (MANDATORY, BEFORE ANY PUBLISH) ✅
Run `/deep-search.verify` against the DRAFT to prove:
- edges are connected by **imports/calls/route-bindings**, not naming similarity
- every “flow arrow” has at least one snippet-backed proof (or NOT FOUND)

Outputs:
- `.cursor/deep-search/<feature>/VALIDATION-REPORT.md`

If verification finds broken/unsupported claims:
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
- publishing attempted without a **passing** `/deep-search.verify`
- `.cursor/deep-search/<feature>/octocode-queries.md` is empty (Octocode not used when required)
- any non-local symbol appears in the report without Octocode **def + impl + boundary**
- any E2E arrow is asserted without snippet-backed evidence (or NOT FOUND)
- verification fails and publish proceeds anyway
