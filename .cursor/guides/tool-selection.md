---
description: Shared tool selection guide (Chrome DevTools first, BrowserMCP fallback, MCP-S/Octocode usage)
globs:
alwaysApply: false
---

# Tool Selection (Shared)

## Priority order (frontend evidence)
**Always try Chrome DevTools first.** Fall back to BrowserMCP only when DevTools is unavailable.

Chrome DevTools provides:
- network inspection (no fallback)
- performance tracing (no fallback)
- JS evaluation (no fallback)

BrowserMCP provides:
- snapshots + screenshots + basic interactions (fallback only)

## Strong signals to prefer
- trace IDs / span linkage
- **`x-wix-request-id`** from network responses (bridges frontend → backend)
- root cause analysis report (when request ID exists)
- logs correlated to request/trace IDs (fallback)

## Cross-repo / non-local symbols
When a symbol isn’t provable locally:
- MCP-S for context (ownership/requirements/generation)
- Octocode for proof (definition + implementation + boundary)

