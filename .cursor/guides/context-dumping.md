# Context Dumping Guide

How to properly dump context when the budget is near 90% full.

## When to Trigger

Check context budget periodically during long workflows. When you estimate ~90% usage:

```
AskQuestion:
  title: "Context Budget Alert"
  questions:
    - id: "context_action"
      prompt: "Context is nearly full (~90%). What would you like to do?"
      options:
        - { id: "continue", label: "Continue as usual (risk truncation)" }
        - { id: "dump", label: "Dump context & plan for new agent" }
```

**WAIT for user response before proceeding.**

## If User Chooses "Dump"

Create two files in `.cursor/session-memory/`:

### 1. Context File
Filename: `context-<topic>-<YYYY-MM-DD>.md`

```markdown
# Context Dump: <topic>
Date: <ISO timestamp>
Workflow: <skill being used>

## Original Request
<exact user request that started this>

## Key Discoveries
<important findings that took effort to discover>
- Discovery 1: <details>
- Discovery 2: <details>

## Important Paths & Symbols
<files and symbols the new agent will need>
- `path/to/important/file.ts` — <why it matters>
- `path/to/another/file.ts` — <why it matters>
- `ImportantSymbol` — <what it is, where defined>

## Artifacts Created
<files we created during this session>
- `.cursor/<workflow>/<topic>/SPEC.md`
- `.cursor/<workflow>/<topic>/REPORT.md`

## Decisions Made
<choices we made and why>
- Decision 1: <what we decided> because <reason>
- Decision 2: <what we decided> because <reason>

## Critical Context
<anything a new agent MUST know to continue effectively>
```

### 2. Plan File
Filename: `plan-<topic>-<YYYY-MM-DD>.md`

```markdown
# Plan: <topic>
Date: <ISO timestamp>
Workflow: <skill being used>

## Progress Summary
<brief summary of what was accomplished>

## Completed Steps
- [x] Clarify — <result: spec defined>
- [x] Step 2 — <result: what was done>
- [x] Step 3 — <result: what was done>

## Remaining Steps
- [ ] Step 4 — <what needs to happen>
- [ ] Step 5 — <what needs to happen>
- [ ] Verify — <verification gates>
- [ ] Publish — <final output>

## Current Step Details
<where exactly we stopped, what was in progress>

## Blockers or Open Questions
<anything unresolved>
- Question 1: <details>
- Blocker 1: <details>

## Next Action
**Do this first when resuming:**
<specific, actionable next step>
```

## After Dumping

Tell user:
```
Context saved to:
- `.cursor/session-memory/context-<topic>-<date>.md`
- `.cursor/session-memory/plan-<topic>-<date>.md`

To continue:
1. Start a new agent
2. Say: "Continue from `.cursor/session-memory/`"
```

## Tips for Effective Dumps

1. **Be specific** — Include exact file paths, not vague descriptions
2. **Include decisions** — Why we chose approach A over B
3. **List artifacts** — Every file we created
4. **Clear next action** — The new agent should know exactly what to do first
5. **Don't dump everything** — Only what's needed to continue effectively

## Resume Protocol

New agent should:
1. Read both context.md and plan.md
2. Verify referenced files exist
3. Start from "Next Action" in plan.md
4. Use context.md as reference throughout

See [continuing-sessions skill](../skills/continuing-sessions/SKILL.md) for full resume protocol.
