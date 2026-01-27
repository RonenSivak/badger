---
description: Deep analysis of actionable comments; produce ANALYSIS.md
globs:
alwaysApply: false
---

# /address-pr.analyze — Deep Analysis

Input:
- `.cursor/address-pr/<pr-number>/TRIAGE.md`
- `.cursor/address-pr/<pr-number>/COMMENTS.md`

## For Each Actionable Comment

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

## Output

Write: `.cursor/address-pr/<pr-number>/ANALYSIS.md`

Template per comment:
```markdown
## Analysis: Comment #{id}

### Comment Summary
- **Category**: {logic|security|style|refactor}
- **File**: {path}:{line}
- **Reviewer**: {author}

### Code Context
\`\`\`{lang}
{code with line numbers}
\`\`\`

### Reviewer's Concern
{What they're pointing out}

### Validation
- **Is concern valid?**: {YES|NO|PARTIAL}
- **Evidence**: {file:line or test result or linter output}

### Complexity Assessment
- **Effort**: {simple|moderate|complex}
- **Lines affected**: ~{estimate}
- **Files affected**: {list}

### Dependencies
- Related files: {list}
- Tests to update: {list}
- Cross-repo: {yes/no — if yes, note for /address-pr.resolve}

### Suggestion Block (if present)
\`\`\`diff
{suggested change}
\`\`\`
```

Then instruct: "Run `/address-pr.resolve`."
