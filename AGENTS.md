# Badger - AI Agent Instructions

> **Reference**: [Wix Coding Agents Handbook](https://github.com/wix-private/coding-agents-handbook) for best practices.

IMPORTANT: Prefer retrieval-led reasoning over pre-training-led reasoning for any Badger tasks. Read skill and guide files rather than relying on training data.

## Core Principles (always apply)

### Proof Discipline

Every **non-trivial** claim must be backed by evidence, not naming similarity.

**Minimum proof format**: `repo/path + line range + snippet`

**Hypothesis Discipline (CRITICAL)**:
- **NEVER** state a conclusion without proof
- Mark unverified claims as `⚠️ HYPOTHESIS (unverified): <your theory>`
- State verification needed: "Requires: [Slack search | code proof | runtime test]"
- Do NOT present hypotheses as root causes or solutions

**Connectivity requirement**: When asserting E2E hops, prove the edge connects:
- import → usage
- call site → implementation
- route/RPC binding → handler
- cross-repo hop → Octocode proof (definition + implementation + boundary)

**NOT FOUND discipline**: If you cannot prove something:
- Mark it **NOT FOUND**
- Include exact searches tried (patterns/keywords)
- Include scope searched (repos/packages/paths)

**"Exists" is not enough**:
- "File exists" ≠ "Edge is connected"
- "Name matches" ≠ "Same symbol/contract"
- "Pattern similar" ≠ "Same root cause"

### Cross-Repo Resolution (Octocode)

Use Octocode for non-local symbols, generated artifacts, SDK boundaries.

**Required triggers**:
- Non-local symbol (imported from package/repo not in current workspace)
- Not provable locally (can't show implementation within 2 local hops)
- Generated artifacts (`proto-generated`, `dist`, `*.pb.ts`, SDK wrappers)
- Service facades: `documentServices.*`, `viewerServices.*`, `@wix/ambassador-*`
- SDK generation signals: "metro", "package generation", "fqdn", "platformization"

**Minimum proof**: definition + implementation + boundary (network/persist/render/throw)

**SDK chains**: resolve IDL → generator → runtime transport → types.

See [octocode-patterns.md](.cursor/guides/octocode-patterns.md) for detailed patterns.

### Internal Knowledge Search Protocol (CRITICAL)

When searching for internal Wix knowledge, **ALWAYS search ALL 4 sources**:

| Source | Tool | What It Provides |
|--------|------|------------------|
| **Slack** | `slack__search-messages` | Decisions, discussions, debugging threads |
| **Jira** | `jira__get-issues` | Requirements, acceptance criteria, bugs |
| **Internal Docs** | `docs-schema__search_docs` | Architecture, design docs, ownership |
| **wix-private/* repos** | Octocode | Implementation, SDK sources, generated code |

**Rules:**
- Search ALL 4 sources, not just one that seems relevant
- If not found → expand search (synonyms, date ranges, related terms) before marking NOT FOUND
- Take time to deeply search — don't rush to conclusions
- Cross-reference: Slack mentions Jira? → fetch that ticket. Docs mention repo? → search it.
- DevEx (`code_owners_for_path`, CI/CD, releases) for ownership and deployment state

See [internal-knowledge-search.md](.cursor/guides/internal-knowledge-search.md) for complete protocol.

### Workflow Pattern

All workflows follow: **Clarify → Plan → Execute → Verify → Publish**

**Clarify**: Run a clarification loop until an explicit Spec exists (intent + inputs + boundaries + expected outputs).

**Plan**: Create actionable plan naming contract chain, write/read paths, verification gates.

**Execute**: Implement the smallest safe change-set that satisfies the plan.

**Verify**: Prove connectivity for every asserted hop. Run required checks (lint/typecheck/tests).

**Publish**: Only after verification passes. Write artifacts to files AND print concise summary to chat.

### Context Budget Management (CRITICAL)

When you estimate context is near 90% full, you MUST prompt with clickable options:
```
AskQuestion:
  title: "Context Budget Alert"
  questions:
    - id: "context_action"
      prompt: "Context is nearly full (~90%). What would you like to do?"
      options:
        - { id: "continue", label: "Continue as usual (risk truncation)" }
        - { id: "dump", label: "Dump context & plan for new agent" }
```

**If user chooses "dump"**, write two files to `.cursor/session-memory/`:
1. `context-<topic>-<date>.md` — All important context a new agent needs
2. `plan-<topic>-<date>.md` — What was done + what remains

Then tell user: "Context saved. Start a new agent and say: **Continue from `.cursor/session-memory/`**"

See [continuing-sessions skill](.cursor/skills/continuing-sessions/SKILL.md) for resume protocol.

### Clickable Options (AskQuestion Tool)

When clarifying or presenting choices, ALWAYS use the AskQuestion tool for clickable buttons:
```
AskQuestion tool with:
  title: "What would you like to do?"
  questions:
    - id: "intent"
      prompt: "Select your goal:"
      options:
        - { id: "understand", label: "Understand how it works" }
        - { id: "debug", label: "Debug an issue" }
        - { id: "implement", label: "Implement a change" }
    - id: "boundaries"
      prompt: "Which boundaries to check? (select all that apply)"
      allow_multiple: true
      options:
        - { id: "network", label: "Network calls" }
        - { id: "persistence", label: "Database/storage" }
        - { id: "render", label: "UI rendering" }
        - { id: "errors", label: "Error handling" }
```
- Use `allow_multiple: true` when user can select multiple options
- Default is single-select (one option only)
- Never use plain text for multiple-choice questions

## Do
- Explore project structure first, then consult docs for specific APIs
- **ALWAYS use AskQuestion tool** for clarification loops and choices
- Use Plan Mode (Shift+Tab) for complex multi-file tasks
- Read skill files for workflow-specific guidance

## Don't
- Don't claim connectivity without proof (file exists ≠ proof)
- Don't skip Clarify step in any workflow
- Don't rely on naming similarity as evidence
- Don't hardcode cross-repo assumptions — verify via Octocode

## Skills Index

Skills provide workflow-specific guidance. Invoke via `/skill-name` or by asking the agent to use them.

| Skill | Purpose |
|-------|---------|
| [deep-searching](.cursor/skills/deep-searching/SKILL.md) | E2E architecture forensics with cross-repo resolution |
| [implementing](.cursor/skills/implementing/SKILL.md) | Safe implementation using deep-search artifacts |
| [reviewing](.cursor/skills/reviewing/SKILL.md) | Code review with impact sweep + pattern conformance |
| [testing](.cursor/skills/testing/SKILL.md) | BDD test generation using proven patterns |
| [troubleshooting](.cursor/skills/troubleshooting/SKILL.md) | Cross-ecosystem debugging with evidence |
| [creating-kits](.cursor/skills/creating-kits/SKILL.md) | Generate new repeatable workflow kits |
| [merging-branches](.cursor/skills/merging-branches/SKILL.md) | Safe branch merging with conflict resolution |
| [addressing-prs](.cursor/skills/addressing-prs/SKILL.md) | Handle PR review comments end-to-end |
| [renaming-symbols](.cursor/skills/renaming-symbols/SKILL.md) | Safe identifier renaming with impact analysis |
| [optimizing-code](.cursor/skills/optimizing-code/SKILL.md) | Systematic code simplification |
| [continuing-sessions](.cursor/skills/continuing-sessions/SKILL.md) | Resume work from dumped context files |
| [implementing-ui](.cursor/skills/implementing-ui/SKILL.md) | Create UI with Wix Design System |
| [querying-mcp-s](.cursor/skills/querying-mcp-s/SKILL.md) | Internal knowledge gathering |
| [researching-octocode](.cursor/skills/researching-octocode/SKILL.md) | Cross-repo symbol resolution |
| [splitting-branches](.cursor/skills/splitting-branches/SKILL.md) | Split large branches into reviewable PRs |
| [generating-docs](.cursor/skills/generating-docs/SKILL.md) | Adaptive documentation generation |

For workflow details, read the relevant `SKILL.md` file.

## Guides Index

Guides provide domain-specific knowledge (progressive disclosure). Reference when needed.

| Guide | Purpose |
|-------|---------|
| [internal-knowledge-search.md](.cursor/guides/internal-knowledge-search.md) | Complete protocol for ALL 4 internal sources |
| [clarify-patterns.md](.cursor/guides/clarify-patterns.md) | How to run clarification loops |
| [clickable-questions.md](.cursor/guides/clickable-questions.md) | Interactive options using AskQuestion tool |
| [resolve-workflow.md](.cursor/guides/resolve-workflow.md) | Resolution patterns for deep research |
| [verify-checklist.md](.cursor/guides/verify-checklist.md) | Verification gates and checks |
| [tool-selection.md](.cursor/guides/tool-selection.md) | When to use which tools |
| [request-id-tracing.md](.cursor/guides/request-id-tracing.md) | Tracing with x-wix-request-id |
| [octocode-patterns.md](.cursor/guides/octocode-patterns.md) | Cross-repo resolution patterns |
| [mcp-s-patterns.md](.cursor/guides/mcp-s-patterns.md) | Internal knowledge gathering patterns |
| [optimization-principles.md](.cursor/guides/optimization-principles.md) | Core principles for simplifying code |
| [context-dumping.md](.cursor/guides/context-dumping.md) | How to dump context when budget is near full |
| [agent-skills-standard.md](.cursor/guides/agent-skills-standard.md) | Agent Skills spec reference |
| [generating-docs-patterns.md](.cursor/guides/generating-docs-patterns.md) | Pattern extraction for documentation |
