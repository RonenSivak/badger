---
description: Clarification loop to build DEBUG-SPEC (repeat until complete)
globs:
alwaysApply: false
---

# /debug.clarify — Clarify Loop 🧠

Goal: produce `.cursor/debug/<topic>/DEBUG-SPEC.md`

---

## Ask Iterative Questions Until Complete

### 1) Core Problem
- "What is the symptom?" (exact error text / wrong behavior / perf regression)
- "Is this a frontend bug, backend bug, or both?"

### 2) Where & Environment
- "Where does it appear?" (editor/viewer/service/CLI)
- "What environment?" (prod/stage/local)
- "Can you provide a URL to reproduce?"

### 3) When & Scope
- "When was it first seen?"
- "Any suspect PR/commit range?"
- "Does it affect all users or specific segment?"

### 4) Repro Steps
- "What are the steps to reproduce?"
- "Does it happen consistently or intermittently?"

### 5) Evidence Anchors (ask for any of these)
- Trace IDs / request IDs
- Log keywords / error messages
- Feature flags / experiments / config keys
- Endpoint / RPC names
- Schema / type / field names
- Unique strings or error codes
- **Service name** (for Grafana queries)
- **Dashboard URL** (if they have one)

### 6) Tool Context (ask to enable MCP-S tools)

**For Frontend Bugs:**
- "Is there a browser tab open where I can inspect?" (enables Chrome DevTools)
- "Can you provide a URL to navigate to?"

**For Backend Bugs:**
- "What is the service name?" (for Grafana `find_error_pattern_logs`)
- "Any known Grafana dashboard for this service?"
- "Is there an active incident?" (for `list_incidents`)

**For All Bugs:**
- "Any related Jira tickets?" (project key + keywords)
- "Any Slack channels where this was discussed?"
- "What team owns this code?" (will verify with `code_owners_for_path`)

---

## Output: DEBUG-SPEC

Write `.cursor/debug/<topic>/DEBUG-SPEC.md` with:

```markdown
# DEBUG-SPEC: <topic>

## Problem Statement
- **Symptom**: <exact error or behavior>
- **Type**: Frontend / Backend / Both
- **Severity**: P0/P1/P2/P3

## Environment
- **Surface**: editor / viewer / service / CLI
- **Env**: prod / stage / local
- **URL**: <if available>

## Timeline
- **First seen**: <date/time>
- **Suspect commits**: <range if known>

## Repro Steps
1. ...
2. ...
3. ...

## Evidence Anchors
- **Trace/Request IDs**: <if available>
- **Error message**: <exact text>
- **Service name**: <for Grafana>
- **Dashboard**: <URL if known>

## MCP-S Tool Context
- **Browser available**: yes/no (for Chrome DevTools)
- **Service name**: <for Grafana queries>
- **Jira project**: <for issue search>
- **Slack channels**: <for discussions>
- **Suspected owner team**: <will verify with DevEx>

## Constraints
- Must trace full E2E across ecosystem
- <any specific constraints>

## Starting Breadcrumbs (ranked)
1. <strongest lead>
2. <secondary lead>
3. <tertiary lead>

## "Done" Signals (verifiable)
- [ ] Tests pass
- [ ] TSC clean
- [ ] Lint clean
- [ ] Error no longer appears in logs
- [ ] <specific metric/alert resolves>
```

---

## Stop Condition
DEBUG-SPEC is complete when you have enough to start `/debug.trace`:
- Clear symptom description
- Environment identified
- At least one evidence anchor OR clear repro steps
- Service name (for backend) OR URL (for frontend)
