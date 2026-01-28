---
description: Clarify UI implementation requirements (Figma URL or semantic description)
globs:
alwaysApply: false
---

# /implement-ui.clarify — Clarification Loop

Determine input mode and gather requirements until UI-SPEC is complete.

## Questions to Ask

### 1. Input Mode
"Do you have a Figma URL or a semantic description?"

- **Figma**: Get the full URL including `node-id` parameter
- **Semantic**: Get detailed natural language description

### 2. Scope
"What's the scope?"

- Single component (Button, Card, Modal)
- Multiple related components (Form with fields)
- Full page/screen

### 3. Target Location
"Where should the component(s) be created?"

- File path(s) for output
- Existing file to modify (if any)

### 4. Constraints
- Must match existing patterns in codebase?
- Specific state management requirements?
- Responsive breakpoints?
- Accessibility requirements?

### 5. Acceptance Criteria (verifiable)
- What makes this "done"?
- Any specific interactions to support?

---

## Output: UI-SPEC

When clarification is complete, create:

`.cursor/implement-ui/<task>/UI-SPEC.md`

```markdown
# UI Spec: <task-name>

## Input Mode
- [ ] Figma: <URL>
- [ ] Semantic: <description>

## Scope
<single-component | multi-component | page>

## Target Files
- <path/to/Component.tsx>

## Requirements
1. <requirement 1>
2. <requirement 2>
...

## Constraints
- <constraint 1>
- <constraint 2>

## Acceptance Criteria
- [ ] <criterion 1>
- [ ] <criterion 2>
```

When complete, say: "UI-SPEC created. Run `/implement-ui.analyze`."
