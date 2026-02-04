---
description: Shared resolve workflow (MCP-S classification + Octocode proof) and how to consume prior deep-search artifacts
globs:
alwaysApply: false
---

# Resolve Workflow (Shared)

Resolve is where you turn uncertainty into **provable edges**.

## Core Principles (from AGENTS.md)
- Internal Knowledge Search Protocol (ALL 4 sources)
- Cross-Repo Resolution / Octocode (definition + implementation + boundary)
- Proof Discipline (proof-first, connectivity, NOT FOUND discipline)

## Resolve loop (repeat until no unknowns)

### 1) Classify the unknown (MCP-S first for context)
Use MCP-S to answer questions code won’t:
- why does this exist?
- what is the requirement / acceptance criteria?
- who owns it?
- what’s the deployment/build status?
- is it generated (and from what)?

Then treat MCP-S as **hints**, not proof.

### 2) Prove code edges (Octocode for cross-repo)
For any non-local symbol (or anything not provable in ≤2 local hops):
- Octocode proof must include **definition + implementation + boundary**

### 3) Record evidence as you go
Always append:
- queries used
- snippets (repo/path + line range)
- “what this proves” (def/impl/boundary)

Follow the kit’s evidence file conventions (some kits use `octocode-queries.md`, others use `MCP-EVIDENCE.md`).

### 4) NOT FOUND discipline
If you cannot prove something:
- mark **NOT FOUND**
- include exact searches + scope (local + MCP-S + Octocode)

## Consuming prior deep-search artifacts (portable context)
If a prior deep-search exists, treat it as canonical context:
- Use `.cursor/deep-search/<feature>/ARCHITECTURE-REPORT.md` as the E2E map.
- Do **not** redo discovery unless:
  - the report contains **NOT FOUND**
  - code moved / is stale
  - you need more depth for a new change surface
- Re-pin cross-repo hops with Octocode as needed (definition + impl + boundary).

