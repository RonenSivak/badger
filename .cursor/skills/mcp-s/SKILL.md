---
name: mcp-s
description: "Use MCP-S internal knowledge tools (docs, Slack, Jira, DevEx) to answer questions code cannot, then verify claims via code/Octocode. Use when ownership, intent, requirements, or generated pipelines are unclear."
---

# Skill: MCP-S (minimal)

This skill is intentionally minimal. Critical MCP-S rules are **passive context**:
- `@.cursor/rules/shared/011-mcp-s-mandate.mdc`
- `@.cursor/rules/shared/001-proof-discipline.mdc`

Use MCP-S to gather **internal context** (docs/Slack/Jira/DevEx/observability), then treat it as **hints** and prove code edges separately (Octocode when non-local).

Log queries + findings to the kit’s evidence artifact (kit-specific).
