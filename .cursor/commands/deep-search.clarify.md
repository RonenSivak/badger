---
description: Clarify intent + scope for deep-search until spec is complete
globs:
alwaysApply: false
---

# /deep-search.clarify — Clarify Loop 🧠

## Goal
Iterate questions until you can fill the “Search Spec” below with high confidence.
Ask only what is missing. Repeat until complete.

## Ask This First
1) “What is the feature name (or closest official name)?”
2) “What’s your intent: understand E2E, debug bug, or clone/add similar feature?”
3) “Give 1–3 breadcrumbs to start: type name / string / endpoint / file path.”

## Then Ask Only If Needed
- “Which consumers must be included? (Viewer/runtime/editor/host-integration/others)”
- “Any known repos/packages/services involved?”
- “Any ‘must include’ contracts? (.proto/openapi/graphql/db schema)”
- “Any known failure mode/error code to chase?”

## SDK / Metro / Ambassador probe (ask if unclear)
Ask only if user didn’t mention SDKs yet:
- “Do you expect generated SDK involvement? (e.g. `@wix/ambassador-*`, `ctx.ambassador.request`, `/rpc`, `/types`, Metro/package generation)”
- “Do you need the *full generation chain* (source IDL → generator config → generated package → runtime transport)?” (default: YES)

## Stop Condition (Spec Complete)
When you can fill:

### Search Spec
- Feature:
- Intent: (E2E understanding | clone/add | debug)
- Breadcrumbs:
- Required consumers (at least one):
- Suspected producers:
- Contracts to chase:
- SDKs involved (if any): (Ambassador/Metro/etc.)
- Must-prove SDK generation chain? (YES/NO) (default YES if SDKs exist)
- Known repos/services (optional):
- Output depth: (summary + full report)

Once complete:
- Echo the filled Search Spec (short)
- Say: “Starting deep research using MCP-S + Octocode now.”
- Return control to orchestrator.
