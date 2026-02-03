# implement-ui Kit - Agent Instructions

IMPORTANT: Prefer retrieval-led reasoning. Read WDS MCP tools output, not training data.

## Commands
```bash
/implement-ui                    # Orchestrator
/implement-ui.clarify           # Determine input mode + requirements
/implement-ui.analyze           # Extract specs from Figma/semantic
/implement-ui.plan              # Map to WDS components
/implement-ui.implement         # Generate React+TS code
/implement-ui.verify            # Visual/requirements verification
/implement-ui.publish           # Summary output
```

## Required MCPs
| MCP | Tool | Purpose |
|-----|------|---------|
| `wix-design-system-mcp` | `getComponentsList` | **MUST call first** — list all WDS components |
| `wix-design-system-mcp` | `getComponentProps` | Get props for components |
| `wix-design-system-mcp` | `getComponentExamples` | Code examples by ID |
| `wix-design-system-mcp` | `verify` | Type-check JSX |
| `octocode` | `githubSearchCode` | When component NOT in WDS |
| `cursor-ide-browser` | `browser_snapshot` | Visual verification (Figma mode) |

## Code Style
- React 18 + TypeScript strict
- Functional components with hooks
- All props typed with interfaces
- Max 150 lines per component

## Boundaries

### ✅ Always
- Call `getComponentsList` before any component work
- Use WDS components over custom implementations
- Type all props with TypeScript interfaces
- Split components > 150 lines

### ⚠️ Ask First
- Using non-WDS components
- Creating custom styling

### 🚫 Never
- Generate code for non-WDS components without asking
- Skip verification gate
- Hardcode styles (use WDS design tokens)

## Input Modes
| Mode | Input | Verification |
|------|-------|--------------|
| Figma | URL with `node-id` | Browser screenshot comparison |
| Semantic | Natural language | Requirements checklist |

## NOT FOUND Discipline
If component NOT in WDS:
1. STOP — do not generate code
2. Inform user: "X is not in WDS"
3. Ask: "Search wix-private for similar?"
4. Wait for confirmation

## Outputs
```
.cursor/implement-ui/<task>/
├── UI-SPEC.md              # From clarify
├── COMPONENT-MAP.md        # From plan
└── VERIFICATION-REPORT.md  # From verify
```
