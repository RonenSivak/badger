---
name: continuing-sessions
description: "Resume a prior session from context dump files. Use when starting a fresh agent after context was dumped due to budget limits."
---

# Continuing Sessions

Resume a workflow from dumped context files (`context-*.md` and `plan-*.md`).

## Quick Start
1. User says "Continue from `.cursor/session-memory/`"
2. List available session files
3. Load context.md and plan.md
4. Verify state is consistent
5. Resume from the plan's "Next Steps"

## When This Skill is Triggered
User starts a new agent and says one of:
- "Continue from `.cursor/session-memory/`"
- "Resume where we left off"
- "Pick up from the last session"

## Session Files Location
`.cursor/session-memory/`
- `context-<topic>-<date>.md` — Important context
- `plan-<topic>-<date>.md` — Progress and remaining work

## Step 1: List Available Sessions
```
AskQuestion:
  title: "Resume Session"
  questions:
    - id: "session"
      prompt: "Which session to resume?"
      options:
        - { id: "latest", label: "Latest session (most recent)" }
        - { id: "list", label: "Show me all available sessions" }
```

## Step 2: Load Session Files
Read both files from the selected session:
1. `context-<topic>-<date>.md` — Contains:
   - Original user request
   - Key discoveries and decisions
   - Important file paths and symbols
   - Artifacts created so far
   - Critical context that must not be lost

2. `plan-<topic>-<date>.md` — Contains:
   - Workflow being executed
   - Completed steps (with checkmarks)
   - Remaining steps
   - Current step details
   - Next action to take

## Step 3: Verify State
Before resuming, verify:
- [ ] Both context.md and plan.md exist
- [ ] Referenced artifacts/files exist
- [ ] No conflicting changes since dump

If verification fails, ask user:
```
AskQuestion:
  title: "State Conflict"
  questions:
    - id: "conflict"
      prompt: "Some referenced files changed. How to proceed?"
      options:
        - { id: "continue", label: "Continue anyway" }
        - { id: "refresh", label: "Re-read changed files first" }
        - { id: "restart", label: "Start fresh" }
```

## Step 4: Resume Workflow
1. Announce what you're resuming: "Resuming <workflow> for <topic>"
2. Show completed steps (from plan.md)
3. Start executing from "Next Steps"
4. Continue the workflow normally

## Context File Template (for dumping)
When dumping context, use this structure:
```markdown
# Context Dump: <topic>
Date: <ISO timestamp>
Workflow: <skill name>

## Original Request
<what user asked for>

## Key Discoveries
- <important finding 1>
- <important finding 2>

## Important Paths & Symbols
- `path/to/file.ts` — <why it matters>
- `SymbolName` — <what it is>

## Artifacts Created
- `.cursor/<workflow>/<topic>/FILE.md`

## Critical Context
<anything a new agent MUST know>
```

## Plan File Template (for dumping)
When dumping plan, use this structure:
```markdown
# Plan: <topic>
Date: <ISO timestamp>
Workflow: <skill name>

## Completed Steps
- [x] Step 1 — <brief result>
- [x] Step 2 — <brief result>

## Remaining Steps
- [ ] Step 3 — <what needs to happen>
- [ ] Step 4 — <what needs to happen>

## Current Step Details
<details about where we stopped>

## Next Action
**Do this first:** <specific next action>
```

## Hard-fail Conditions
- Resuming without reading both context.md and plan.md
- Skipping verification step
- Ignoring "Next Action" from plan
