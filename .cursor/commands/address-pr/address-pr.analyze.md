---
description: Deep analysis of ALL comments (FIX and RESPONSE); produce ANALYSIS.md
globs:
alwaysApply: false
---

# /address-pr.analyze — Deep Analysis

Input:
- `.cursor/address-pr/<pr-number>/TRIAGE.md`
- `.cursor/address-pr/<pr-number>/COMMENTS.md`

## Git Read-Only Reminder

**FORBIDDEN:** `git commit`, `git push`, `gh pr comment`, `gh pr review`

## For EVERY Comment (FIX and RESPONSE)

### For FIX comments:

1) **Read the code context**
   - Fetch the file at the commented line
   - Include surrounding context (±10 lines)
   - Check imports and dependencies

2) **Understand the reviewer's intent**
   - What problem are they pointing out?
   - Is there a suggested fix in the comment?
   - Parse suggestion blocks if present

3) **Validate the concern**
   - Is the reviewer's observation correct?
   - Does the code actually have the issue?
   - Cross-reference with existing patterns

4) **Assess complexity**
   - Simple fix (1-5 lines)
   - Moderate fix (refactor needed)
   - Complex fix (architectural change)

5) **Identify dependencies**
   - Does fixing this affect other files?
   - Are there tests that need updating?
   - Cross-repo implications?

### For RESPONSE comments:

1) **Understand the question/feedback**
   - What is the reviewer asking/saying?
   - What context do they need?

2) **Draft response**
   - For questions: prepare explanation
   - For praise: prepare acknowledgment

## Output

Write: `.cursor/address-pr/<pr-number>/ANALYSIS.md`

Template per comment:
```markdown
## Analysis: Comment #{id}

### Comment Summary
- **Category**: {logic|security|style|refactor|nit|question|praise}
- **Status**: {FIX|RESPONSE}
- **File**: {path}:{line} (or N/A for conversation comments)
- **Reviewer**: {author}

### Code Context (for FIX)
\`\`\`{lang}
{code with line numbers}
\`\`\`

### Reviewer's Concern/Question
{What they're pointing out or asking}

### For FIX:
- **Is concern valid?**: {YES|NO|PARTIAL}
- **Evidence**: {file:line or test result or linter output}
- **Effort**: {simple|moderate|complex}
- **Lines affected**: ~{estimate}
- **Files affected**: {list}
- **Cross-repo**: {yes/no — if yes, note for /address-pr.resolve}

### For RESPONSE:
- **Response type**: {explanation|acknowledgment|clarification}
- **Key points to address**: {list}
- **Draft response**: "{suggested reply text}"

### Suggestion Block (if present)
\`\`\`diff
{suggested change}
\`\`\`
```

Then instruct: "Run `/address-pr.resolve`."
