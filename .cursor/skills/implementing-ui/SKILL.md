---
name: implementing-ui
description: "Create UI components from Figma designs or semantic descriptions using Wix Design System, with a clarify→plan→implement→verify workflow. Use when implementing UI and you must map to WDS components."
---

# Implementing UI

Create UI components from Figma designs or semantic descriptions using Wix Design System.

## Quick Start

```
/implement-ui <figma-url>
```
or
```
/implement-ui <semantic description>
```

## Workflow

1. **Clarify** → Determine input mode, gather requirements → `UI-SPEC.md`
2. **Analyze** → Extract specs from Figma OR parse requirements
3. **Plan** → Map to WDS components → `COMPONENT-MAP.md`
4. **Implement** → Generate React+TS code
5. **Verify** → Visual comparison OR requirements checklist → `VERIFICATION-REPORT.md`
6. **Publish** → Summary + usage notes

## Input Modes

| Mode | Input | Verification |
|------|-------|--------------|
| Figma | URL with node-id | Browser screenshot comparison |
| Semantic | Natural language | Requirements checklist |

## Key Rules

1. **Always call `getComponentsList` first** before any component work
2. **NOT FOUND = STOP** — Don't generate code for non-WDS components without asking
3. **Verify before publish** — Must pass verification gate

---

## MCP Reference

### 1. `wix-design-system-mcp` — WDS Component Library (ALWAYS USE)

| Tool | Purpose |
|------|---------|
| `getComponentsList` | List all WDS components + dos/don'ts. **MUST call first** |
| `getComponentProps` | Get props for specific components |
| `getComponentExamples` | Get code examples (e.g., `button-all`) |
| `getIconsList` | List available icons |
| `verify` | Type-check JSX before applying |

**Prompt:** `figma-to-code` — Convert Figma URL to React code

### 2. `octocode` — GitHub Code Search (when NOT FOUND)

| Tool | Purpose |
|------|---------|
| `githubSearchCode` | Search code with `owner="wix-private"` or `owner="wix-playground"` |
| `githubGetFileContent` | Read file from repo |
| `githubViewRepoStructure` | Explore repo structure |
| `packageSearch` | Find npm package source repos |

### 3. `MCP-S` — Wix Internal Services (optional)

| Tool | Purpose |
|------|---------|
| `figma__get-file-nodes` | Extract Figma design data directly |
| `docs-schema__search_docs` | Search Wix internal docs |
| `chrome-devtools__take-screenshot` | Browser screenshot (alt to cursor-ide-browser) |

### MCP Decision Matrix

| Need | MCP | Tool |
|------|-----|------|
| List WDS components | `wix-design-system-mcp` | `getComponentsList` |
| Get component props | `wix-design-system-mcp` | `getComponentProps` |
| Verify JSX types | `wix-design-system-mcp` | `verify` |
| Convert Figma to code | `wix-design-system-mcp` | `figma-to-code` prompt |
| Component NOT in WDS | `octocode` | `githubSearchCode` |
| Read Figma data | `MCP-S` | `figma__get-file-nodes` |
| Search Wix docs | `MCP-S` | `docs-schema__search_docs` |

---

## Examples

**Figma:**
```
/implement-ui https://www.figma.com/design/abc?node-id=123
```

**Semantic:**
```
/implement-ui Create a settings panel with:
- Toggle for notifications
- Language dropdown
- Save button
```

## Files Generated

```
.cursor/implement-ui/<task>/
├── UI-SPEC.md           # Requirements
├── COMPONENT-MAP.md     # WDS mapping
└── VERIFICATION-REPORT.md  # Pass/fail
```