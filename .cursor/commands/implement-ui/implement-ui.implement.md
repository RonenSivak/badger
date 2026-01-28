---
description: Generate React+TypeScript code using WDS components
globs:
alwaysApply: false
---

# /implement-ui.implement — Code Generation

Generate the actual React + TypeScript code.

## Prerequisites

- UI-SPEC exists
- COMPONENT-MAP exists

## Rules (from implement-ui-laws)

1. **Use WDS components** from COMPONENT-MAP—no substitutions
2. **Type everything** with TypeScript
3. **Keep components small**—split if > 150 lines
4. **Follow WDS dos/don'ts** from getComponentsList
5. **Import from 'wix-design-system'**—not individual packages

## Implementation Flow

### Step 1: Create File Structure

Based on COMPONENT-MAP implementation order:
- Create parent components first
- Then child components
- Then compose

### Step 2: Generate Each Component

For each component in order:

```typescript
import React from 'react';
import { ComponentName } from 'wix-design-system';

interface MyComponentProps {
  // typed props
}

export const MyComponent: React.FC<MyComponentProps> = ({ props }) => {
  return (
    <ComponentName {...wdsProps}>
      {children}
    </ComponentName>
  );
};
```

### Step 3: Handle State

If component needs state:
- Use React hooks (useState, useReducer)
- Keep state close to where it's used
- Lift only when necessary

### Step 4: Handle Events

- Type all event handlers
- Use WDS component event signatures

### Step 5: Apply Styles

Prefer in order:
1. WDS component props (size, skin, priority)
2. WDS layout components (Box, Card, Layout)
3. CSS modules if custom styling needed

---

## Code Quality Checks

Before moving to verify:

- [ ] No TypeScript errors
- [ ] All imports resolve
- [ ] Component renders (if dev server running)
- [ ] Props match COMPONENT-MAP

---

## Iteration

If you need to adjust the plan:
1. Update COMPONENT-MAP
2. Note the change
3. Continue implementation

When complete, say: "Implementation complete. Run `/implement-ui.verify`."
