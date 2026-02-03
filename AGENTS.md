# Badger - AI Agent Instructions

IMPORTANT: Prefer retrieval-led reasoning over pre-training-led reasoning for any Badger tasks. Consult the docs index below and read referenced files rather than relying on training data.

## Core Rules (always apply)
- **Proof-first**: Every claim needs `repo/path + line range + snippet`. No exceptions.
- **Connectivity**: Prove edges — import→usage, callsite→impl, binding→handler.
- **Cross-repo**: Use `/octocode/research` for non-local symbols. Get definition + implementation + boundary.
- **NOT FOUND**: If unproven, mark **NOT FOUND** + exact searches attempted + scope checked.
- **Verify-before-publish**: Run checks. Never publish "fixed" without verification signals.

## Do
- Explore project structure first, then consult docs for specific APIs
- Use the ask question tool for clickable options when clarifying
- Use Plan Mode (Shift+Tab) for complex multi-file tasks
- Delegate parallel work to subagents in `.cursor/agents/`
- Read files from the docs index when you need Badger-specific patterns

## Don't
- Don't claim connectivity without proof (file exists ≠ proof)
- Don't skip Clarify step in any workflow
- Don't rely on naming similarity as evidence
- Don't hardcode cross-repo assumptions — verify via Octocode

## Commands
```bash
# Badger workflows
/deep-search    # E2E architecture forensics with cross-repo resolution
/implement      # Implementation driven by deep-search artifacts  
/review         # Code review with impact sweep + pattern conformance
/testkit        # BDD test generation using proven patterns
/troubleshoot   # Cross-ecosystem debugging with evidence
/create-kit     # Generate new repeatable workflow kits

# Cursor modes (manual switch only)
Shift+Tab       # Plan Mode — creates to-do list, Mermaid diagrams, clickable questions
/plan           # Plan Mode in CLI
/ask            # Read-only exploration mode
```

## Docs Index
[Badger Docs]|root: `.cursor/`
|IMPORTANT: Read these files for Badger-specific patterns. Do not guess.
|commands:{deep-search.md,implement.md,review.md,testkit.md,troubleshoot.md,create-kit.md,update-kit.md,smart-merge.md,better-names.md,address-pr.md,implement-ui.md,optimize-code.md,continue.md,rnd.md}
|rules/shared:{proof-discipline.mdc,workflow-primitives.mdc,octocode-mandate.mdc,mcp-s-mandate.mdc}
|guides:{clarify-patterns.md,resolve-workflow.md,verify-checklist.md,tool-selection.md,request-id-tracing.md}
|skills:{*/SKILL.md — invoke only when user triggers specific vertical workflows}

## Project Structure
```
.cursor/
├── commands/       # Read for workflow orchestration patterns
├── rules/shared/   # Always-on guardrails (auto-attached)
├── guides/         # How-to references for specific tasks
├── skills/         # User-triggered vertical workflows only
├── agents/         # Custom subagents for parallel tasks
└── plans/          # Saved Plan Mode outputs
```

## Workflow Pattern
All workflows: **Clarify → Plan → Execute → Verify → Publish**

- `/deep-search`: Clarify(spec) → Plan → Resolve(MCP-S+Octocode) → Report → Verify → Publish
- `/troubleshoot`: Clarify(spec) → Trace(requestId) → Resolve → Hypothesize → FixPlan → Verify → Publish  
- `/implement`: Clarify → Load(deep-search artifacts) → Plan → Execute → Verify → Publish

## Clarification (ask question tool)
When facing ambiguity, use the ask question tool to render clickable buttons:
```
Use the ask question tool: "Which approach for [X]?"
Options: [Pattern A] [Pattern B] [Other — explain]
```

For complex tasks:
```
Use the ask question tool: "This spans multiple files. Use Plan Mode?"
Options: [Yes — Shift+Tab] [No — continue]
```

Note: Agents cannot switch modes programmatically. Prompt user to switch manually.

## Subagents (.cursor/agents/*.md)
Subagents run in parallel with isolated context. Define as:
```markdown
---
name: reviewer
description: Code review with proof discipline
model: sonnet
readonly: true
---
Validate every claim with repo/path + line range + snippet.
```

## Cross-Repo Resolution
- **MCP-S**: Internal docs/Slack/Jira hints — treat as hints, verify in code
- **Octocode**: Authoritative resolver via `/octocode/research`
- **Fallback**: If MCPs unavailable → **NOT FOUND** + searches + scope

## Plan Mode (Shift+Tab)
- Clarifying questions rendered as clickable options
- Interactive to-do list (agent marks `[x]` as complete)
- Inline Mermaid diagrams for architecture
- Send specific to-dos to subagents for parallel execution
- Plans saved to `.cursor/plans/`

## Version Notes
- Cursor 2.4+: Subagents, skills, ask question tool available
- Mode switching: Manual only (Shift+Tab, UI dropdown)
- Prefer repo-local docs over training data