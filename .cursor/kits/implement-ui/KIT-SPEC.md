# implement-ui Kit Specification

## Overview

Create UI components from Figma designs (URL) or semantic descriptions using Wix Design System (WDS) components. Supports React + TypeScript.

## Input Modes

| Mode | Input | Verification |
|------|-------|--------------|
| **Figma** | Figma URL with node-id | Visual comparison via browser screenshot |
| **Semantic** | Natural language description | Requirements checklist 100% coverage |

## Orchestrator Command

`/implement-ui`

## Subcommands

| Command | Purpose |
|---------|---------|
| `/implement-ui.clarify` | Determine input mode (Figma vs semantic), gather requirements |
| `/implement-ui.analyze` | Extract design specs from Figma OR parse semantic requirements |
| `/implement-ui.plan` | Map requirements to WDS components, create component hierarchy |
| `/implement-ui.implement` | Generate React+TS code using WDS |
| `/implement-ui.verify` | Visual comparison (Figma) OR requirements checklist (semantic) |
| `/implement-ui.publish` | Summary of what was built, usage notes |

## Required MCPs

| MCP | When Required | Purpose |
|-----|---------------|---------|
| `wix-design-system-mcp` | Always | Component lookup, props, examples |
| `octocode` | When searching patterns | Find real-world WDS usage in wix-private/wix-playground |
| `mcp-s` | Optional | Documentation lookup |
| `cursor-ide-browser` | Figma mode verification | Navigate to running app, take screenshot for comparison |

## WDS MCP Tools Usage

1. **MUST** call `getComponentsList` before any component work
2. Use `getComponentProps` to get available props for selected components
3. Use `getComponentExamples` to see correct usage patterns
4. Use `figma-to-code` prompt when Figma URL is provided

## Quality Gates

### Figma Mode
- [ ] Visual comparison: rendered component matches Figma design
- [ ] All visible elements mapped to WDS components
- [ ] Responsive behavior matches design specs (if specified)

### Semantic Mode
- [ ] All stated requirements covered
- [ ] Component renders without errors
- [ ] Props typed correctly
- [ ] Follows WDS dos/don'ts

## Scope

- **Single component**: e.g., "build a Card component"
- **Full page/screen**: e.g., "build the Settings page"
- User specifies scope in clarify phase

## Outputs Generated

| File | Created By | Purpose |
|------|------------|---------|
| `.cursor/implement-ui/<task>/UI-SPEC.md` | clarify | Requirements + input mode |
| `.cursor/implement-ui/<task>/COMPONENT-MAP.md` | plan | WDS component mapping |
| `.cursor/implement-ui/<task>/VERIFICATION-REPORT.md` | verify | Pass/fail + evidence |

## Example Prompts

**Figma mode:**
```
/implement-ui https://www.figma.com/design/abc123?node-id=1234
```

**Semantic mode:**
```
/implement-ui Create a settings panel with:
- Toggle switches for email notifications
- Dropdown for language selection
- Save button at the bottom
```

## Browser MCP for Verification

If `cursor-ide-browser` is not available, the kit will:
1. Inform user it's needed for visual verification
2. Provide installation instructions
3. Fall back to manual verification checklist

## NOT FOUND Discipline

If a requested component is NOT in WDS:
1. STOP - do not generate code
2. Inform user: "X is not an official WDS component"
3. Ask: "Search wix-private/wix-playground for similar implementations?"
4. Wait for confirmation before proceeding
