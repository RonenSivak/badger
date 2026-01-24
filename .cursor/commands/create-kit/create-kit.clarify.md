---
description: Clarify what kit to create (produces KIT SPEC inputs)
globs:
alwaysApply: false
---

# /create-kit.clarify — Clarification Loop

Ask questions until you can fill a **KIT SPEC**.

Start with:
1) “What kit do you want to create?”
2) “What is the main orchestrator command name?” (example: `/deep-review`, `/deep-debug`)
3) “What subcommands should it delegate to?” (names + 1-line purpose each)
4) “What hard laws must always be enforced?” (verify before publish, proof rules, etc.)
5) “What tools/MCPs are required?” (and when they’re mandatory)
6) “What files should the flow generate during a run?”

Then write a draft **KIT SPEC** in chat:

- Kit name:
- Orchestrator command:
- Subcommands:
- Rules:
- Skills:
- Required tools/MCPs:
- Outputs generated:
- Quality gates:
- Example user prompt:

If anything is ambiguous, ask follow-ups and iterate until complete.
When complete, instruct to run: `/create-kit.plan`.
