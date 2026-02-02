---
description: Create a concrete plan + file map for the agent harness in the target repo
globs:
alwaysApply: false
---

# /create-agent.plan — Plan + File Map

Inputs:
- `<repo-root>/AGENT-SPEC.md`

Goal:
Produce:
1) `<repo-root>/.cursor/agent-setup/FILE-MAP.md` (every file to create/modify)
2) `<repo-root>/.cursor/agent-setup/AGENTS-CONTENT.md` (the exact `AGENTS.md` content to write)

Plan rules (based on Vercel’s AGENTS.md findings):
- Prefer **passive context** over skills when possible.
- Keep `AGENTS.md` compact (aim for \~8–10KB).
- Prefer **indexes and links** over copying large docs.
- Put workflow behavior in `.cursor/commands/` and enforceable gates in `.cursor/rules/`.

Required `AGENTS.md` content:
- A top instruction: “Prefer retrieval-led reasoning over pre-training-led reasoning.”
- A short “how this repo works” section.
- A “commands to run” section (build/test/lint) if known.
- A “where to look” index that points to the repo’s canonical docs and folders.

FILE-MAP requirements:
- Every path is absolute or clearly relative to `<repo-root>`.
- Each file includes: purpose + referenced by.
- Mark each entry as: create | update.

End with: “Run `/create-agent.scaffold`.”

