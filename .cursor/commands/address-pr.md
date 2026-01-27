---
description: Address PR review comments (clarify → fetch → triage → analyze → resolve → plan → verify → publish)
globs:
alwaysApply: false
---

# /address-pr — Orchestrator

Automate handling of GitHub PR review comments: fetch, triage, analyze, and plan resolutions — **without auto-commit/push**.

## Workflow (must follow in order)

1) Clarify → `/address-pr.clarify`
2) Fetch comments → `/address-pr.fetch`
3) Triage/classify → `/address-pr.triage`
4) Deep analysis → `/address-pr.analyze`
5) Cross-repo resolution → `/address-pr.resolve`
6) Action plan → `/address-pr.plan`
7) Verify → `/address-pr.verify`
8) Publish report → `/address-pr.publish`

## Enforces (rules)

- [Address-PR Laws](../rules/address-pr/address-pr-laws.mdc)
- [Octocode Mandate](../rules/address-pr/octocode-mandate.mdc)
- [MCP-S Mandate](../rules/address-pr/mcp-s-mandate.mdc)

## Hard-fail conditions

- Publishing before verify passes
- Auto-commit or push (NEVER allowed)
- Triage before fetch completes
- Analysis before triage completes
- Non-local symbols without Octocode proof
- Claims without file + line + snippet proof

## gh CLI Commands Reference

```bash
# Get PR number from current branch
gh pr view --json number --jq .number

# Fetch all review comments with context
gh api repos/{owner}/{repo}/pulls/{pr}/comments \
  --jq '.[] | {id: .id, path: .path, line: .line, body: .body, diff_hunk: .diff_hunk}'

# Get PR metadata
gh pr view --json title,body,author,baseRefName,headRefName
```

## Start

Ask: "What PR should I address comments for? (PR number, link, or 'current branch')"
Then run `/address-pr.clarify`.
