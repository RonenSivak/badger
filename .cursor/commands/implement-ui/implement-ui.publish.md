---
description: Publish summary of implemented UI
globs:
alwaysApply: false
---

# /implement-ui.publish — Summary

Publish the final summary and usage instructions.

## Prerequisites

- VERIFICATION-REPORT shows PASS

## Gate

**HARD FAIL** if verification not passed. Do not publish.

---

## Summary Output

Print in chat:

```markdown
## ✅ UI Implementation Complete

### What Was Built
<brief description>

### Files Created/Modified
- `path/to/Component.tsx` (new)
- `path/to/styles.module.scss` (new)
- ...

### WDS Components Used
- Button, Card, Input, ...

### How to Use

\`\`\`tsx
import { MyComponent } from './path/to/MyComponent';

<MyComponent prop1="value" />
\`\`\`

### Props

| Prop | Type | Required | Description |
|------|------|----------|-------------|
| ... | ... | ... | ... |

### Notes
- <any special notes>
- <any follow-up recommendations>
```

---

## Cleanup

Optionally mention:
- Delete `.cursor/implement-ui/<task>/` if no longer needed
- Or keep for reference

---

## Done

Say: "UI implementation published. Component ready to use."
