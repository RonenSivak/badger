---
description: Generate DRAFT Architecture Report (file only). Publishing is separate.
globs:
alwaysApply: false
---

# /deep-search.report — DRAFT ONLY

## Hard Rule
This command ONLY writes:
- `.cursor/deep-search/<feature>/ARCHITECTURE-REPORT.draft.md`

It MUST NOT print the report in chat.
Publishing is done by `/deep-search.publish`.

## Content
Include:
- MCP-S Evidence (internal docs, Slack threads, Jira tickets found)
- Trace Ledger (symbols with classification + proof)
- E2E Map (mermaid + edge evidence)
- SDK Generation Chain (if applicable)

Add a banner at top:

> DRAFT — must pass /deep-search.verify before publishing

End with:
- “Next: run /deep-search.verify (mandatory)”
