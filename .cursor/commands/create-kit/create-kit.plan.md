---
description: Create a concrete plan + file map for the new kit
globs:
alwaysApply: false
---

# /create-kit.plan — Plan + File Map

Use the KIT SPEC (from clarify) to generate:

1) `.cursor/kits/<kit-name>/KIT-SPEC.md`
   - the finalized spec
   - the required tools/MCPs and when they must be used
   - quality gates + “NOT FOUND” discipline if applicable

2) `.cursor/kits/<kit-name>/FILE-MAP.md`
   - every file path that will be created
   - for each file: role + who references it

Plan rules:
- Keep command files procedural (workflow steps).
- Keep rules short + enforceable (gates/laws).
- Use modular subcommands to reduce context bloat. :contentReference[oaicite:1]{index=1}
- Prefer verifiable goals + verification steps (lint/tests/graph wiring). :contentReference[oaicite:2]{index=2}

End with: “Run `/create-kit.scaffold`.”
