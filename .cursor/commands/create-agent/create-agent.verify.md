---
description: Verify the created agent harness is wired and compact
globs:
alwaysApply: false
---

# /create-agent.verify — Verify

Verify all of the following from FILE-MAP:
- Every referenced file exists.
- `AGENTS.md` starts with retrieval-led reasoning guidance.
- `AGENTS.md` is compact:
  - no large pasted docs
  - uses an index and references instead
- No broken references (paths mentioned actually exist).
- If hooks were created:
  - `.cursor/hooks.json` exists
  - hook scripts exist at referenced paths

If anything fails:
- Fix the files
- Re-run `/create-agent.verify` until PASS

End with: “Run `/create-agent.publish`.”

