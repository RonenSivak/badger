---
description: Clarify the split target and constraints (produces SPLIT-SPEC.md)
globs:
alwaysApply: false
---

# /smart-branch-split.clarify — Clarification Loop

Ask questions until you can write `.cursor/smart-branch-split/<topic>/SPLIT-SPEC.md`.

Start with:
**"What do you want to split?"**

Collect:
- Topic name (folder name)
- Base branch (usually `master`/`main`)
- Source branch (the large branch)
- Remote name (usually `origin`)
- Target number of PRs (or "as many as needed")
- Any required ordering (stacked PRs vs independent)
- Constraints:
  - allowed file areas
  - risky areas (must isolate)
  - "must land together" pieces
  - "do not touch" files
- Naming rules:
  - branch prefix style
  - scope keywords (domains/packages)

---

## Verification Discovery (MANDATORY)

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
- base + source + remote
- desired PR buckets (initial guess)
- constraints
- **verification section**:
  ```markdown
  ## Verification
  - Workspace type: yarn workspaces | npm workspaces | turbo | nx | standalone
  - Affected packages: <list>
  - Commands:
    - tsc: `yarn workspace <pkg> tsc --noEmit` — AVAILABLE | N/A
    - lint: `yarn workspace <pkg> lint` — AVAILABLE | N/A
    - test: `yarn workspace <pkg> test` — AVAILABLE | CI-ONLY | N/A
    - build: `yarn workspace <pkg> build` — AVAILABLE | N/A
  - CI-only commands: <list with reason>
  - Skip commands: <list with reason>
  ```
- branch naming format to use

Stop only when the spec is unambiguous.
