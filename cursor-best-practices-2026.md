# Cursor AI: Complete Guide to Commands, Rules, Skills & Hooks (2026)

> **Latest best practices for configuring AI coding agents in Cursor IDE**  
> Based on Vercel's evaluation findings, official Cursor documentation, and community best practices.

---

## Table of Contents

1. [Executive Summary: AGENTS.md vs Skills](#executive-summary-agentsmd-vs-skills)
2. [Rules System](#rules-system)
3. [AGENTS.md](#agentsmd)
4. [Commands](#commands)
5. [Skills](#skills)
6. [Hooks](#hooks)
7. [Comparison Matrix](#comparison-matrix)
8. [Best Practices Summary](#best-practices-summary)

---

## Executive Summary: AGENTS.md vs Skills

### The Vercel Evaluation Findings

Vercel conducted comprehensive evaluations comparing approaches for teaching AI coding agents framework-specific knowledge. The results were unexpected:

| Configuration | Pass Rate | vs Baseline |
|--------------|-----------|-------------|
| Baseline (no docs) | 53% | — |
| Skills (default behavior) | 53% | +0pp |
| Skills with explicit instructions | 79% | +26pp |
| **AGENTS.md docs index** | **100%** | **+47pp** |

**Key Finding**: A compressed 8KB docs index embedded directly in `AGENTS.md` achieved a **100% pass rate**, while skills maxed out at 79% even with explicit instructions.

### Why AGENTS.md Outperformed Skills

1. **No Decision Point**: With `AGENTS.md`, there's no moment where the agent must decide "should I look this up?" The information is already present.
2. **Consistent Availability**: Skills load asynchronously and only when invoked. `AGENTS.md` content is in the system prompt for every turn.
3. **No Ordering Issues**: Skills create sequencing decisions (read docs first vs. explore project first). Passive context avoids this entirely.

### The Core Problem with Skills

In 56% of evaluation cases, the skill was **never invoked**. The agent had access to the documentation but didn't use it. Skills require the agent to:
1. Recognize when it needs framework-specific help
2. Actively decide to load the skill
3. Execute the skill retrieval

This introduces unreliability that passive context (AGENTS.md) eliminates.

---

## Rules System

Rules provide system-level instructions to the Cursor Agent, bundling prompts, scripts, and configurations for consistent AI behavior.

### Rule Types Hierarchy

| Type | Location | Scope | Precedence |
|------|----------|-------|------------|
| **Team Rules** | Cursor Dashboard | Organization-wide | Highest |
| **Project Rules** | `.cursor/rules/` | Project-specific | High |
| **User Rules** | Cursor Settings | Personal/Global | Low |
| **AGENTS.md** | Project root | Project-specific | Alternative |
| **Legacy (.cursorrules)** | Project root | Project-specific | Deprecated |

**Priority Order**: Team Rules → Project Rules → User Rules

### Project Rules: `.cursor/rules/` Directory

Project rules are stored as markdown files (`.md` or `.mdc`) in the `.cursor/rules/` directory.

#### Directory Structure

```
.cursor/rules/
├── react-patterns.mdc      # Rule with frontmatter
├── api-guidelines.md       # Simple markdown rule
├── frontend/               # Organize rules in folders
│   └── components.md
└── testing/
    └── unit-tests.mdc
```

#### MDC File Format (Recommended)

```yaml
---
description: "Standards for frontend components and API validation"
globs: "src/**/*.tsx"
alwaysApply: false
---

# React Component Guidelines

- Use functional components with hooks
- Prefer named exports over default exports
- Always define prop types with TypeScript interfaces

## Example

```typescript
interface ButtonProps {
  label: string;
  onClick: () => void;
}

export const Button = ({ label, onClick }: ButtonProps) => {
  return <button onClick={onClick}>{label}</button>;
};
```
```

#### Rule Application Types

| Type | Configuration | When Applied |
|------|--------------|--------------|
| **Always Apply** | `alwaysApply: true` | Every chat session |
| **Apply Intelligently** | `description` only (no globs) | Agent decides based on context |
| **Apply to Specific Files** | `globs: "pattern"` | When file matches pattern |
| **Apply Manually** | None of above | When @-mentioned (e.g., `@my-rule`) |

#### Frontmatter Fields

| Field | Required | Description |
|-------|----------|-------------|
| `description` | No | Describes what the rule does (used for intelligent application) |
| `globs` | No | File patterns for automatic application (e.g., `"**/*.ts"`, `"src/components/**/*.tsx"`) |
| `alwaysApply` | No | `true` = always active, `false` = conditional |

### Best Practices for Rules

#### DO:

1. **Keep rules under 500 lines** - Split large rules into composable pieces
2. **Be specific, not generic** - Provide concrete examples and code patterns
3. **Use glob patterns effectively**:
   ```yaml
   globs: "**/*.ts"           # All TypeScript files
   globs: "src/api/**/*.ts"   # API layer only
   globs: "**/*.{ts,tsx}"     # TS and TSX files
   ```
4. **Provide concrete examples** - Include actual code snippets
5. **Reference files** instead of copying content - Keeps rules short and prevents staleness
6. **Check rules into git** - Share with team

#### DON'T:

1. **Copy entire style guides** - Use a linter instead
2. **Document every possible command** - Agent knows common tools
3. **Add instructions for edge cases** - Focus on frequent patterns
4. **Duplicate codebase content** - Point to canonical examples

#### Priority Numbering System (Recommended)

Use three-digit prefixes to establish rule priority and organization:

| Range | Category | Examples |
|-------|----------|----------|
| 001-099 | Core rules (always apply) | `001-security.mdc`, `010-code-style.mdc` |
| 100-199 | Integration rules | `100-api-patterns.mdc`, `150-database.mdc` |
| 200-299 | Kit/workflow rules | `200-implement-ui.mdc`, `250-testing.mdc` |

```
.cursor/rules/
├── 001-security.mdc              # Core: always apply
├── 010-code-style.mdc            # Core: TypeScript patterns
├── 100-api-patterns.mdc          # Integration: REST conventions
├── 150-database.mdc              # Integration: query patterns
├── 200-implement-ui.mdc          # Kit-specific
└── shared/
    └── 001-proof-discipline.mdc  # Cross-kit mandate
```

#### Alternative: Folder Organization

```
.cursor/rules/
├── core/                         # Always-on rules
│   ├── security.mdc
│   └── code-style.mdc
├── integration/
│   ├── api-patterns.mdc
│   └── database.mdc
├── kits/
│   └── implement-ui.mdc
└── shared/
    └── 001-proof-discipline.mdc
```

### Team Rules (Team/Enterprise Plans)

Team rules are created in the Cursor Dashboard and automatically apply to all team members.

**Features:**
- Centralized management
- Immediate availability to all members
- Option to enforce (prevent user override)
- No frontmatter metadata support (plain text only)

**Configuration Options:**
- **Enable this rule immediately**: Activates on creation
- **Enforce this rule**: Prevents team members from disabling

### User Rules

Global preferences in **Cursor Settings → Rules** that apply across all projects.

```
Please reply in a concise style. Avoid unnecessary repetition.
Prefer TypeScript strict mode patterns.
```

---

## AGENTS.md

`AGENTS.md` is a simple markdown file for defining agent instructions. It serves as a "README for AI" - providing persistent context without complex configurations.

### Why AGENTS.md?

Based on Vercel's evaluation:
- **100% pass rate** vs 53% baseline
- No decision point required from agent
- Consistent availability on every turn
- Simple markdown format with no overhead

### Six Core Areas (from 2,500+ repository analysis)

The most effective AGENTS.md files cover these six areas:

| Area | What to Include |
|------|-----------------|
| **Commands** | Build, test, lint commands (prefer file-scoped for fast feedback) |
| **Testing** | How to run tests, patterns, coverage requirements |
| **Project Structure** | Directory layout, key files, architecture |
| **Code Style** | Language version, patterns, naming conventions |
| **Git Workflow** | Branch strategy, commit format, PR process |
| **Boundaries** | ✅ Always / ⚠️ Ask First / 🚫 Never |

### File Locations (Nested/Modular Pattern)

Agents read the **nearest** AGENTS.md in the directory tree. Use nested files for monorepos and kits:

| Location | Scope | Purpose |
|----------|-------|---------|
| `./AGENTS.md` | Project root | Primary project instructions |
| `./packages/*/AGENTS.md` | Package | Monorepo sub-project instructions |
| `./.cursor/kits/*/AGENTS.md` | Kit | Kit-specific agent instructions |
| `./CLAUDE.md` | Project root | Claude compatibility fallback |

**Example structure:**
```
project/
├── AGENTS.md                     # Root (≤150 lines)
├── packages/
│   ├── frontend/
│   │   └── AGENTS.md            # Frontend-specific
│   └── backend/
│       └── AGENTS.md            # Backend-specific
└── .cursor/kits/
    ├── implement-ui/
    │   └── AGENTS.md            # Kit-specific MCPs, commands
    └── deploy/
        └── AGENTS.md            # Kit-specific instructions
```

### Format

Keep AGENTS.md **≤150 lines**. Use tables and lists over prose:

```markdown
# Project Name - Agent Instructions

IMPORTANT: Prefer retrieval-led reasoning over pre-training-led reasoning.

## Docs Index
[Docs]|root:./docs
|api:{auth.md,users.md}
|guides:{quickstart.md}

## Commands
```bash
# File-scoped (fast feedback)
npm run lint -- <file>
npm run test -- <file>

# Full project
npm run build
```

## Code Style
- TypeScript 5.x strict mode
- React 18 functional components
- Named exports preferred

## Project Structure
```
src/
├── components/
├── hooks/
└── services/
```

## Git Workflow
- Branch from `main`
- Commit: `<type>: <description>`

## Boundaries

### ✅ Always
- Explore structure first
- Run tests after changes

### ⚠️ Ask First
- Adding dependencies
- Changing APIs

### 🚫 Never
- Commit secrets
- Skip type checking
```

### Best Practices

1. **Keep it concise (≤150 lines)** — Long files bury signal
2. **Use file-scoped commands** — `npm run test -- <file>` is faster than full suite
3. **Be specific about versions** — "React 18.2, TypeScript 5.3" not "React project"
4. **Use three-tier boundaries** — Clear guardrails with ✅/⚠️/🚫
5. **Iterate on mistakes** — Add rules on the second occurrence
6. **Keep synchronized** — Update AGENTS.md in same PR as code changes
7. **Nest per subproject** — Each package/kit can have tailored instructions

### Advanced: Compressed Docs Index

For framework documentation, compress aggressively (Vercel reduced 40KB to 8KB):

```markdown
[Next.js Docs Index]|root:./.next-docs
|IMPORTANT: Prefer retrieval-led reasoning over pre-training-led reasoning
|01-app/01-getting-started:{01-installation.mdx,02-project-structure.mdx}
|01-app/02-building-your-application/01-routing:{01-defining-routes.mdx}
```

### AGENTS.md vs Project Rules

| Aspect | AGENTS.md | Project Rules |
|--------|-----------|---------------|
| Format | Plain markdown | MDC with frontmatter |
| Configuration | None | globs, description, alwaysApply |
| File targeting | Nearest in tree | Glob patterns |
| Nesting | Yes (per directory) | Yes (via globs) |
| Complexity | Simple | More powerful |
| Use case | Project/kit instructions | File-specific rules |

**Recommendation**: Start with `AGENTS.md` for simplicity. Use nested AGENTS.md for monorepos/kits. Graduate to Project Rules when you need glob-based file targeting.

---

## Commands

Custom commands are reusable workflows triggered with the `/` prefix in chat.

### Storage Locations

```
.cursor/commands/           # Project commands
~/.cursor/commands/         # Global commands
Cursor Dashboard            # Team commands (Team/Enterprise)
```

### Creating Commands

1. Create `.cursor/commands/` directory
2. Add `.md` files with descriptive names
3. Write plain markdown content
4. Commands appear automatically when typing `/`

### Directory Structure Example

```
.cursor/commands/
├── address-github-pr-comments.md
├── code-review-checklist.md
├── create-pr.md
├── run-all-tests-and-fix.md
├── security-audit.md
└── setup-new-feature.md
```

### Command Examples

#### Code Review Checklist (`code-review-checklist.md`)

```markdown
# Code Review Checklist

Review the current changes against this checklist:

## Code Quality
- [ ] No unused imports or variables
- [ ] Functions are under 50 lines
- [ ] No hardcoded values (use constants)
- [ ] Error handling is comprehensive

## Testing
- [ ] New code has test coverage
- [ ] Edge cases are tested
- [ ] Mocks are appropriate

## Security
- [ ] No sensitive data exposed
- [ ] Input validation present
- [ ] SQL injection prevention

Provide feedback for each item.
```

#### Create PR (`create-pr.md`)

```markdown
# Create Pull Request

1. Analyze all staged changes
2. Generate a descriptive PR title
3. Write a comprehensive description including:
   - Summary of changes
   - Motivation
   - Testing performed
4. List any breaking changes
5. Suggest reviewers based on file ownership
```

#### Security Audit (`security-audit.md`)

```markdown
# Security Audit

Perform a security review of this codebase:

1. Check for hardcoded secrets or API keys
2. Review authentication/authorization logic
3. Identify SQL injection vulnerabilities
4. Check for XSS vulnerabilities
5. Review dependency versions for known CVEs
6. Check CORS configuration
7. Review input validation

Report findings with severity levels.
```

### Using Commands

```
/code-review-checklist
/create-pr these changes to address DX-523
/security-audit
```

Parameters after the command name are included in the prompt.

### Team Commands

Available on Team/Enterprise plans via Cursor Dashboard:
- Centralized management
- Automatic synchronization
- No manual distribution needed

---

## Skills

Agent Skills is an **open standard** for extending AI agents with specialized capabilities.

### What Are Skills?

Skills are portable, version-controlled packages that teach agents domain-specific tasks. They can include:
- Instructions (markdown)
- Executable scripts
- Reference documentation
- Assets and templates

### Skill Directories

Skills are auto-discovered from:

| Location | Scope |
|----------|-------|
| `.cursor/skills/` | Project-level |
| `.claude/skills/` | Project-level (Claude compatibility) |
| `.codex/skills/` | Project-level (Codex compatibility) |
| `~/.cursor/skills/` | User-level (global) |
| `~/.claude/skills/` | User-level (global) |

### Skill Structure

```
.cursor/skills/
└── deploy-app/
    ├── SKILL.md              # Required: Skill definition
    ├── scripts/              # Optional: Executable code
    │   ├── deploy.sh
    │   └── validate.py
    ├── references/           # Optional: Additional docs
    │   └── REFERENCE.md
    └── assets/               # Optional: Static resources
        └── config-template.json
```

### SKILL.md Format

```yaml
---
name: deploy-app
description: Deploy the application to staging or production environments. Use when deploying code or when the user mentions deployment.
license: MIT
disable-model-invocation: false
---

# Deploy App

Deploy the application using the provided scripts.

## When to Use
- User asks to deploy code
- User mentions "release" or "ship"
- After successful test runs

## Instructions

1. Run validation: `python scripts/validate.py`
2. Deploy: `scripts/deploy.sh <environment>`

Where `<environment>` is either `staging` or `production`.

## Prerequisites
- AWS CLI configured
- Docker running
- Valid credentials in environment
```

### Frontmatter Fields

| Field | Required | Description |
|-------|----------|-------------|
| `name` | Yes | Skill identifier (lowercase, hyphens only, must match folder name) |
| `description` | Yes | What the skill does and when to use it |
| `license` | No | License name or reference |
| `compatibility` | No | Environment requirements |
| `metadata` | No | Arbitrary key-value data |
| `disable-model-invocation` | No | `true` = only manual invocation via `/skill-name` |

### Invocation Methods

1. **Automatic**: Agent decides based on context and description
2. **Manual**: Type `/skill-name` in chat
3. **Disabled auto**: Set `disable-model-invocation: true` for explicit-only

### When to Use Skills vs AGENTS.md

Based on Vercel's findings:

| Use Case | Recommended |
|----------|-------------|
| General framework knowledge | AGENTS.md |
| Always-needed project context | AGENTS.md |
| Version-specific documentation | AGENTS.md with docs index |
| Vertical, action-specific workflows | Skills |
| Migration tasks (e.g., "upgrade Next.js") | Skills |
| User-triggered actions | Skills with `disable-model-invocation: true` |

### Migrating to Skills

Use the built-in migration command:

```
/migrate-to-skills
```

This converts:
- Dynamic rules (Apply Intelligently) → Standard skills
- Slash commands → Skills with `disable-model-invocation: true`

---

## Hooks

Hooks let you observe, control, and extend the agent loop using custom scripts.

### What Can Hooks Do?

- Run formatters after edits
- Add analytics for events
- Scan for PII or secrets
- Gate risky operations (e.g., SQL writes)
- Control subagent execution
- Inject context at session start

### Hook Configuration Locations

| Location | Priority | Scope |
|----------|----------|-------|
| `/Library/Application Support/Cursor/hooks.json` (macOS) | Highest | Enterprise/Global |
| `/etc/cursor/hooks.json` (Linux) | Highest | Enterprise/Global |
| `<project>/.cursor/hooks.json` | High | Project |
| `~/.cursor/hooks.json` | Low | User |

### Available Hook Events

#### Session & Submission
| Event | Description |
|-------|-------------|
| `sessionStart` | New conversation created |
| `sessionEnd` | Conversation ends |
| `beforeSubmitPrompt` | Validate prompts before submission |

#### File Operations
| Event | Description |
|-------|-------------|
| `beforeReadFile` | Control file access |
| `afterFileEdit` | Post-process edits |
| `beforeTabFileRead` | Tab completion file access |
| `afterTabFileEdit` | Tab completion edits |

#### Execution Control
| Event | Description |
|-------|-------------|
| `beforeShellExecution` | Before shell commands |
| `afterShellExecution` | After shell commands |
| `beforeMCPExecution` | Before MCP tool calls |
| `afterMCPExecution` | After MCP tool calls |

#### Tool Lifecycle
| Event | Description |
|-------|-------------|
| `preToolUse` | Before any tool execution |
| `postToolUse` | After successful tool execution |
| `postToolUseFailure` | When a tool fails |

#### Agent Lifecycle
| Event | Description |
|-------|-------------|
| `subagentStart` | Before spawning subagent |
| `subagentStop` | When subagent completes |
| `afterAgentResponse` | After agent message |
| `afterAgentThought` | After thinking block |
| `preCompact` | Before context compaction |
| `stop` | When agent loop ends |

### Basic Hook Configuration

**`~/.cursor/hooks.json`** (User-level):

```json
{
  "version": 1,
  "hooks": {
    "afterFileEdit": [
      {
        "command": "./hooks/format.sh"
      }
    ],
    "beforeShellExecution": [
      {
        "command": "./hooks/audit.sh"
      },
      {
        "command": "./hooks/block-dangerous.sh",
        "matcher": "rm -rf|DROP TABLE|DELETE FROM"
      }
    ]
  }
}
```

**`./hooks/format.sh`**:

```bash
#!/bin/bash
# Read input, process, exit 0
cat > /dev/null
# Run formatter on edited file
npx prettier --write "$CURSOR_PROJECT_DIR"
exit 0
```

### Hook Script Protocol

**Input**: JSON via stdin  
**Output**: JSON via stdout  
**Exit Codes**:
- `0` = Success, use JSON output
- `2` = Block the action (deny)
- Other = Hook failed, action proceeds (fail-open)

### Hook Types

#### Command-Based (Default)

```json
{
  "hooks": {
    "beforeShellExecution": [
      {
        "command": "./scripts/approve-network.sh",
        "timeout": 30,
        "matcher": "curl|wget|nc"
      }
    ]
  }
}
```

#### Prompt-Based (LLM-Evaluated)

```json
{
  "hooks": {
    "beforeShellExecution": [
      {
        "type": "prompt",
        "prompt": "Does this command look safe? Only allow read-only operations.",
        "timeout": 10
      }
    ]
  }
}
```

### Common Hook Patterns

#### Grind Loop (Run Until Tests Pass)

The most powerful pattern: agent iterates until a goal is met.

```json
{
  "version": 1,
  "hooks": {
    "stop": [{
      "command": "./hooks/grind-loop.sh",
      "matcher": "implement|test|fix"
    }]
  }
}
```

```bash
#!/bin/bash
# hooks/grind-loop.sh
read -r input
MAX_ITERATIONS=10
current=$(echo "$input" | jq -r '.iteration // 0')

# Run tests
npm test 2>&1 > /tmp/test-output.txt
if [ $? -eq 0 ]; then
  echo '{"decision": "stop"}'
  exit 0
fi

if [ "$current" -ge "$MAX_ITERATIONS" ]; then
  echo '{"decision": "stop", "user_message": "Max iterations reached. Tests still failing."}'
  exit 0
fi

# Continue with context
failures=$(grep -c "FAIL" /tmp/test-output.txt || echo "0")
echo "{\"decision\": \"continue\", \"followup_message\": \"$failures tests failing. Fix and retry.\", \"iteration\": $((current + 1))}"
```

#### Audit All Actions

```json
{
  "version": 1,
  "hooks": {
    "sessionStart": [{"command": "./hooks/audit.sh"}],
    "sessionEnd": [{"command": "./hooks/audit.sh"}],
    "beforeShellExecution": [{"command": "./hooks/audit.sh"}],
    "afterShellExecution": [{"command": "./hooks/audit.sh"}],
    "afterFileEdit": [{"command": "./hooks/audit.sh"}]
  }
}
```

#### Block Dangerous Git Operations

```bash
#!/bin/bash
# block-git.sh
read -r input
command=$(echo "$input" | jq -r '.command')

if echo "$command" | grep -qE 'git (push --force|reset --hard|clean -fd)'; then
  echo '{"permission": "deny", "user_message": "Dangerous git operation blocked"}'
  exit 0
fi

echo '{"permission": "allow"}'
exit 0
```

#### Format After Edits

```bash
#!/bin/bash
# format.sh
read -r input
file_path=$(echo "$input" | jq -r '.file_path')

# Run prettier on the edited file
npx prettier --write "$file_path" 2>/dev/null

exit 0
```

### Environment Variables Available to Hooks

| Variable | Description |
|----------|-------------|
| `CURSOR_PROJECT_DIR` | Workspace root directory |
| `CURSOR_VERSION` | Cursor version string |
| `CURSOR_USER_EMAIL` | Authenticated user email |

---

## Memory & Session Continuity

### memory.md Pattern

A `memory.md` file tracks session state for continuity across conversations:

```markdown
# Session State

## Current Task
Implementing user authentication

## Progress
- [x] Clarify requirements
- [x] Design API endpoints
- [ ] Implement JWT middleware
- [ ] Write tests

## Context
- Target: src/middleware/auth.ts
- Using: jsonwebtoken, bcrypt

## Decisions Made
- JWT tokens expire in 24h
- Refresh tokens stored in httpOnly cookies

## Blockers
None
```

**Best Practice**: Update memory.md at the end of each significant step.

### Session Commands

```bash
cursor --continue              # Resume previous session
cursor --print-conversation    # Export full context
cursor --resume <session-id>   # Resume specific session
```

### Workflow Files

Store multi-step processes in `.cursor/workflows/`:

```markdown
# .cursor/workflows/feature-implementation.md

## Steps
1. Create spec.md with requirements
2. Run /deep-search for existing patterns
3. Generate implementation plan
4. Implement in small chunks (commit after each)
5. Run tests, fix failures
6. Create PR with /pr command
```

---

## Spec-Driven Development

### spec.md Template

Before implementing, create a spec:

```markdown
# Spec: [Feature Name]

## Intent
[understand | debug | implement | review | test]

## Requirements
1. User can...
2. System should...

## Acceptance Criteria
- [ ] Criterion 1
- [ ] Criterion 2

## Architecture
- Component: [description]
- Data flow: [description]

## Out of Scope
- Not implementing X
- Deferring Y

## Tasks (Chunked)
1. [ ] Task 1 (verifiable via tests)
2. [ ] Task 2 (verifiable via lint)
3. [ ] Task 3 (verifiable via build)
```

**Why spec.md works**: Gives agent clear targets, enables TDD, prevents scope creep.

---

## Comparison Matrix

### Feature Comparison

| Feature | Rules | AGENTS.md | Commands | Skills | Hooks |
|---------|-------|-----------|----------|--------|-------|
| **Purpose** | System instructions | Project context | Reusable workflows | Domain capabilities | Lifecycle control |
| **Format** | MDC/Markdown | Markdown | Markdown | SKILL.md + scripts | JSON + scripts |
| **Location** | `.cursor/rules/` | Project root | `.cursor/commands/` | `.cursor/skills/` | `.cursor/hooks.json` |
| **File targeting** | Globs | No | No | No | Matchers |
| **Auto-applied** | Configurable | Always | No | Configurable | Event-based |
| **Executable** | No | No | No | Yes (scripts) | Yes (scripts) |
| **Team sharing** | Dashboard | Git | Dashboard | Git | Git/MDM |
| **Complexity** | Medium | Low | Low | High | High |

### When to Use What

| Need | Solution |
|------|----------|
| Consistent coding standards | Rules (alwaysApply) or AGENTS.md |
| File-type specific guidance | Rules with globs |
| Project documentation for AI | AGENTS.md |
| Framework docs (version-specific) | AGENTS.md with compressed index |
| Reusable prompt workflows | Commands |
| Domain expertise packages | Skills |
| Action-specific workflows | Skills with disable-model-invocation |
| Security scanning | Hooks (beforeShellExecution) |
| Auto-formatting | Hooks (afterFileEdit) |
| Audit logging | Hooks (all events) |
| Block dangerous operations | Hooks with deny response |

---

## Best Practices Summary

### 1. Start Simple

```
Project Root/
├── AGENTS.md              # Start here for basic instructions
└── .cursor/
    └── commands/          # Add commands for repeated workflows
```

### 2. Graduate to Rules When Needed

```
.cursor/
├── rules/
│   ├── always/
│   │   └── code-style.mdc        # alwaysApply: true
│   ├── frontend/
│   │   └── react-patterns.mdc    # globs: "**/*.tsx"
│   └── backend/
│       └── api-conventions.mdc   # globs: "src/api/**/*.ts"
└── commands/
    └── ...
```

### 3. Add Skills for Complex Workflows

```
.cursor/
├── skills/
│   ├── deploy-staging/
│   │   ├── SKILL.md
│   │   └── scripts/
│   └── database-migration/
│       ├── SKILL.md
│       └── scripts/
└── ...
```

### 4. Add Hooks for Security & Automation

```
.cursor/
├── hooks.json
└── hooks/
    ├── audit.sh
    ├── format.sh
    └── security-scan.sh
```

### Key Takeaways

1. **AGENTS.md outperforms Skills for general documentation** - Use passive context over on-demand retrieval
2. **Keep rules focused** - Under 500 lines, specific examples, no duplication
3. **Use globs precisely** - Test patterns to ensure they match intended files
4. **Commands for workflows** - Standardize repeated prompts
5. **Skills for vertical actions** - User-triggered, complex multi-step tasks
6. **Hooks for guardrails** - Security, formatting, audit trails

### Recommended Learning Path

1. Create `AGENTS.md` with project basics
2. Add a few commands for common workflows
3. Extract repeated prompt patterns into rules
4. Add hooks for formatting and security
5. Build skills for complex domain workflows

---

## References

- [Cursor Rules Documentation](https://cursor.com/docs/context/rules)
- [Cursor Commands Documentation](https://cursor.com/docs/context/commands)
- [Cursor Skills Documentation](https://cursor.com/docs/context/skills)
- [Cursor Hooks Documentation](https://cursor.com/docs/agent/hooks)
- [Vercel: AGENTS.md outperforms skills](https://vercel.com/blog/agents-md-outperforms-skills-in-our-agent-evals)
- [Agent Skills Specification](https://agentskills.io/)
- [AGENTS.md Official Site](https://agents.md/)

---

*Last updated: February 2026*
