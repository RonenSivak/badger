# Kit Architecture Guide (2026 Best Practices)

This guide synthesizes research from Vercel, Cursor, Anthropic, and industry sources on building effective AI coding agent workflows.

## Key Principles

### 1. Passive Context > Active Retrieval
AGENTS.md files (100% pass rate) outperform skills (79%) for horizontal knowledge. Use skills only for vertical, user-triggered workflows.

### 2. Plan Before Code
Create spec.md → chunk into tasks → execute incrementally → verify each chunk. Never request entire features at once.

### 3. Small, Verifiable Chunks
Each task should be small enough to fit in context and verifiable via tests/lints. Commit after each successful chunk.

### 4. Supervised Autonomy
Agents generate and run code, but humans review each step. Interrupt with Escape when heading wrong.

---

## Recommended Kit Architecture

### File Structure (Simplified)

```
.cursor/
├── commands/
│   └── <kit>.md                    # Single orchestrator (not split files)
├── rules/
│   ├── 001-core.mdc               # Priority-numbered rules
│   ├── 100-<kit>.mdc              # Kit-specific rules
│   └── shared/
│       └── 001-proof-discipline.mdc
├── skills/
│   └── <kit>/
│       └── SKILL.md               # Only for user-triggered workflows
├── kits/
│   └── <kit>/
│       ├── AGENTS.md              # Kit-specific agent instructions
│       └── spec-template.md       # Planning template
├── workflows/                      # Multi-step workflow definitions
│   └── <workflow>.md
├── hooks.json                      # Iteration loops, formatters, gates
└── memory.md                       # Session state (auto-updated)
```

### Why Single Orchestrator (Not Split Files)

**Research finding**: Splitting orchestrators into 6+ subcommand files creates overhead without benefit. Modern best practice:

| Pattern | When to Use |
|---------|-------------|
| **Single orchestrator** | Most kits - all steps in one file |
| **Hooks for iteration** | "Run until tests pass" loops |
| **Subagents** | Parallel isolated tasks (e.g., research while coding) |

**Example: Simplified Orchestrator**

```markdown
---
description: Implement UI from Figma or description using WDS
globs:
alwaysApply: false
---

# /implement-ui

## Prerequisites
- `wix-design-system-mcp` enabled
- React + TypeScript project

## Workflow

### 1. Clarify
Determine input mode and gather requirements:
- Figma URL with node-id → visual verification mode
- Natural language → requirements checklist mode

Output: `.cursor/kits/implement-ui/<task>/spec.md`

### 2. Plan
Map requirements to WDS components. Call `getComponentsList` first.

Output: `.cursor/kits/implement-ui/<task>/component-map.md`

Gate: All UI elements mapped or flagged as custom.

### 3. Implement
Generate React+TS code using mapped WDS components.
- Keep components < 150 lines
- Type all props
- Follow WDS dos/don'ts

### 4. Verify
- Figma mode: Browser screenshot comparison
- Semantic mode: Requirements checklist

Gate: Must pass before publish.

### 5. Publish
Print summary: files created, usage instructions.

## NOT FOUND Protocol
If component NOT in WDS:
1. STOP
2. Ask: "Search wix-private for similar?"
3. Wait for confirmation
```

---

## Rules Best Practices

### Priority Numbering System

| Range | Category | Example |
|-------|----------|---------|
| 001-099 | Core rules (always apply) | `001-security.mdc` |
| 100-199 | Integration rules | `100-api-patterns.mdc` |
| 200-299 | Kit-specific rules | `200-implement-ui.mdc` |

### Rule Structure (MDC Format)

```yaml
---
description: Clear purpose in < 100 chars
globs: "src/**/*.tsx"
alwaysApply: false
---

# Rule Title

## Do
- Specific action 1
- Specific action 2

## Don't
- Anti-pattern 1
- Anti-pattern 2

## Example
\`\`\`typescript
// Good
const Button = ({ label }: ButtonProps) => ...

// Bad
const Button = (props) => ...
\`\`\`
```

### Keep Rules Concise
- **< 500 lines** per rule file
- Reference canonical examples via `@filename.ts`
- Don't duplicate codebase content
- Update rules when you see the same mistake **twice**

---

## Skills vs Commands vs AGENTS.md

| Mechanism | Load Time | Use Case |
|-----------|-----------|----------|
| **AGENTS.md** | Always (passive) | Horizontal knowledge: stack, patterns, boundaries |
| **Commands** | On `/invoke` | Reusable workflows: `/pr`, `/fix-issue`, `/review` |
| **Skills** | Agent decides (dynamic) | Specialized domain tasks with scripts |

### When to Use Skills

Skills are for **vertical, action-specific** workflows the user explicitly triggers:
- Version migrations (`/upgrade-next`)
- Deployment workflows (`/deploy-staging`)
- Complex multi-tool operations

Skills should NOT duplicate AGENTS.md or command content.

---

## Hooks for Iteration Loops

### hooks.json Structure

```json
{
  "version": 1,
  "hooks": {
    "stop": [{
      "command": "./hooks/grind-loop.sh",
      "matcher": "implement|test"
    }],
    "afterFileEdit": [{
      "command": "./hooks/format.sh"
    }],
    "beforeShellExecution": [{
      "command": "./hooks/block-dangerous.sh",
      "matcher": "rm -rf|DROP TABLE"
    }]
  }
}
```

### Grind Loop Pattern

Run agent until tests pass (up to N iterations):

```bash
#!/bin/bash
# hooks/grind-loop.sh
read -r input
tests_pass=$(npm test 2>&1 | grep -c "passed")

if [ "$tests_pass" -gt 0 ]; then
  echo '{"decision": "stop"}'
else
  echo '{"decision": "continue", "followup_message": "Tests still failing. Fix and retry."}'
fi
```

---

## Memory & Session Continuity

### memory.md Pattern

Keep a `memory.md` file updated with session state:

```markdown
# Session State

## Current Task
Implementing settings panel for dashboard

## Progress
- [x] Clarify requirements
- [x] Map to WDS components
- [ ] Generate code
- [ ] Verify

## Context
- Figma: https://figma.com/...
- Target file: src/components/SettingsPanel.tsx

## Decisions Made
- Using Card + Toggle + Dropdown from WDS
- Not using custom styles

## Blockers
None
```

### Continuity Commands

```bash
cursor --continue           # Resume previous session
cursor --print-conversation # Export context
```

---

## Spec-Driven Development

### spec.md Template

```markdown
# Spec: [Feature Name]

## Intent
[understand | debug | implement | review | test]

## Requirements
1. [Requirement 1]
2. [Requirement 2]

## Acceptance Criteria
- [ ] Criterion 1
- [ ] Criterion 2

## Architecture Decisions
- [Decision 1]: [Rationale]

## Out of Scope
- [What we're NOT doing]

## Tasks (Chunked)
1. [ ] Task 1 (verifiable)
2. [ ] Task 2 (verifiable)
3. [ ] Task 3 (verifiable)
```

---

## Multi-Agent Patterns

### When to Use Subagents

| Pattern | Use Case |
|---------|----------|
| **Sequential** | Clear dependencies (clarify → plan → implement) |
| **Parallel** | Independent tasks (research + scaffold simultaneously) |
| **Maker-Checker** | One agent creates, another reviews |

### Subagent Definition

```markdown
---
name: researcher
description: Find patterns in codebase
model: haiku
readonly: true
---

Search for existing implementations of [X].
Return: file paths + key functions.
Do NOT modify any files.
```

### Best Practices

- **Limit to 3 agents** in any collaboration
- Give each agent **one focused objective**
- **Merge outputs** into synthesis before acting
- Use **maker-checker** for critical operations

---

## TDD with Agents

The most effective agent workflow:

1. **Write test first**: Be explicit about TDD to prevent mocks
2. **Confirm test fails**: Agent runs test, confirms red
3. **Commit test**: Lock in the contract
4. **Implement**: Agent writes code to pass test
5. **Iterate until green**: Use grind loop hooks
6. **Commit implementation**: Verify, then commit

---

## Parallel Development

### Git Worktrees Pattern

```bash
# Create isolated context per feature
git worktree add ../feature-a -b feature-a
git worktree add ../feature-b -b feature-b

# Run separate Cursor sessions
cursor ../feature-a
cursor ../feature-b
```

Each worktree gets its own Claude session, preventing context bleed.

---

## Key Takeaways

1. **Single orchestrator** - Don't split into 6 subcommand files
2. **Priority-numbered rules** - 001-core, 100-integration, 200-kit
3. **AGENTS.md for horizontal** - Skills only for vertical workflows
4. **Hooks for iteration** - "Run until tests pass" loops
5. **memory.md for continuity** - Track session state
6. **spec.md for planning** - Before any implementation
7. **Small, verifiable chunks** - Commit after each success
8. **Subagents for parallel** - Max 3 agents, focused objectives

---

## Sources

- [Cursor: Best practices for coding with agents](https://cursor.com/blog/agent-best-practices)
- [Addy Osmani: My LLM coding workflow 2026](https://addyosmani.com/blog/ai-coding-workflow/)
- [Vellum: Agentic Workflows Guide](https://www.vellum.ai/blog/agentic-workflows-emerging-architectures-and-design-patterns)
- [Microsoft: AI Agent Orchestration Patterns](https://learn.microsoft.com/en-us/azure/architecture/ai-ml/guide/ai-agent-design-patterns)
- [Vercel: AGENTS.md outperforms skills](https://vercel.com/blog/agents-md-outperforms-skills-in-our-agent-evals)
- [GitHub Blog: Lessons from 2,500+ repositories](https://github.blog/ai-and-ml/github-copilot/how-to-write-a-great-agents-md-lessons-from-over-2500-repositories/)
- [Callibrity: 10 Advanced Techniques for Claude Code](https://www.callibrity.com/articles/10-advanced-techniques-for-agentic-development-with-claude-code)
