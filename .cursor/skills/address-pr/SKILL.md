# Address-PR Skill

Purpose: Help the agent efficiently handle GitHub PR review comments without auto-committing.

## Quick Start

```
User: "Address the review comments on PR #123"
Agent: Run /address-pr
```

## Workflow Overview

```
/address-pr.clarify  → PR-SPEC.md (what PR, scope, context)
      ↓
/address-pr.fetch    → COMMENTS.md (all comments with file/line/diff)
      ↓
/address-pr.triage   → TRIAGE.md (classify: actionable vs not)
      ↓
/address-pr.analyze  → ANALYSIS.md (deep dive on actionable)
      ↓
/address-pr.resolve  → Update ANALYSIS.md (cross-repo proofs)
      ↓
/address-pr.plan     → ACTION-PLAN.md (what to fix, how)
      ↓
/address-pr.verify   → VERIFICATION.md (check everything)
      ↓
/address-pr.publish  → REPORT.md (final summary)
```

## Key Principles

### 1. Never Auto-Commit
All changes are planned but never executed. Human applies fixes.

### 2. Fetch First
Always use `gh api repos/{owner}/{repo}/pulls/{pr}/comments` before analysis.

### 3. Classify Before Analyzing
Don't deep-dive until you know what's actionable:
- `logic`, `security`, `style`, `refactor` → Actionable
- `nit` → Optional
- `question`, `praise` → Non-actionable

### 4. Proof Everything
Every claim needs:
- File path
- Line number
- Code snippet

### 5. Cross-Repo = Octocode
Non-local symbols require Octocode proof before verify can pass.

## Comment Classification Quick Reference

| Signal | Category | Actionable |
|--------|----------|------------|
| `\`\`\`suggestion` block | varies | YES |
| `nit:`, `nitpick` | nit | OPTIONAL |
| `LGTM`, `looks good` | praise | NO |
| `?`, `why` | question | NO |
| `bug`, `wrong`, `broken` | logic | YES |
| `security`, `unsafe` | security | YES |

## gh CLI Commands

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
└── REPORT.md         # From publish
```

## When to Use Each MCP

| Situation | Tool |
|-----------|------|
| Non-local symbol | Octocode (mandatory) |
| Linked Jira ticket | MCP-S Jira |
| Code ownership question | MCP-S DevEx |
| Historical context | MCP-S Slack |
| Static analysis claim | ESLint/TSC |

## Error Recovery

If verification fails:
1. Check which check failed in VERIFICATION.md
2. Go back to the relevant step
3. Fix the issue
4. Re-run from that step forward
5. Re-verify

## Anti-Patterns

- Starting analysis without fetching comments first
- Skipping triage and analyzing everything equally
- Making claims without file:line proof
- Using non-local symbols without Octocode
- Publishing before verify passes
- **Auto-committing anything** (NEVER do this)
