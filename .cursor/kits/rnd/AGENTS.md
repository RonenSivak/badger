# rnd Kit - Agent Instructions

IMPORTANT: This is a meta-orchestrator. Run MCP preflight checks before routing to other kits.

## Commands
```bash
/rnd                        # Meta-orchestrator entry point
/rnd.preflight             # Check required MCPs are available
/rnd.route                 # Route intent to appropriate workflow
```

## MCP Preflight Matrix
| Workflow | Required MCPs |
|----------|---------------|
| `/deep-search` | `octocode`, `mcp-s` (optional) |
| `/troubleshoot` | `octocode`, `mcp-s` |
| `/implement-ui` | `wix-design-system-mcp`, `octocode` |
| `/implement` | `octocode` |
| `/review` | `octocode` |

## Intent Routing
| User Intent | Route To |
|-------------|----------|
| "understand", "how does", "architecture" | `/deep-search` |
| "debug", "error", "failing", "broken" | `/troubleshoot` |
| "build UI", "create component", "Figma" | `/implement-ui` |
| "implement", "add feature", "create" | `/implement` |
| "review", "check code", "PR" | `/review` |
| "test", "write tests" | `/testkit` |

## Boundaries

### ✅ Always
- Run preflight before routing
- Prompt user if required MCP missing
- Provide installation instructions for missing MCPs

### ⚠️ Ask First
- When intent is ambiguous
- When multiple workflows could apply

### 🚫 Never
- Route without preflight check
- Skip MCP availability verification
- Proceed with missing required MCPs

## Preflight Output
```markdown
## MCP Status
- ✅ octocode: available
- ✅ mcp-s: available
- ❌ wix-design-system-mcp: NOT FOUND

## Action Required
Install missing MCP: `cursor mcp install wix-design-system-mcp`
```
