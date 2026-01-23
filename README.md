# 🧬 Cursor Deep Search Kit 🔎✨

A drop-in **`.cursor/` kit** that adds one main workflow command: **`/deep-search`**.

Use it when you want **end-to-end, cross-repo architecture understanding** with:
- ✅ **proof in code** (repo/path + lines + snippet)
- 🌍 **cross-repo resolution** via **`/octocode/research`**
- 🧪 **validation** that the hops actually connect (imports/calls/bindings)
- 📝 a final report **printed in chat + saved to a file**

> Built using Cursor’s **Commands / Rules / Skills** conventions. :contentReference[oaicite:0]{index=0}

---

## 🎯 What it does

When you run **`/deep-search`**, the agent must follow this flow:

1) 🧠 **Clarify** (ask questions until the search spec is crystal clear)
2) 🗺️ **Resolve** (iterate MCP-S + Octocode as much as needed across repos)
3) 🧾 **Draft** (write a draft report to a file)
4) ✅ **Verify** (prove each hop links up codewise; fix anything wrong)
5) 📣 **Publish** (print the final report to chat + write it to a final file)

---

## ✅ Prerequisites

### Cursor project structure
Your Cursor setup needs to support:
- custom **commands** in `.cursor/commands/`
- project **rules** in `.cursor/rules/`
- agent **skills** in `.cursor/skills/**/SKILL.md`

### MCPs / Tools
This kit assumes these are available in your environment:
- **MCP-S** (`user-mcp-s-mcp`) — classification + internal docs/spec hints
- **Octocode** (`user-octocode-mcp`) — cross-repo resolver
  - trigger via: **`/octocode/research`**

If MCPs aren’t available, cross-repo items must be marked **NOT FOUND** (with searches + scope).

---

## 📦 Install

Copy this repo’s **`.cursor/`** folder into any target project root:

1. Copy: `cursor-deep-search-kit/.cursor` → `your-project/.cursor`
2. Reload Cursor (so it picks up the commands).

That’s it ✅

---

## 🚀 Quickstart

In Cursor chat:

1) Run: `/deep-search`

2) When asked “What would you like to deep-search?”, paste something like:

```text
Feature: <feature-name>

Intent: E2E understanding | debug | clone/add similar feature

Breadcrumbs:
- <string/type/endpoint/config key 1>
- <string/type/endpoint/config key 2>

Must include:
- cross-repo consumers (prove or NOT FOUND)
- SDK/client generation source + runtime transport boundary
```

---

## 🧠 How to think about inputs (so it goes fast)

### ✅ Good breadcrumbs
- schema field/type names  
- endpoint paths / RPC names  
- config keys  
- error codes  
- unique strings  

### 🔍 How the agent searches
The agent will pick one breadcrumb and do **DFS** to a real boundary:
- 🌐 network call  
- 💾 persistence read/write  
- 🎨 render boundary  
- 💥 thrown error boundary  

…and then do **BFS** around boundaries to find siblings (other consumers/producers).

---

## 🧰 What’s in this kit

### Commands (`.cursor/commands/`)
- `deep-search.mdc` — 🧭 Orchestrator (Clarify → Resolve → Draft → Verify → Publish)
- `deep-search.clarify.mdc` — 🧠 Clarification loop (build the Search Spec)
- `deep-search.resolve.mdc` — 🌍 MCP-S + Octocode proof loop (unlimited iterations)
- `deep-search.report.mdc` — 🧾 Writes DRAFT report (file-only)
- `deep-search.verify.mdc` — ✅ Validates connectivity (imports/calls/bindings), writes validation report
- `deep-search.publish.mdc` — 📣 Publishes FINAL report (chat + file), only after verify passes

### Rules (`.cursor/rules/`)
- `deep-search-laws.mdc` — 🚨 hard gates (draft → verify → publish, proof rules, NOT FOUND discipline)
- `octocode-mandate.mdc` — 🛰️ forces `/octocode/research` for non-local symbols

> This kit is deep-search only, so we intentionally don’t ship extra generic rules.

### Skills
- `.cursor/SKILL.md` — quick overview for agents
- `.cursor/skills/octocode-research/SKILL.md` — how to query + record Octocode proof
- `.cursor/skills/mcp-s/SKILL.md` — how to classify symbols + extract doc hints

---

## 🏗️ What gets generated during a run

Per feature run, the agent will create:
- `.cursor/plans/deep-search.<feature>.md` — the plan
- `.cursor/deep-search/<feature>/SEARCH-SPEC.md` — clarified search spec (inputs + constraints)
- `.cursor/deep-search/<feature>/octocode-queries.md` — exact Octocode queries (incl. verify)
- `.cursor/deep-search/<feature>/mcp-s-notes.md` — MCP-S classifications + doc hints
- `.cursor/deep-search/<feature>/trace-ledger.md` — ALL external/non-local symbols + proof chain
- `.cursor/deep-search/<feature>/ARCHITECTURE-REPORT.draft.md` — draft report (pre-verify)
- `.cursor/deep-search/<feature>/VALIDATION-REPORT.md` — broken claims + verified edges list
- `.cursor/deep-search/<feature>/ARCHITECTURE-REPORT.md` — final report (published)

---

## ✅ What “Verify” actually checks (why this kit is strict)

This is the whole point:

- “File exists” ❌ not enough  
- We validate that hops are connected by code, for example:
  - import → usage  
  - call site → implementation  
  - route/RPC binding → handler  
  - cross-repo claim → Octocode proof  

If something is ambiguous, it must become:
- **NOT FOUND**
- exact searches tried
- scope searched (repos/packages)

---

## 🧯 Troubleshooting

### “`/deep-search` not found”
- Confirm the files are in: `.cursor/commands/`
- Reload Cursor after copying `.cursor/`

### “Octocode/MCP-S didn’t run”
- Confirm MCPs are enabled in your environment
- Rules require Octocode for non-local symbols; if it’s unavailable you should see **NOT FOUND + searches**

### Verification failed
- Good! That means it caught something before you trusted it 💪  
- Fix pointers/edges, re-run verify, then publish.

---

## 🤝 Contributing (optional)
Keep changes focused:
- don’t bloat rules
- prefer referencing files over copying long text
- keep commands procedural and reusable
