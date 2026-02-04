---
description: Fetch all PR review comments via gh api (READ-ONLY); produce COMMENTS.md
globs:
alwaysApply: false
---

# /address-pr.fetch — Fetch Comments

Input:
- `.cursor/address-pr/<pr-number>/PR-SPEC.md`

## Git Read-Only Reminder

**FORBIDDEN:** `git commit`, `git push`, `gh pr comment`, `gh pr review`

**ALLOWED:** `gh api` (read), `gh pr view` (read)

## Actions

1) **Fetch review comments** via `gh api` (read-only):
```bash
gh api repos/{owner}/{repo}/pulls/{pr}/comments \
  --jq '.[] | {
    id: .id,
    author: .user.login,
    path: .path,
    line: (.line // .original_line),
    diff_hunk: .diff_hunk,
    body: .body,
    created_at: .created_at,
    in_reply_to_id: .in_reply_to_id
  }'
```

2) **Fetch PR conversation comments** (top-level, read-only):
```bash
gh pr view {pr} --json comments --jq '.comments[]'
```

3) **Parse and structure** each comment:
   - Comment ID
   - Author
   - File path + line number
   - Diff hunk (code context)
   - Comment body
   - Thread info (reply chains)

4) **Count verification**: Log total comments fetched — ALL will be addressed

## Output

Write: `.cursor/address-pr/<pr-number>/COMMENTS.md`

Template per comment:
```markdown
## Comment #{id}
- **Author**: {author}
- **File**: {path}:{line}
- **Created**: {created_at}

### Code Context
\`\`\`
{diff_hunk}
\`\`\`

### Comment
{body}

### Thread
- Reply to: {in_reply_to_id or "N/A"}
---
```

## Verification
- Total comments: {count} — **ALL will be addressed (FIX or RESPONSE)**
- Inline comments: {count}
- Conversation comments: {count}

Then instruct: "Run `/address-pr.triage`."
