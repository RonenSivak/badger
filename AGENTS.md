# Badger - AI Agent Instructions

IMPORTANT: Prefer retrieval-led reasoning over pre-training-led reasoning for any Badger tasks. Read skill and guide files rather than relying on training data.

## Core Rules (always apply)

### Proof Discipline
- **Proof-first**: Every claim needs `repo/path + line range + snippet`. No exceptions.
- **Connectivity**: Prove edges — import→usage, callsite→impl, binding→handler.
- **NOT FOUND**: If unproven, mark **NOT FOUND** + exact searches attempted + scope checked.
- **Hypothesis discipline**: Never state conclusions without proof. Mark unverified claims as `⚠️ HYPOTHESIS`.

### Cross-Repo Resolution (Octocode)
- Use Octocode for non-local symbols, generated artifacts, SDK boundaries.
- Minimum proof: definition + implementation + boundary (network/persist/render/throw).
- SDK chains: resolve IDL → generator → runtime transport → types.

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

See [internal-knowledge-search.md](/.cursor/guides/internal-knowledge-search.md) for complete protocol.

### Workflow Pattern
All workflows follow: **Clarify → Plan → Execute → Verify → Publish**
- Verify-before-publish: Run checks. Never publish without verification signals.

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

See [continuing-sessions skill](/.cursor/skills/continuing-sessions/SKILL.md) for resume protocol.

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
[Badger Skills]|root: `.cursor/skills/`
|deep-searching: E2E architecture forensics with cross-repo resolution
|implementing: Safe implementation using deep-search artifacts
|reviewing: Code review with impact sweep + pattern conformance
|testing: BDD test generation using proven patterns
|troubleshooting: Cross-ecosystem debugging with evidence
|creating-kits: Generate new repeatable workflow kits
|merging-branches: Safe branch merging with conflict resolution
|addressing-prs: Handle PR review comments end-to-end
|renaming-symbols: Safe identifier renaming with impact analysis
|optimizing-code: Systematic code simplification
|continuing-sessions: Resume work from dumped context files
|For workflow details, read the relevant `SKILL.md` file.

## Guides Index
[Guides]|root: `.cursor/guides/`
|internal-knowledge-search.md: **Complete protocol for searching ALL 4 internal sources (Slack/Jira/Docs/wix-private)**
|clarify-patterns.md: How to run clarification loops
|resolve-workflow.md: Resolution patterns for deep research
|verify-checklist.md: Verification gates and checks
|tool-selection.md: When to use which tools
|request-id-tracing.md: Tracing with x-wix-request-id
|octocode-patterns.md: Cross-repo resolution patterns
|mcp-s-patterns.md: Internal knowledge gathering patterns
|context-dumping.md: How to dump context when budget is near full
|agent-skills-standard.md: Agent Skills spec reference (naming, frontmatter, structure)
