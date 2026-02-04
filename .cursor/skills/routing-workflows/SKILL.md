---
name: routing-workflows
description: "Meta-orchestrator that routes to the right Badger workflow based on user intent. Use when starting a task and unsure which workflow to use, or for MCP preflight checks."
---

# Routing Workflows (RnD)

Meta-orchestrator: MCP preflight → route intent → delegate to workflow.

## Quick Start
1. Check context budget (if near limit, offer to dump)
2. Run MCP preflight (verify required MCPs available)
3. Route to the appropriate workflow (use clickable options)
4. Delegate to the selected workflow's skill

## Route Intent (ALWAYS use AskQuestion tool)
When intent is ambiguous, ask with clickable options:
```
AskQuestion:
  title: "What would you like to do?"
  questions:
    - id: "workflow"
      prompt: "Select the best workflow:"
      options:
        - { id: "deep-search", label: "Understand how something works (deep-searching)" }
        - { id: "troubleshoot", label: "Debug an issue (troubleshooting)" }
        - { id: "implement", label: "Implement a change (implementing)" }
        - { id: "review", label: "Review code/PR (reviewing)" }
        - { id: "test", label: "Add tests (testing)" }
        - { id: "other", label: "Other — I'll explain" }
```

## Workflow Selection

| User Goal | Use Skill | Why |
|-----------|-----------|-----|
| "How does X work end-to-end?" | `deep-searching` | E2E architecture forensics |
| "Implement this change safely" | `implementing` | Uses deep-search artifacts |
| "Build this UI from Figma/requirements" | `implement-ui` | WDS-first mapping |
| "This is broken / regression / perf issue" | `troubleshooting` | Runtime evidence first |
| "Review this change/PR" | `reviewing` | Conformance + impact |
| "Generate tests for this behavior" | `testing` | BDD specs + drivers |
| "Rename this symbol everywhere" | `renaming-symbols` | LSP + string sweep |
| "Simplify/refactor this code" | `optimizing-code` | Staged refactors |
| "Split this giant branch" | `git-branch-splitting` | Strategy + git techniques |
| "Merge/forward-port these branches" | `merging-branches` | Simulate/resolve/verify |
| "Address PR review comments" | `addressing-prs` | Fetch/triage/analyze |
| "Create a new kit" | `creating-kits` | KIT-SPEC + scaffold |

## MCP Preflight
Before starting any workflow, verify required MCPs:
- `user-octocode` - Cross-repo code proof
- `user-MCP-S` - Internal docs, Slack, Jira, DevEx, Grafana
- `user-MCP-S-root-cause` - Request ID tracing (for troubleshoot)
- `user-chrome-devtools` - Frontend debugging

If any MCP is missing:
1. Present options with AskQuestion tool
2. WAIT for user response
3. Proceed based on user choice

## Context Budget Gate
When context is near-full (~90%):
1. Ask user what to do:
   - Dump session memory to `.cursor/session-memory/`
   - Continue as usual
2. WAIT for user response
3. If dumping: use `continuing-sessions` skill to resume

## Quick Intent Detection
Listen for keywords:
- "debug", "broken", "not working" → `troubleshooting`
- "understand", "how does", "trace" → `deep-searching`
- "implement", "add", "build" → `implementing`
- "review", "check", "PR" → `reviewing`
- "test", "spec", "coverage" → `testing`

## Hard-fail Conditions
- Starting workflow without MCP preflight (if MCPs required)
- Continuing at 90%+ context without user acknowledgment
