---
name: implementation-verify
description: "Verify an implementation is correct and that the story connects in code (import→usage, callsite→impl, binding→handler), including Octocode proof for cross-repo hops and running standard checks. Use before publish."
---

# Skill: implementation-verify

Goal:
Verify that the implementation is correct AND that “the story connects” in code.

Checklist:
- For every new/edited hop:
  - import → usage proof
  - call site → implementation proof
  - binding → handler proof (routing/RPC/events)
- For cross-repo hops:
  - `/octocode/research` proof (def + impl + boundary)
- Run the repo’s standard checks:
  - build/typecheck
  - lint
  - tests relevant to acceptance criteria

NOT FOUND discipline:
If you can’t prove something:
- write NOT FOUND
- paste exact searches (local + octocode)
- list scope searched

Output:
- VALIDATION-REPORT.md with:
  - passed checks
  - failed checks
  - broken edges list
  - remaining NOT FOUND
