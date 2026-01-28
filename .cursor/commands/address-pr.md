---
description: Address PR review comments (clarify → fetch → triage → analyze → resolve → plan → verify → publish)
globs:
alwaysApply: false
---

# /address-pr — Orchestrator

Automate handling of GitHub PR review comments: fetch, triage, analyze, and plan resolutions.

## Git Read-Only Mode (MANDATORY)

**FORBIDDEN git operations:**
- `git commit`, `git push` — NEVER
- `gh pr comment`, `gh pr review` — NEVER
- Any action that modifies git history or PR state

**ALLOWED git operations:**
- `git status`, `git log`, `git diff` — OK (read-only)
- `gh api` for fetching data — OK
- `gh pr view` — OK

## Address ALL Comments

Every comment MUST be addressed — no exceptions:
- Status: `FIX` or `RESPONSE`
- No "non-actionable" category — even praise/questions get a response suggestion

## Workflow (must follow in order)

1) Clarify → `/address-pr.clarify`
2) Fetch comments → `/address-pr.fetch`
3) Triage/classify → `/address-pr.triage`
4) Deep analysis → `/address-pr.analyze`
5) Cross-repo resolution → `/address-pr.resolve`
6) Action plan → `/address-pr.plan`
7) Verify → `/address-pr.verify`
8) Publish report → `/address-pr.publish`

## Final Output Format

A summary table listing ALL comments:

| # | Comment | Status | Solution |
|---|---------|--------|----------|
| 1 | {summary} | FIX | {file:line + what changed} |
| 2 | {summary} | RESPONSE | {suggested reply} |

## Enforces (rules)

- [Address-PR Laws](../rules/address-pr/address-pr-laws.mdc)
- [Octocode Mandate](../rules/address-pr/octocode-mandate.mdc)
- [MCP-S Mandate](../rules/address-pr/mcp-s-mandate.mdc)

## Hard-fail conditions

- Any git write operation (commit, push, pr comment, pr review)
- Publishing before verify passes
- Triage before fetch completes
- Analysis before triage completes
- Non-local symbols without Octocode proof
- Claims without file + line + snippet proof
- **Leaving any comment unaddressed**

## gh CLI Commands Reference (READ-ONLY)

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
