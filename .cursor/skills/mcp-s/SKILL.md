# Skill: MCP-S Internal Knowledge Research

## Purpose
MCP-S provides access to internal knowledge sources that code cannot reveal:
- **Internal Docs** — architecture, design specs, ownership
- **Slack** — team discussions, decisions, context
- **Jira** — requirements, tickets, acceptance criteria
- **DevEx** — code ownership, CI/CD, commits, releases, deployment

## When to use
- Every new service/package/SDK encountered
- Ownership or team responsibility unclear
- Feature purpose unclear from code
- Debugging (search for related tickets/discussions)
- "Why was this built this way?" questions
- Generated code (search for generation pipeline docs)
- **Need to know who owns code** (DevEx code_owners)
- **Need build/CI status** (DevEx builds)
- **Need commit tracking** (DevEx commits)
- **Need release/deployment info** (DevEx releases, rollouts)

---

## Available Tools (MCP server: `user-MCP-S`)

### Internal Knowledge Tools

#### 1) Search Internal Docs
```
toolName: docs-schema__search_docs
arguments:
  query: "<search keywords>"    # max 256 chars, required
  limit: 10                     # optional
```
**Best for:** architecture docs, design specs, ownership info, onboarding guides

#### 2) Search Slack Messages
```
toolName: slack__search-messages
arguments:
  searchText: "<keywords>"      # general search
  exactPhrase: "<exact match>"  # optional, quoted phrase
  in: "#channel-name"           # optional, scope to channel
  from: "<@USER>"               # optional, scope to user
  after: "YYYY-MM-DD"           # optional, date filter
  before: "YYYY-MM-DD"          # optional, date filter
```
**Best for:** team discussions, decisions, debugging threads, context around changes

#### 3) Get Slack Channel History
```
toolName: slack__slack_get_channel_history
arguments:
  channel_id: "<channel_id>"    # required
  limit: 10                     # optional
```
**Best for:** recent activity in a known channel

#### 4) Search Jira Issues
```
toolName: jira__get-issues
arguments:
  projectKey: "PP"              # required (or use jql override)
  jql: "text ~ 'feature name'"  # optional, JQL query
  maxResults: 10                # optional
  fields: ["key", "summary", "description", "status", "comment"]
```
**Best for:** requirements, acceptance criteria, bug reports, feature specs

---

### DevEx Tools (Wix Developer Experience)

#### 5) Code Owners for Path
```
toolName: code_owners_for_path
arguments:
  path: "<file or directory path>"
```
**Best for:** finding who owns a file/directory, responsible team

#### 6) Get Ownership Tags
```
toolName: get_ownership_tags
arguments:
  # check schema for params
```
**Best for:** ownership metadata for a project

#### 7) Get Projects by Ownership Tags
```
toolName: get_projects_by_ownership_tags
arguments:
  tags: ["<tag1>", "<tag2>"]
```
**Best for:** finding projects owned by a team/tag

#### 8) Get Project
```
toolName: get_project
arguments:
  projectName: "<project name>"
```
**Best for:** project metadata, configuration

#### 9) Search Projects
```
toolName: search_projects
arguments:
  query: "<search term>"
```
**Best for:** finding projects by name/keyword

#### 10) Get Build
```
toolName: get_build
arguments:
  buildId: "<build id>"
```
**Best for:** CI/CD build details, status

#### 11) Get Build by External ID
```
toolName: get_build_by_external_id
arguments:
  externalId: "<external id>"
```
**Best for:** finding build by external reference

#### 12) Search Builds
```
toolName: search_builds
arguments:
  projectName: "<project>"
```
**Best for:** build history, finding builds

#### 13) Get Commit Information
```
toolName: get_commit_information
arguments:
  commitSha: "<sha>"
```
**Best for:** commit details, author, what changed

#### 14) Find Commits by Date Range
```
toolName: find_commits_by_date_range
arguments:
  startDate: "YYYY-MM-DD"
  endDate: "YYYY-MM-DD"
  projectName: "<project>"
```
**Best for:** commits in a time period

#### 15) Where Is My Commit
```
toolName: where_is_my_commit
arguments:
  commitSha: "<sha>"
```
**Best for:** tracking commit deployment status

#### 16) Release Notes
```
toolName: release_notes
arguments:
  projectName: "<project>"
  version: "<version>"
```
**Best for:** what changed in a release

#### 17) Available RCs
```
toolName: available_rcs
arguments:
  projectName: "<project>"
```
**Best for:** finding release candidates

#### 18) Get Rollout History
```
toolName: get_rollout_history
arguments:
  projectName: "<project>"
```
**Best for:** deployment history, rollout progress

#### 19) Get DevEx FQDN
```
toolName: get_devex_fqdn
arguments:
  serviceName: "<service>"
```
**Best for:** service endpoint/FQDN discovery

#### 20) Fleets Pods Overview
```
toolName: fleets_pods_overview
arguments:
  serviceName: "<service>"
```
**Best for:** infrastructure status, pods info

#### 21) Project Quality Scores
```
toolName: project_quality_service_get_scores
arguments:
  projectName: "<project>"
```
**Best for:** quality metrics, test coverage, health

---

## Research Procedure

### Step 1: Identify knowledge gaps
Before/during code research, note questions that code can't answer:
- Who owns this?
- Why was it built this way?
- What are the requirements?
- Are there known issues/discussions?
- What's the build/release status?
- Where is this deployed?

### Step 2: Query appropriate sources
| Question Type | Primary Source | Secondary |
|---------------|----------------|-----------|
| Architecture/design | Docs | Slack |
| Ownership/team | **DevEx code_owners** | Docs, Slack |
| Requirements | Jira | Docs |
| Decisions/context | Slack | Jira comments |
| Bugs/issues | Jira | Slack |
| Recent activity | Slack | Jira |
| Build status/history | **DevEx builds** | Slack |
| Commit tracking | **DevEx commits** | — |
| Release info | **DevEx releases** | Jira, Slack |
| Deployment status | **DevEx rollouts, fleets** | Slack |
| Service endpoints | **DevEx FQDN** | Docs |
| Quality metrics | **DevEx quality scores** | — |

### Step 3: Record findings
Write to `.cursor/deep-search/<feature>/mcp-s-notes.md`:

```markdown
## [Topic/Symbol Name]
- **Source**: docs | Slack | Jira | DevEx
- **Tool**: <tool name>
- **Query**: <exact query/arguments used>
- **Findings**:
  - <key insight 1>
  - <key insight 2>
- **Links**: <URLs if available>
- **Follow-up**: <what to verify via code/Octocode>
```

---

## Hard Rules

1. **Docs/DevEx are hints, not proof** — After MCP-S gives hints, you MUST verify via code (using Octocode if non-local)

2. **Always log queries** — Even failed searches must be recorded (for NOT FOUND evidence)

3. **Search iteratively** — If first query yields nothing, try synonyms, related terms, team names

4. **Cross-reference sources** — Slack mentions often reference Jira tickets; DevEx ownership links to docs

5. **Use DevEx for ownership** — Don't guess ownership; use `code_owners_for_path`

---

## Example Workflow

```
1. Encounter new service: devcenter-v1-component
   └── Search docs: "devcenter component"
   └── DevEx: code_owners_for_path("packages/devcenter-component")
   └── DevEx: get_project("devcenter-component")
   └── Search Slack: "devcenter component" in:#devcenter
   └── Search Jira: project=DEVCENTER text~"component"

2. Debugging a deployment issue:
   └── DevEx: search_builds(projectName="my-service")
   └── DevEx: where_is_my_commit(commitSha="abc123")
   └── DevEx: get_rollout_history(projectName="my-service")
   └── Search Slack: "my-service deployment" in:#my-service-alerts

3. Record findings in mcp-s-notes.md

4. Use findings to guide Octocode queries for code proof
```

---

## NOT FOUND Discipline
If searches yield no results:
```markdown
## [Topic] — MCP-S: NOT FOUND
- **Docs query**: "exact query" → no results
- **Slack query**: "exact query" in:#channel → no results
- **Jira query**: project=X text~"query" → no results
- **DevEx query**: code_owners_for_path("path") → no results
- **Scope searched**: docs, Slack (#channel1, #channel2), Jira (PROJECT), DevEx
```
