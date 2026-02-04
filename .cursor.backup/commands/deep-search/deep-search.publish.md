---
description: Publish FINAL report (only after validation) to chat + file
globs:
alwaysApply: false
---

# /deep-search.publish — FINAL Output (Chat + File)

## Preconditions (MANDATORY)
You MUST confirm `.cursor/deep-search/<feature>/VALIDATION-REPORT.md` shows:
- zero broken claims OR all remaining gaps are NOT FOUND with searches+scope.

If not, STOP and instruct to rerun `/deep-search.verify`.

## Output (Dual)
1) Write FINAL report to:
   `.cursor/deep-search/<feature>/ARCHITECTURE-REPORT.md`
2) Paste the SAME FINAL report into the chat response.

## Include Validation Summary at top
- Verified edges: N
- Broken claims fixed: N
- Remaining NOT FOUND: N (with scope)

## Quality Gates
- Every claim has repo/path + lines + snippet
- No dead ends
- MCP-S mandatory for internal knowledge (docs/Slack/Jira context)
- Octocode mandatory for code proof on non-local symbols
- No unresolved symbol crosses a boundary
- `mcp-s-notes.md` exists and has queries for major topics
