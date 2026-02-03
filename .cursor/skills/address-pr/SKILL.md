---
name: address-pr
description: "Address GitHub PR review comments. Trigger: /address-pr <pr-number>"
disable-model-invocation: true
---

# Address-PR Skill

Handle GitHub PR review comments end-to-end in **git read-only mode**.

## Quick Start

```bash
/address-pr 123          # Address PR #123 comments
```

## Key Rules

1. **Git Read-Only** — No commits, no pushes, no PR modifications
2. **Address ALL** — Every comment gets FIX or RESPONSE
3. **Output Table** — Summary with status for each comment

## Full Documentation

See `.cursor/commands/address-pr.md` for workflow steps, triage rules, and output format.
