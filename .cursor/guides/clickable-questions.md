---
description: How to present interactive clickable options using the AskQuestion tool
globs:
alwaysApply: false
---

# Clickable Questions Pattern

Use the `AskQuestion` tool to present interactive options that users can click in Cursor's UI.

## When to Use AskQuestion

**Use for:**
- Multiple-choice questions with predefined options
- Yes/no or confirmation prompts
- Selection from enumerated lists (kits, strategies, goals)
- Routing decisions between workflows

**Keep as plain text for:**
- Open-ended questions ("What feature?", "Describe the bug")
- Questions requiring file paths, code snippets, or free-form input
- Follow-up questions after "Other/Custom" selection

## Tool Schema

```json
{
  "title": "Optional title for the form",
  "questions": [
    {
      "id": "unique-question-id",
      "prompt": "Question text displayed to user",
      "options": [
        {"id": "opt1", "label": "First option"},
        {"id": "opt2", "label": "Second option"}
      ],
      "allow_multiple": false
    }
  ]
}
```

**Parameters:**
- `title` (optional): Header text for the question form
- `questions` (required): Array of question objects (minimum 1)
- `id` (required): Unique identifier for matching answers
- `prompt` (required): The question text
- `options` (required): Array of choices (minimum 2)
- `allow_multiple` (optional): If true, user can select multiple options (default: false)

## Common Patterns

### Single-Choice Routing

```json
{
  "title": "Select workflow",
  "questions": [{
    "id": "route",
    "prompt": "What would you like to do?",
    "options": [
      {"id": "deep-search", "label": "Deep-search architecture (cross-repo proof)"},
      {"id": "troubleshoot", "label": "Troubleshoot bug (runtime evidence)"},
      {"id": "implement", "label": "Implement change (from deep-search artifacts)"},
      {"id": "review", "label": "Review changes (impact + conformance)"},
      {"id": "other", "label": "Other (describe)"}
    ]
  }]
}
```

### Yes/No Confirmation

```json
{
  "questions": [{
    "id": "confirm",
    "prompt": "Proceed with this approach?",
    "options": [
      {"id": "yes", "label": "Yes, proceed"},
      {"id": "no", "label": "No, let me reconsider"}
    ]
  }]
}
```

### MCP Missing Prompt

```json
{
  "questions": [{
    "id": "mcp-octocode",
    "prompt": "MCP \"user-octocode\" is missing/not active. How should we proceed?",
    "options": [
      {"id": "added", "label": "I enabled/added it now (recheck)"},
      {"id": "skip", "label": "Proceed without it (degraded mode)"},
      {"id": "other", "label": "Other / help me set it up"}
    ]
  }]
}
```

### Kit/Item Selection

```json
{
  "questions": [{
    "id": "kit-select",
    "prompt": "Which kit do you want to update?",
    "options": [
      {"id": "deep-search", "label": "deep-search"},
      {"id": "troubleshoot", "label": "troubleshoot"},
      {"id": "review", "label": "review"},
      {"id": "testkit", "label": "testkit"}
    ]
  }]
}
```

### Multi-Select (allow_multiple: true)

```json
{
  "questions": [{
    "id": "update-goals",
    "prompt": "What update goals? (select all that apply)",
    "options": [
      {"id": "full", "label": "Full refresh (align to best practices)"},
      {"id": "frontmatter", "label": "Frontmatter only"},
      {"id": "rules", "label": "Add missing rules"},
      {"id": "skill", "label": "Add missing skill"},
      {"id": "refs", "label": "Fix references"}
    ],
    "allow_multiple": true
  }]
}
```

### Multiple Questions in One Call

```json
{
  "title": "Review Configuration",
  "questions": [
    {
      "id": "target-type",
      "prompt": "What should I review?",
      "options": [
        {"id": "pr", "label": "PR link / PR number"},
        {"id": "branch", "label": "Branch name"},
        {"id": "commits", "label": "Commit range"},
        {"id": "diff", "label": "Diff already open in editor"}
      ]
    },
    {
      "id": "goal",
      "prompt": "What's the goal?",
      "options": [
        {"id": "safety", "label": "Merge safety"},
        {"id": "arch", "label": "Architecture correctness"},
        {"id": "regression", "label": "Regression risk"},
        {"id": "release", "label": "Readiness for release"},
        {"id": "coverage", "label": "Test coverage gaps"}
      ]
    }
  ]
}
```

## Handling Responses

After `AskQuestion` returns, check the selected option IDs:

- If user selects an "other" or "custom" option, follow up with an open-ended text question
- If user selects "added" for MCP, re-run the probe check
- Use the selected ID to branch logic or populate spec fields

## Dynamic Options

For questions where options depend on runtime data (e.g., list of session files, available kits):

1. First gather the data (scan directory, list files)
2. Build the options array dynamically
3. Call `AskQuestion` with the generated options

Example for session files:
```
1. Scan `.cursor/session-memory/` for `session-memory-*.md` files
2. Build options: [{id: "file1", label: "session-memory-auth-flow-2026-02-01.md"}, ...]
3. Call AskQuestion with the dynamic options array
```
