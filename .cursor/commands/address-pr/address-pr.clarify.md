---
description: Clarify PR target and scope; produce PR-SPEC
globs:
alwaysApply: false
---

# /address-pr.clarify — Clarification Loop

## Git Read-Only Mode Reminder

**FORBIDDEN:** `git commit`, `git push`, `gh pr comment`, `gh pr review`

This entire workflow is read-only. Human applies all changes.

## Ask:

1) **What PR?** (pick one)
   - PR number (e.g., `#123`)
   - PR link (e.g., `https://github.com/org/repo/pull/123`)
   - "current branch" (derive from `gh pr view`)

2) **Scope constraints?**
   - All comments or specific files only
   - Specific reviewers to focus on
   - Include resolved comments?

3) **Context needed?**
   - Related Jira tickets
   - Slack threads
   - Previous PR discussions

Stop when you can write **PR-SPEC**:

Write: `.cursor/address-pr/<pr-number>/PR-SPEC.md`

Template:
```markdown
# PR-SPEC: PR #<number>

## Target
- Repo: {owner}/{repo}
- PR: #{number}
- Title: {title}
- Author: {author}
- Base: {base} ← Head: {head}

## Scope
- Files: [all | specific list]
- Reviewers: [all | specific list]
- Include resolved: [yes | no]

## Mode
- **Git read-only**: YES (no commits, pushes, or PR comments)
- **Address all comments**: YES (every comment gets FIX or RESPONSE)

## Context
- Jira: [tickets if any]
- Slack: [threads if any]
- Notes: [any additional context]

## Fetch command (read-only)
gh api repos/{owner}/{repo}/pulls/{number}/comments
```

Then instruct: "Run `/address-pr.fetch`."
