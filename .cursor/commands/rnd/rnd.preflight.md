---
description: Preflight MCP availability and gate execution until the user decides how to handle missing MCPs
globs:
alwaysApply: false
---

# /rnd.preflight — MCP Preflight Gate

Goal: detect whether required MCPs are available/active, and if any are missing, **prompt the user with clickable options and WAIT** before continuing.

## MCPs this kit knows about

| MCP Server | Purpose | Used By |
|------------|---------|---------|
| `user-octocode` | cross-repo code proof (definition + implementation + boundary) | `/deep-search`, `/implement`, `/review`, `/testkit`, `/troubleshoot`, `/smart-merge`, `/address-pr` |
| `user-MCP-S` | internal knowledge + ownership + observability (docs/Slack/Jira/DevEx/Grafana) | `/deep-search`, `/review`, `/testkit`, `/troubleshoot`, `/smart-merge`, `/address-pr` |
| `user-chrome-devtools` | runtime evidence (network/console/performance) | `/troubleshoot` |
| `cursor-ide-browser` | browser automation fallback (screenshots/DOM) | `/implement-ui` (figma verify), `/troubleshoot` (fallback) |

Notes:
- Some legacy docs mention `user-browsermcp` as a fallback browser MCP. Treat `cursor-ide-browser` as the fallback browser automation MCP in this environment.

## How to check availability (MANDATORY)

For each MCP server above:
1) **Best-effort descriptor presence check**:
   - Look for its descriptor folder under your Cursor MCPs directory (commonly under `~/.cursor/projects/*/mcps/<server>/`).
   - Some servers expose tools under `<server>/tools/*.json`; others only expose `SERVER_METADATA.json`. Either is acceptable as “present”.
2) **Best-effort live probe** (preferred when possible):
   - Attempt a small, read-only call using that MCP.
   - If the call errors with “server not found / not active / not enabled”, treat it as **MISSING**.

Suggested probes (safe / read-only):
- `user-octocode`: call `packageSearch` with a tiny query (e.g. `"react"`).
- `user-MCP-S`: call `devex__code_owners_for_path` for a small path (e.g. `badger/AGENTS.md`) OR `slack__search-messages` with a very narrow query.
- `user-chrome-devtools`: call `list-pages` (or equivalent) to confirm DevTools bridge is active.
- `cursor-ide-browser`: call `browser_tabs` with action `"list"` (or equivalent).

If you cannot run a probe (e.g., you can’t locate a schema or the tooling is unavailable), fall back to the descriptor presence check only.

## Missing MCP handling (MANDATORY, interactive)

If **one or more** MCPs are missing:
1) Present **one question per missing MCP** using clickable options.
2) **WAIT for the user’s response** (do not continue routing/execution yet).

For each missing MCP, ask:
- Prompt: `MCP "<name>" is missing/not active. How should we proceed?`
- Options:
  - `added` — “I enabled/added it now (recheck)”
  - `skip` — “Proceed without it (degraded mode)”
  - `other` — “Other / help me set it up”

Then:
- If user chooses `added`:
  - Re-run the probe for that MCP only.
  - If it still fails, ask again (same options).
- If user chooses `skip`:
  - Record this MCP as **SKIPPED**.
  - In later steps, any command that requires it must either:
    - downgrade claims to **NOT FOUND** (for proof requirements), or
    - switch to a documented fallback (if one exists).
- If user chooses `other`:
  - Stop and ask what they want (e.g., “install steps”, “use alternative MCP”, “continue without”). Do not proceed until resolved.

## Output (MANDATORY)

Write `.cursor/rnd/<topic>/MCP-PREFLIGHT.md` with:
- detected MCP status table: AVAILABLE / MISSING / SKIPPED
- which checks were performed (descriptor check vs probe)
- constraints imposed by missing/skipped MCPs (which commands are blocked/degraded)

