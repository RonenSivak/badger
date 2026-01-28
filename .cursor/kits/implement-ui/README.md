# /implement-ui Kit

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

## Install

Copy to your project:

```
.cursor/commands/implement-ui.md
.cursor/commands/implement-ui/
.cursor/rules/implement-ui/
.cursor/skills/implement-ui/
```

## Quick Start

**From Figma:**
```
/implement-ui https://www.figma.com/design/abc123?node-id=1234
```

**From description:**
```
/implement-ui Create a settings panel with:
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

## Files

### Commands

| File | Purpose |
|------|---------|
| `implement-ui.md` | Orchestrator |
| `implement-ui.clarify.md` | Gather requirements |
| `implement-ui.analyze.md` | Extract/parse specs |
| `implement-ui.plan.md` | Map to WDS components |
| `implement-ui.implement.md` | Generate code |
| `implement-ui.verify.md` | Verification gate |
| `implement-ui.publish.md` | Summary output |

### Rules

| File | Purpose |
|------|---------|
| `implement-ui-laws.mdc` | Workflow gates |
| `wds-mandate.mdc` | WDS usage rules |
| `octocode-mandate.mdc` | Pattern search rules |

### Skills

| File | Purpose |
|------|---------|
| `SKILL.md` | Quick reference |

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

**Prompt:** `figma-to-code` — Convert Figma URL to React code using WDS

### 2. `octocode` — GitHub Code Search (when component NOT FOUND)

| Tool | Purpose |
|------|---------|
| `githubSearchCode` | Search code with `owner="wix-private"` or `owner="wix-playground"` |
| `githubGetFileContent` | Read file content from a repo |
| `githubViewRepoStructure` | Explore repo folder structure |
| `githubSearchRepositories` | Find repos by name/description |
| `packageSearch` | Find npm packages and their source repos |

### 3. `MCP-S` — Wix Internal Services (optional extras)

| Tool | Purpose |
|------|---------|
| `figma__get-file-nodes` | Extract Figma design data directly |
| `figma__get-image` | Get images from Figma |
| `docs-schema__search_docs` | Search Wix internal documentation |
| `chrome-devtools__take-screenshot` | Browser screenshot (alternative to cursor-ide-browser) |
| `chrome-devtools__navigate-page` | Navigate browser |

### 4. `cursor-ide-browser` — Visual Verification (Figma mode)

| Tool | Purpose |
|------|---------|
| `browser_navigate` | Open component URL |
| `browser_lock` / `browser_unlock` | Lock browser for interactions |
| `browser_snapshot` | Capture screenshot for comparison |

### MCP Decision Matrix

| Need | MCP | Tool |
|------|-----|------|
| List WDS components | `wix-design-system-mcp` | `getComponentsList` |
| Get component props | `wix-design-system-mcp` | `getComponentProps` |
| Get code examples | `wix-design-system-mcp` | `getComponentExamples` |
| Verify JSX types | `wix-design-system-mcp` | `verify` |
| Convert Figma to code | `wix-design-system-mcp` | `figma-to-code` prompt |
| Component NOT in WDS | `octocode` | `githubSearchCode` with `owner="wix-private"` |
| Find npm package source | `octocode` | `packageSearch` |
| Read Figma file data | `MCP-S` | `figma__get-file-nodes` |
| Search Wix docs | `MCP-S` | `docs-schema__search_docs` |
| Take browser screenshot | `cursor-ide-browser` | `browser_snapshot` |
