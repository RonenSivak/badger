---
description: Scaffold the agent harness files in the target repo from the FILE-MAP
globs:
alwaysApply: false
---

# /create-agent.scaffold — Scaffold

Inputs:
- `<repo-root>/AGENT-SPEC.md`
- `<repo-root>/.cursor/agent-setup/FILE-MAP.md`
- `<repo-root>/.cursor/agent-setup/AGENTS-CONTENT.md`

Actions:
1) Create directories from FILE-MAP.
2) Create/update files exactly as specified.
3) Prefer **minimal diffs**; do not refactor unrelated content.
4) Ensure `AGENTS.md` references existing docs (do not copy whole style guides).
5) If “hooks” were requested in AGENT-SPEC:
   - add `<repo-root>/.cursor/hooks.json`
   - add scripts under `<repo-root>/.cursor/hooks/` if referenced

Output:
- All scaffolding is done. Tell user to run `/create-agent.verify`.

