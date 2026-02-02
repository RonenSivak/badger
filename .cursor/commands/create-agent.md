---
description: Bootstrap an AI agent setup for a chosen repo (AGENTS.md + optional .cursor scaffolding) using Badger + Vercel best practices
globs:
alwaysApply: false
---

# /create-agent — Orchestrator

Create an “agent harness” in a target repo using best practices:
- Prefer passive context via `AGENTS.md` (retrieval-led, compressed index)
- Keep workflow logic in `.cursor/commands/`, enforceable gates in `.cursor/rules/`, and optional skills in `.cursor/skills/`

Workflow:
1) Clarify
2) Plan
3) Scaffold
4) Verify
5) Publish

Delegates to:
- `/create-agent.clarify`  → `.cursor/commands/create-agent/create-agent.clarify.md`
- `/create-agent.plan`     → `.cursor/commands/create-agent/create-agent.plan.md`
- `/create-agent.scaffold` → `.cursor/commands/create-agent/create-agent.scaffold.md`
- `/create-agent.verify`   → `.cursor/commands/create-agent/create-agent.verify.md`
- `/create-agent.publish`  → `.cursor/commands/create-agent/create-agent.publish.md`

## Step 1 — Clarify (MANDATORY)
Run `/create-agent.clarify` until a complete “AGENT SPEC” exists.

## Step 2 — Plan (MANDATORY)
Run `/create-agent.plan` to produce a FILE-MAP and a concrete content outline (compressed).

## Step 3 — Scaffold (MANDATORY)
Run `/create-agent.scaffold` to create the files in the target repo.

## Step 4 — Verify (MANDATORY)
Run `/create-agent.verify` to ensure:
- all files exist
- `AGENTS.md` is compact and references canonical project docs
- no broken references
- no duplicated “whole style guides” embedded

## Step 5 — Publish (MANDATORY)
Run `/create-agent.publish` to output:
- what was created/modified
- where to edit next
- how to extend safely

