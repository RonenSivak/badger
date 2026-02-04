---
description: Clarify the split target and constraints (produces SPLIT-SPEC.md)
globs:
alwaysApply: false
---

# /smart-branch-split.clarify — Clarification Loop

Ask questions until you can write `.cursor/smart-branch-split/<topic>/SPLIT-SPEC.md`.

Start with:
**"What do you want to split?"**

---

## Section 1: Basic Info

Collect:
- Topic name (folder name)
- Base branch (usually `master`/`main`)
- Source branch (the large branch)
- Remote name (usually `origin`)

---

## Section 2: Split Strategy

### Clustering Strategy (ask user preference)

| Strategy | Best For | Example |
|----------|----------|---------|
| **By Feature/Task** | Branch has multiple distinct features | "Split features A, B, C" |
| **By Module/Component** | Monorepo with changes across packages | "Split by package" |
| **By Commit History** | Sequential commits for sub-tasks | "Group related commits" |
| **Milestone Breakpoints** | Natural completion points exist | "Steps A → B → C" |
| **Feature Flag Isolation** | Partial feature can merge behind flag | "Incremental behind flags" |

Ask: "Which clustering strategy fits your branch best?"

### PR Flow Type (ask user preference)

| Flow | Description | When to Use |
|------|-------------|-------------|
| **Independent** | Each PR merges to main separately | Changes don't depend on each other |
| **Stacked** | PR2 targets PR1's branch, etc. | Sequential dependencies |
| **Feature Branch** | All PRs merge to temp branch first | Full feature needed before main |
| **Trunk-Based + Flags** | Merge to main behind feature flags | Continuous delivery |

Ask: "How should the PRs be organized?"

---

## Section 3: Constraints

Collect:
- Target number of PRs (or "as many as needed")
- Stacking requirements (PR order matters?)
- Constraints:
  - allowed file areas
  - risky areas (must isolate)
  - "must land together" pieces
  - "do not touch" files
- Naming rules:
  - branch prefix style
  - scope keywords (domains/packages)
- Feature flag usage (yes/no/maybe)

---

## Section 4: Verification Discovery (MANDATORY)

Before finalizing spec, discover what verification commands are available:

### Step 1: Detect Workspace Type
```bash
ls package.json turbo.json nx.json lerna.json 2>/dev/null
```

### Step 2: Find Affected Packages
```bash
git diff --name-only <base>..<source> | cut -d'/' -f1-2 | sort -u
```

### Step 3: Check Available Scripts Per Package
```bash
cat <package>/package.json | jq '.scripts | keys' 2>/dev/null
```

Look for: `tsc`, `typecheck`, `type-check`, `lint`, `test`, `build`

### Step 4: Test Command Execution
Try running a command to check for environment requirements:
```bash
yarn workspace <package> tsc --noEmit
```

If it fails with "env variable required", note as "CI-only".

---

## Output

Write `SPLIT-SPEC.md` containing:

```markdown
# Split Spec: <topic>

## Source
- Base branch: <branch>
- Source branch: <branch>
- Remote: <remote>

## Strategy
- Clustering: <strategy from Section 2>
- PR Flow: <flow type from Section 2>
- Feature flags: yes | no | maybe

## Constraints
- Target PR count: <number or "as needed">
- Stacking: required | preferred | not needed
- Must land together: <list or "none">
- Do not touch: <list or "none">
- Risky areas: <list or "none">

## Naming
- Branch prefix: <format>
- Scope keywords: <list>

## Verification
- Workspace type: yarn workspaces | npm workspaces | turbo | nx | standalone
- Affected packages: <list>
- Commands:
  - tsc: `<command>` — AVAILABLE | N/A
  - lint: `<command>` — AVAILABLE | N/A
  - test: `<command>` — AVAILABLE | CI-ONLY | N/A
  - build: `<command>` — AVAILABLE | N/A
- CI-only commands: <list with reason>
- Skip commands: <list with reason>
```

Stop only when the spec is unambiguous.
