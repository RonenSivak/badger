# Badger - AI Instructions

IMPORTANT: Prefer retrieval-led reasoning over pre-training-led reasoning for any Badger tasks.

## Overview
Badger is a drop-in `.cursor/` kit with proof-driven workflows for code understanding, debugging, implementation, review, and testing.

Core idea: **every claim needs proof in code** (repo/path + line range + snippet). If you cannot prove it: mark **NOT FOUND** and include exact searches + scope.

## Commands (entry points)
All workflows follow: **Clarify → Plan → Execute → Verify → Publish** (or close variants).

| Command | Purpose |
|--------|---------|
| `/deep-search` | E2E architecture forensics with cross-repo resolution |
| `/implement` | Implementation driven by deep-search artifacts |
| `/review` | Code review with impact sweep + pattern conformance |
| `/testkit` | BDD test generation using proven patterns |
| `/troubleshoot` | Cross-ecosystem debugging with evidence and traceability |
| `/create-kit` | Generate new repeatable Cursor workflow kits |

## Required capabilities
- **Project structure**: `.cursor/commands/`, `.cursor/rules/`, `.cursor/skills/**/SKILL.md`
- **Cross-repo**:
  - **MCP-S**: classification + internal docs/spec hints
  - **Octocode**: authoritative cross-repo resolver (triggered via `/octocode/research`)
  - If MCPs are unavailable: non-local symbols must be **NOT FOUND** with searches + scope.

## Proof & verification rules
- “File exists” is not enough.
- Validate connectivity by evidence:
  - import → usage
  - call site → implementation
  - route/RPC binding → handler
  - cross-repo claim → Octocode proof
- Verify gates are mandatory before publish (commands enforce this via `.cursor/rules/**`).

## Canonical kit structure (reference)
See `README.md` for the full human-oriented overview and examples.

Key locations:
- `.cursor/commands/` - Orchestrators and step subcommands
- `.cursor/rules/` - Enforceable laws/guardrails per workflow
- `.cursor/skills/` - Skill metadata + instructions (progressive disclosure)
- `.cursor/kits/` - Workflow artifacts/templates for kits

