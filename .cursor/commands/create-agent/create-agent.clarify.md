---
description: Gather target repo and requirements for agent setup
globs:
alwaysApply: false
---

# /create-agent.clarify — Clarify

Goal: produce a complete **AGENT SPEC** before any scaffolding.

Ask for (must fill all):
1) **Target repo root (absolute path)**:
   - Example: `/Users/ronensi/WebstormProjects/<repo>`

2) **Agent name** (for headings only):
   - Example: `MyProject AI`

3) **What to create** (choose one):
   - **Minimal**: `AGENTS.md` only
   - **Standard**: `AGENTS.md` + minimal `.cursor/rules/` (project rules)
   - **Full**: `AGENTS.md` + `.cursor/rules/` + `.cursor/commands/` (workflows) + `.cursor/skills/` (optional)

4) **Docs to index** (paths relative to repo root):
   - Example: `README.md`, `docs/ARCHITECTURE.md`, `CONTRIBUTING.md`, `packages/*/README.md`

5) **Hard constraints** to encode (short bullets):
   - package manager (`yarn`/`pnpm`/`npm`)
   - test/lint commands
   - “no breaking changes”, “no comments”, etc.

6) **Hooks**:
   - none
   - formatting only
   - formatting + dangerous-command blocking

Output file to create in the target repo:
- `AGENT-SPEC.md` (at repo root)

The `AGENT-SPEC.md` must include:
- Target repo root path
- Mode (Minimal/Standard/Full)
- File list to index
- Tooling commands (build/test/lint)
- Explicit “retrieval-led reasoning” instruction

End with: “Run `/create-agent.plan`.”

