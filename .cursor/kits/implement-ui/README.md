# Implement UI Kit

Create UI components from Figma designs or semantic descriptions using Wix Design System (WDS).

## What It Does

- Takes Figma URL or natural language description as input
- Maps requirements to WDS components
- Generates React + TypeScript code
- Verifies output visually (Figma) or against requirements (semantic)

## Prerequisites

- React + TypeScript project
- Wix Design System installed (`wix-design-system` package)
- Required MCPs enabled in Cursor:
  - `wix-design-system-mcp` (required)
  - `cursor-ide-browser` (for Figma visual verification)
  - `octocode` (for pattern search)

## Quick Start

**From Figma:**
```
Use the implement-ui skill with: https://www.figma.com/design/abc123?node-id=1234
```

**From description:**
```
Use the implement-ui skill to create a settings panel with:
- Toggle switches for notifications
- Language dropdown
- Save button
```

## Workflow

1. **Clarify** — Determine input mode, gather requirements
2. **Analyze** — Extract specs from Figma OR parse semantic requirements
3. **Plan** — Map to WDS components, create hierarchy
4. **Implement** — Generate React+TS code
5. **Verify** — Visual comparison OR requirements checklist
6. **Publish** — Summary with usage instructions

## Structure

| Type | Location | Purpose |
|------|----------|---------|
| Skill | `.cursor/skills/implementing-ui/SKILL.md` | Main entry point |
| Guides | `.cursor/guides/` | Progressive disclosure |

## Generated During Runs

| File | Created By |
|------|------------|
| `UI-SPEC.md` | clarify |
| `COMPONENT-MAP.md` | plan |
| `VERIFICATION-REPORT.md` | verify |

## Key Rules

1. **Always check WDS components first** — Call `getComponentsList` before any work
2. **NOT FOUND = STOP** — Don't generate code for non-WDS components without asking
3. **Verify before publish** — Must pass verification gate
4. **Type everything** — All props typed with TypeScript
5. **Keep components small** — Split if > 150 lines

## Input Modes

| Mode | Input | Verification Method |
|------|-------|---------------------|
| Figma | URL with `node-id` | Browser screenshot comparison |
| Semantic | Natural language | Requirements checklist |

## MCP Tools Reference

### 1. `wix-design-system-mcp` — WDS Component Library (ALWAYS USE)

| Tool | Purpose |
|------|---------|
| `getComponentsList` | List all WDS components + dos/don'ts. **MUST call first** |
| `getComponentProps` | Get props for specific components (bulk supported) |
| `getComponentExamples` | Get code examples by ID (e.g., `button-all`) |
| `getIconsList` | List available icons |
| `verify` | Type-check JSX against tsconfig before applying |

### 2. `octocode` — GitHub Code Search (when component NOT FOUND)

| Tool | Purpose |
|------|---------|
| `githubSearchCode` | Search code with `owner="wix-private"` |
| `githubGetFileContent` | Read file content from a repo |

### 3. `cursor-ide-browser` — Visual Verification (Figma mode)

| Tool | Purpose |
|------|---------|
| `browser_navigate` | Open component URL |
| `browser_snapshot` | Capture screenshot for comparison |
