---
description: Map UI requirements to WDS components and create component hierarchy
globs:
alwaysApply: false
---

# /implement-ui.plan — Component Mapping

Create a concrete plan mapping requirements to WDS components.

## Prerequisites

- UI-SPEC exists with analysis/parsed requirements

## Step 1: Get WDS Components List

Call `getComponentsList` from `wix-design-system-mcp`.

Review available components and their dos/don'ts.

## Step 2: Map Each UI Element

For each element identified in analysis:

| UI Element | WDS Component | Notes |
|------------|---------------|-------|
| Primary button | `<Button priority="primary">` | |
| Toggle switch | `<ToggleSwitch>` | |
| ... | ... | ... |

## Step 3: Get Props for Selected Components

Call `getComponentProps` with array of component names.

Document required vs optional props for each.

## Step 4: Check for Examples

Call `getComponentExamples` for complex components.

Note any patterns to follow.

## Step 5: Handle NOT FOUND

If a required UI element has no WDS match:

1. **STOP** - do not guess
2. Inform user: "X is not an official WDS component"
3. Ask: "Search wix-private/wix-playground for implementations?"
4. If yes, use octocode to search with `owner="wix-private"` or `owner="wix-playground"`

## Step 6: Create Component Hierarchy

```
<PageContainer>
  <Header>
    <Heading />
  </Header>
  <Content>
    <Card>
      <FormField>
        <Input />
      </FormField>
      <Button />
    </Card>
  </Content>
</PageContainer>
```

---

## Output: COMPONENT-MAP

Create `.cursor/implement-ui/<task>/COMPONENT-MAP.md`:

```markdown
# Component Map: <task-name>

## WDS Components Used

| Component | Version | Import |
|-----------|---------|--------|
| Button | latest | `import { Button } from 'wix-design-system'` |
| ... | ... | ... |

## Component Hierarchy

<tree structure>

## Props Summary

### Button
- `priority`: "primary" | "secondary"
- `onClick`: handler
- ...

### ...

## Custom Components Needed
- <none> OR
- <component name>: <reason>

## Implementation Order
1. <component 1> (no dependencies)
2. <component 2> (depends on 1)
...
```

When complete, say: "COMPONENT-MAP created. Run `/implement-ui.implement`."
