---
description: Analyze Figma design or parse semantic requirements
globs:
alwaysApply: false
---

# /implement-ui.analyze — Design Analysis

Extract actionable specs from the input.

## Prerequisites

- UI-SPEC exists at `.cursor/implement-ui/<task>/UI-SPEC.md`

## Figma Mode

### Step 1: Use WDS figma-to-code prompt

Call the `figma-to-code` prompt from `wix-design-system-mcp`:

```
figma_url: <URL from UI-SPEC>
instructions: <any constraints from UI-SPEC>
```

### Step 2: Extract Design Elements

From the Figma, identify:
- Layout structure (flex, grid, sections)
- Typography (headings, body, labels)
- Colors (map to WDS theme tokens if possible)
- Spacing (margins, padding, gaps)
- Interactive elements (buttons, inputs, toggles)
- Icons used

### Step 3: Document in UI-SPEC

Update UI-SPEC with extracted specs under `## Design Analysis`.

---

## Semantic Mode

### Step 1: Parse Requirements

Break down the description into:
- UI elements needed (list each)
- Layout requirements
- Interaction behaviors
- Data/state requirements

### Step 2: Identify Ambiguities

If anything is unclear:
- Ask clarifying questions
- Don't assume—verify with user

### Step 3: Document in UI-SPEC

Update UI-SPEC with parsed requirements under `## Parsed Requirements`.

---

## WDS Component Check (MANDATORY)

Before proceeding:

1. Call `getComponentsList` from `wix-design-system-mcp`
2. For each UI element, check if WDS has a matching component
3. Flag any elements that need custom implementation

---

## Output

Update `.cursor/implement-ui/<task>/UI-SPEC.md` with analysis results.

When complete, say: "Analysis complete. Run `/implement-ui.plan`."
