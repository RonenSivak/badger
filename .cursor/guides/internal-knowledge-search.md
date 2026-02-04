# Internal Knowledge Search Protocol

When searching for internal Wix knowledge, **ALWAYS search ALL 4 sources**. Never settle for partial results.

---

## The 4 Mandatory Sources

| # | Source | Tool(s) | What It Provides |
|---|--------|---------|------------------|
| 1 | **Slack** | `slack__search-messages` | Team discussions, decisions, debugging threads, tribal knowledge |
| 2 | **Jira** | `jira__get-issues` | Requirements, acceptance criteria, bug reports, design decisions |
| 3 | **Internal Docs** | `docs-schema__search_docs` | Architecture specs, design docs, onboarding guides, ownership |
| 4 | **wix-private/* repos** | Octocode tools | Implementation details, SDK sources, generated code origins |

---

## Complete Search Protocol

### Step 1: Search ALL 4 Sources (MANDATORY)

```
- [ ] Slack searched: `slack__search-messages` with relevant keywords
- [ ] Jira searched: `jira__get-issues` with project key or JQL
- [ ] Internal Docs searched: `docs-schema__search_docs` with query
- [ ] wix-private/* searched: Octocode `githubSearchCode` in wix-private org
```

**Rule**: Do NOT skip any source. Even if you think you found the answer in one source, search the others for:
- Contradicting information
- Additional context
- More recent updates
- Related decisions

### Step 2: Evaluate Results

For each source, record:
- **Query used**: exact search terms
- **Results found**: count + summary
- **Key findings**: ownership, decisions, requirements, code locations
- **Gaps**: what wasn't answered

### Step 3: Expand Search (If Not Found)

**If any source returns no results, DON'T mark NOT FOUND yet.** Try:

| Source | Expansion Strategies |
|--------|---------------------|
| **Slack** | Try synonyms, older date ranges, different channels, team names |
| **Jira** | Try different projects, linked issues, component names |
| **Docs** | Try broader terms, related product names, team names |
| **wix-private** | Try different repos, package names, interface names |

### Step 4: Cross-Reference

- If Slack mentions a Jira ticket → fetch that ticket
- If Jira mentions a design doc → search docs
- If docs mention a repo/package → search that repo via Octocode
- If code has `@wix/ambassador-*` → trace the SDK chain

---

## Deep Search Mindset

**Take your time. Don't rush to conclusions.**

| Principle | Practice |
|-----------|----------|
| **Exhaust options** | Try 3-5 different queries per source before giving up |
| **Follow breadcrumbs** | Links in results → follow them → new search |
| **Question assumptions** | "This should be in Jira" → verify, don't assume |
| **Validate findings** | Cross-check between sources for consistency |
| **Document the journey** | Log all queries, even failed ones |

---

## Tool Reference

### Slack
```
Tool: slack__search-messages
Arguments:
  searchText: "<feature> <keywords>"
  in: "#channel-name"        # optional
  from: "<@USER>"            # optional
  after: "YYYY-MM-DD"        # recommend last 60-90 days
  before: "YYYY-MM-DD"       # optional
```

### Jira
```
Tool: jira__get-issues
Arguments:
  projectKey: "DEV"          # or use jql
  jql: "text ~ 'feature'"    # powerful search
  maxResults: 10
```

### Internal Docs
```
Tool: docs-schema__search_docs
Arguments:
  query: "<feature> architecture"
```

### wix-private/* (Octocode)
```
Tool: githubSearchCode
Arguments:
  owner: "wix-private"
  keywordsToSearch: ["<feature>", "<interface>"]
  match: "file"              # or "path"

Tool: githubViewRepoStructure
Arguments:
  owner: "wix-private"
  repo: "<repo-name>"
  path: ""
  depth: 1
```

---

## When to Search

Search ALL 4 sources when:
- New service/package/SDK encountered
- Feature purpose unclear from code
- Debugging a production issue
- Understanding "why" decisions were made
- Finding code owners or responsible team
- Tracing generated code origins
- Investigating deployment/rollout issues

---

## Logging Requirement

Append ALL search queries and findings to the workflow's evidence artifact:

```markdown
## Internal Knowledge Search Log

### Slack
- Query: `slack__search-messages(searchText="feature X", after="2026-01-01")`
- Results: 3 messages found
- Key finding: Team decided to deprecate in #platform-sync (2026-01-15)

### Jira
- Query: `jira__get-issues(jql="project=PLAT AND text~'feature X'")`
- Results: 2 issues
- Key finding: DEV-1234 has acceptance criteria

### Internal Docs
- Query: `docs-schema__search_docs(query="feature X architecture")`
- Results: 1 doc
- Key finding: Design doc at portal/123 explains data flow

### wix-private/*
- Query: `githubSearchCode(owner="wix-private", keywordsToSearch=["FeatureX"])`
- Results: Found in wix-private/platform-service
- Key finding: Implementation at src/features/featureX.ts
```

---

## NOT FOUND Protocol

Only mark **NOT FOUND** after:

1. All 4 sources searched ✓
2. Multiple query variations tried per source ✓
3. Expansion strategies exhausted ✓
4. Cross-references followed ✓

When marking NOT FOUND, document:
- All queries attempted (per source)
- Date ranges searched
- Why each expansion strategy didn't help
- Suggested next steps (ask user, escalate, etc.)
