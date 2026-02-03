# 🦡 Badger

A drop-in **`.cursor/` kit** with proof-driven workflows for code understanding, debugging, implementation, review, and testing.

> **Badger** — persistent, digs deep, won't stop until it finds it.

---

## 🎯 What's inside

| Command | Purpose |
|---------|---------|
| `/deep-search` | E2E architecture forensics with cross-repo resolution |
| `/troubleshoot` | Cross-ecosystem debugging with evidence and traceability |
| `/implement` | Implementation driven by deep-search outputs |
| `/review` | Code review with impact sweep + pattern conformance |
| `/testkit` | BDD test generation using proven patterns |
| `/create-kit` | Meta-workflow to create new kits |

All workflows share a common pattern:
**Clarify → Plan → Execute → Verify → Publish**

---

## ✨ Core principles

- ✅ **Proof in code** — every claim needs `repo/path + lines + snippet`
- 🌍 **Cross-repo resolution** — via MCP-S + Octocode
- 🧪 **Verify-before-publish** — mandatory validation gate
- 📝 **Dual output** — chat + file artifacts

---

## ✅ Prerequisites

### Cursor project structure
Your Cursor setup needs to support:
- custom **commands** in `.cursor/commands/`
- project **rules** in `.cursor/rules/`
- agent **skills** in `.cursor/skills/**/SKILL.md`

### MCPs / Tools
This kit assumes these are available in your environment:
- **MCP-S** — classification + internal docs/spec hints
- **Octocode** — cross-repo resolver (trigger via `/octocode/research`)

If MCPs aren't available, cross-repo items must be marked **NOT FOUND** (with searches + scope).

---

## 📦 Install

Copy this repo's **`.cursor/`** folder into any target project root:

1. Copy: `badger/.cursor` → `your-project/.cursor`
2. Reload Cursor (so it picks up the commands).

That's it ✅

---

## 🚀 Workflows

### `/deep-search` — Architecture Forensics 🔍

```
/deep-search
```

Flow: **Clarify → Plan → Resolve → Draft → Verify → Publish**

Use when you want E2E architecture understanding with proof. Outputs:
- `ARCHITECTURE-REPORT.md` — final provable report
- `trace-ledger.md` — all external symbols + proof chain

---

### `/troubleshoot` — Cross-Ecosystem Debugging 🐛

```
/troubleshoot
```

Flow: **Clarify → Trace → Resolve → Hypothesize → Fix Plan → Verify → Publish**

Use when you need to debug across repos with evidence. Outputs:
- Hypothesis tree with experiments
- Fix plan with verification signals

---

### `/implement` — Implementation from Deep-Search 🔨

```
/implement
```

Flow: **Clarify → Load → Plan → Execute → Verify → Publish**

Requires an existing `/deep-search` run. Outputs:
- PR-ready implementation
- Updated deep-search artifacts

---

### `/review` — Deep Code Review 📋

```
/review
```

Flow: **Clarify → Scan → Conform → Impact → Resolve → Packet → Verify → Publish**

Use for reviewing changes with impact analysis. Outputs:
- Review packet with risk assessment (HIGH/MOD/LOW)

---

### `/testkit` — BDD Test Generation 🧪

```
/testkit
```

Flow: **Clarify → Resolve → Implement → Verify → Publish**

Use to generate tests aligned to proven patterns. Outputs:
- Drivers/builders/tests
- MCP Evidence section

---

### `/create-kit` — Create New Workflow Kits 🛠️

```
/create-kit
```

Flow: **Clarify → Plan → Scaffold → Verify → Publish**

Use to create new reusable Cursor workflow kits.

---

## 🧰 Kit structure

```
.cursor/
├── commands/
│   ├── deep-search.md      # Main orchestrator
│   ├── deep-search/        # Sub-commands (clarify, resolve, verify, etc.)
│   ├── troubleshoot.md
│   ├── troubleshoot/
│   ├── implement.md
│   ├── implement/
│   ├── review.md
│   ├── review/
│   ├── testkit.md
│   ├── testkit/
│   ├── create-kit.md
│   └── create-kit/
├── rules/
│   ├── shared/             # shared mandates + proof discipline + workflow primitives
│   ├── deep-search/        # deep-search-laws (kit-specific)
│   ├── troubleshoot/       # troubleshoot-laws + tool mandates (kit-specific)
│   ├── implement/          # implement-laws
│   ├── review/             # review-laws
│   ├── testkit/            # testkit-laws
│   └── create-kit/         # create-kit-laws + frontmatter-guard
├── guides/                 # shared how-to (passive context)
│   ├── clarify-patterns.md
│   ├── resolve-workflow.md
│   └── verify-checklist.md
└── skills/
    └── ...                 # mostly user-triggered workflows; critical rules live in AGENTS.md + rules/shared + guides
```

**Command paths are now clean:**
- `/badger/deep-search` (not `/badger/deep-search/deep-search`)

---

## ✅ What "Verify" actually checks

This is the whole point:

- "File exists" ❌ not enough
- We validate that hops are connected by code:
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

### "Command not found"
- Confirm files are in: `.cursor/commands/`
- Reload Cursor after copying `.cursor/`

### "Octocode/MCP-S didn't run"
- Confirm MCPs are enabled in your environment
- Rules require Octocode for non-local symbols; if unavailable you should see **NOT FOUND + searches**

### Verification failed
- Good! That means it caught something before you trusted it 💪
- Fix pointers/edges, re-run verify, then publish.

---

## 🤝 Contributing

Keep changes focused:
- don't bloat rules
- prefer referencing files over copying long text
- keep commands procedural and reusable
