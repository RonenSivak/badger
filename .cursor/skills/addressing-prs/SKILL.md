---
name: addressing-prs
description: "Handle GitHub PR review comments end-to-end in git read-only mode. Use when you need to address all PR review comments, producing a summary table with FIX or RESPONSE for each."
---

# Addressing PRs

Handle PR review comments: fetch → triage → analyze → plan → verify → publish.

## Git Read-Only Mode (MANDATORY)
**FORBIDDEN:**
- `git commit`, `git push`
- `gh pr comment`, `gh pr review`
- Any action that modifies git history or PR state

**ALLOWED:**
- `git status`, `git log`, `git diff` (read-only)
- `gh api` for fetching data
- `gh pr view`

## Quick Start
1. Clarify which PR to address
2. Fetch all comments
3. Triage (FIX vs RESPONSE)
4. Analyze each comment deeply
5. Plan resolutions
6. Verify completeness
7. Publish summary table

## Workflow Checklist
Copy and track your progress:
```
- [ ] PR identified and spec created
- [ ] All comments fetched
- [ ] Comments triaged (FIX vs RESPONSE)
- [ ] Deep analysis completed
- [ ] Cross-repo proofs gathered (Octocode)
- [ ] Action plan created
- [ ] Verification passed
- [ ] Summary table published
```

## Address ALL Comments (NO EXCEPTIONS)
Every comment MUST be addressed:
- `FIX` — Code change needed
- `RESPONSE` — Reply suggestion needed

There is no "non-actionable" category. Even praise/questions get a response suggestion.

## Output Format (Summary Table)

| # | Comment | Status | Solution |
|---|---------|--------|----------|
| 1 | {summary} | FIX | `{file}:{line}` — {change} |
| 2 | {summary} | RESPONSE | {suggested reply} |

## Comment Classification

| Signal | Status |
|--------|--------|
| `suggestion` block | FIX |
| `nit:`, `nitpick` | FIX |
| `LGTM`, `looks good` | RESPONSE |
| `?`, `why` | RESPONSE |
| `bug`, `wrong` | FIX |
| `security` | FIX |

## gh CLI Commands (READ-ONLY)
```bash
# Get PR number from current branch
gh pr view --json number --jq .number

# Fetch all review comments
gh api repos/{owner}/{repo}/pulls/{pr}/comments

# Get PR metadata
gh pr view {pr} --json title,body,author,baseRefName,headRefName
```

## Artifacts
All outputs go to `.cursor/address-pr/{pr-number}/`:
- `PR-SPEC.md` - PR context
- `COMMENTS.md` - All fetched comments
- `TRIAGE.md` - Classification
- `ANALYSIS.md` - Deep analysis
- `ACTION-PLAN.md` - Resolutions
- `REPORT.md` - Final with summary table

## Hard-fail Conditions
- Any git write operation (commit, push, pr comment)
- Publishing before verify
- Leaving any comment unaddressed
- Missing summary table
- Non-local symbols without Octocode proof
