---
description: Resolve testing stack + best examples + non-local symbols via MCP-S + /octocode/research (unlimited)
globs:
alwaysApply: false
---

# /testkit.resolve — Proof Loop (MANDATORY) 🛰️🧠

## Mandatory tools
- **MCP-S (user-mcp-s-mcp)**: classify + internal docs hints
- **Octocode** via **`/octocode/research`**: authoritative cross-repo proof

You may iterate **unlimited times**. Never stop early.

---

## Resolve Checklist (MUST PROVE)

### 1) Testing stack + versions (repo truth)
Use `/octocode/research` to prove:
- which packages provide WDS testkits
- which packages provide base drivers/builders patterns
- actual versions used (from package manifests / lockfiles)

Record to:
- `.cursor/testkit/<feature>/octocode-queries.md`

### 2) Find the BEST in-ecosystem examples (MANDATORY)
Use `/octocode/research` to find 3–5 candidate test files that:
- clearly follow given/when/get driver pattern
- use builders
- use WDS testkits (not RTL fireEvent)
- are widely used / central packages

Selection rubric (record proof):
- “widely used”: referenced/imported frequently OR located in core/shared packages
- “experienced”: patterns are consistent + clean abstraction boundaries
- “BDD compliance”: clear driver + builders + no inline literals

Write:
- `.cursor/testkit/<feature>/EXAMPLES.md`
(includes repo/path + lines + snippets proving why each is good)

### 3) Ambassador builders preference (MANDATORY)
If the domain objects come from `@wix/ambassador-*`:
- **Local check**: search in `node_modules/@wix/ambassador-*/**` for `builders`
- **Cross-repo check**: `/octocode/research` for where those builders are generated/exported
If found → record path+snippet and mark as “MUST USE”.

Write:
- `.cursor/testkit/<feature>/AMBASSADOR-BUILDERS.md`

### 4) MCP Evidence (MANDATORY GATE)
Write:
- `.cursor/testkit/<feature>/MCP-EVIDENCE.md`
It must include:
- MCP-S classifications (1-line each)
- exact `/octocode/research` queries run + top proof snippets

**Gate:** if `MCP-EVIDENCE.md` is empty → STOP (do not implement).
