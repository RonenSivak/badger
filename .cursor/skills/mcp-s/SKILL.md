# Skill: MCP-S Classification + Internal Docs Hints

## When to use
For every new abstraction/symbol/layer you encounter (SDK, service, facade, runtime).

## What to extract
- layer (UI/BFF/service/SDK/ambassador/runtime)
- generated vs runtime
- owner/team/domain
- internal docs/spec/ownership hints

## Hard rule
Docs are hints. After MCP-S gives hints, you MUST prove via code
(using Octocode if non-local).

## Output discipline
Write 1-line classifications into:
.cursor/deep-search/<feature>/mcp-s-notes.md
