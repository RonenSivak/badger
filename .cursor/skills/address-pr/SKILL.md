---
name: address-pr
description: "Handle GitHub PR review comments end-to-end: fetch, triage (FIX vs RESPONSE), analyze, verify, and produce a summary table. Use when you need to address all PR review comments in a strict git read-only workflow."
---
# Address-PR Skill

Purpose: Handle GitHub PR review comments — address ALL comments, output a summary table, **git read-only mode**.

## Quick Start

```
User: "Address the review comments on PR #123"
Agent: Run /address-pr
```

## Core Principles

### 1. Git Read-Only Mode (MANDATORY)

**FORBIDDEN:**
- `git commit`, `git push`
- `gh pr comment`, `gh pr review`
- Any action that modifies git history or PR state

**ALLOWED:**
- `git status`, `git log`, `git diff` (read-only)
- `gh api` for fetching data
- `gh pr view`

### 2. Address ALL Comments

Every comment MUST be addressed — no exceptions:
- `FIX` — code change needed
- `RESPONSE` — reply suggestion needed

There is no "non-actionable" category. Even praise/questions get a response suggestion.

### 3. Output: Summary Table

Final output MUST include this table format:

| # | Comment | Status | Solution |
|---|---------|--------|----------|
| 1 | {summary} | FIX | `{file}:{line}` — {change description} |
| 2 | {summary} | RESPONSE | {suggested reply} |

## Workflow Overview

```
/address-pr.clarify  → PR-SPEC.md (what PR, scope, context)
      ↓
/address-pr.fetch    → COMMENTS.md (all comments with file/line/diff)
      ↓
/address-pr.triage   → TRIAGE.md (classify: FIX vs RESPONSE)
      ↓
/address-pr.analyze  → ANALYSIS.md (deep dive on all)
      ↓
/address-pr.resolve  → Update ANALYSIS.md (cross-repo proofs)
      ↓
/address-pr.plan     → ACTION-PLAN.md (what to fix/respond, how)
      ↓
/address-pr.verify   → VERIFICATION.md (check everything)
      ↓
/address-pr.publish  → REPORT.md + SUMMARY TABLE
```

## Comment Classification

| Signal | Category | Status |
|--------|----------|--------|
| `\`\`\`suggestion` block | varies | FIX |
| `nit:`, `nitpick` | nit | FIX |
| `LGTM`, `looks good` | praise | RESPONSE |
| `?`, `why` | question | RESPONSE |
| `bug`, `wrong`, `broken` | logic | FIX |
| `security`, `unsafe` | security | FIX |

## gh CLI Commands (READ-ONLY)

```bash
# Get PR number from current branch
gh pr view --json number --jq .number

# Fetch all review comments
gh api repos/{owner}/{repo}/pulls/{pr}/comments

# Get PR metadata
gh pr view {pr} --json title,body,author,baseRefName,headRefName

# Get conversation comments
gh pr view {pr} --json comments
```

## Output Directory Structure

```
.cursor/address-pr/{pr-number}/
├── PR-SPEC.md        # From clarify
├── COMMENTS.md       # From fetch
├── TRIAGE.md         # From triage
├── ANALYSIS.md       # From analyze + resolve
├── ACTION-PLAN.md    # From plan
├── VERIFICATION.md   # From verify
└── REPORT.md         # From publish (includes summary table)
```

## When to Use Each MCP

| Situation | Tool |
|-----------|------|
| Non-local symbol | Octocode (mandatory) |
| Linked Jira ticket | MCP-S Jira |
| Code ownership question | MCP-S DevEx |
| Historical context | MCP-S Slack |
| Static analysis claim | ESLint/TSC |

## Hard-Fail Conditions

- Any git write operation (commit, push, pr comment, pr review)
- Publishing before verify passes
- Leaving any comment unaddressed
- Non-local symbols without Octocode proof
- Missing summary table in final output

## Anti-Patterns

- **Any git write operation** (NEVER)
- Starting analysis without fetching comments first
- Skipping triage
- Making claims without file:line proof
- Using non-local symbols without Octocode
- Publishing before verify passes
- Leaving comments as "non-actionable" (ALL must be addressed)
