---
description: Resolve merge conflicts with codebase pattern matching + proof
globs:
alwaysApply: false
---

# /smart-merge.resolve — Resolve Conflicts 🧯

Rules:
- Fix conflicts by matching **existing codebase patterns** (naming, layering, error handling).
- Prefer "make both sides work" over deleting logic.
- For uncertain APIs/symbols: trigger Octocode mandate and record proof.
- **Use MCP-S for ownership + context** before making resolution decisions.

## MCP-S for Conflict Resolution
Before resolving each conflict:
1. `code_owners_for_path` — who owns each side of the conflict?
2. `slack__search-messages` — any context about why changes were made?
3. `jira__get-issues` — related tickets with requirements?

Log findings to: `.cursor/smart-merge/<name>/mcp-s-notes.md`

## Output
Write: `.cursor/smart-merge/<name>/CONFLICT-RESOLUTION.md`

Include:
- file list
- ownership info (from MCP-S code_owners)
- resolution decisions (why) + context (from Slack/Jira if found)
- any non-local symbols resolved via `/octocode/research` (link proof)

If you cannot resolve:
- mark NOT FOUND
- list searches + scope (both Octocode + MCP-S)
