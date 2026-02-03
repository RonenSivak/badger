# How to Create Effective AI Agent Instructions

## Key Finding: Passive Context Beats Active Retrieval

Vercel's research (January 2026) found that **static instruction files embedded in project context dramatically outperform skill-based or tool-based retrieval systems** for teaching AI agents domain-specific knowledge.

| Approach | Pass Rate |
|----------|-----------|
| No documentation | 53% |
| Skills (on-demand retrieval) | 53% |
| Skills + explicit instructions | 79% |
| **AGENTS.md (passive context)** | **100%** |

---

## Core Principle: Prefer Passive Context Over Active Retrieval

### Why Passive Context Wins

1. **No decision point** — The agent doesn't have to decide "should I look this up?" The information is already present in every turn.

2. **Consistent availability** — Skills/tools load asynchronously and only when invoked. Passive context is always present.

3. **No ordering issues** — Active retrieval creates sequencing decisions (read docs first vs. explore first). Passive context avoids this entirely.

4. **No trigger failures** — In Vercel's tests, skills were never invoked in 56% of cases, even when available.

---

## Six Core Areas Every AGENTS.md Should Cover

Based on analysis of 2,500+ repositories (GitHub Blog, January 2026), the most effective AGENTS.md files cover these six areas:

| Area | What to Include |
|------|-----------------|
| **Commands** | Build, test, lint, format commands (prefer file-scoped) |
| **Testing** | How to run tests, test patterns, coverage requirements |
| **Project Structure** | Directory layout, key files, architecture overview |
| **Code Style** | Language version, patterns, naming conventions |
| **Git Workflow** | Branch strategy, commit format, PR process |
| **Boundaries** | ✅ Always do / ⚠️ Ask first / 🚫 Never do |

---

## Best Practices (Lessons from 2,500+ Repositories)

### Keep It Concise
- **Target ≤150 lines** — Long files slow the agent and bury signal
- Lead with concrete examples and file paths
- Use tables and lists over prose

### Use File-Scoped Commands
Instead of full project builds, provide per-file alternatives:
```bash
# Fast feedback (file-scoped)
npm run lint -- <file>       # Lint single file
npm run test -- <file>       # Test single file
tsc --noEmit <file>          # Type check single file
```

### Be Specific About Your Stack
```markdown
# Bad
React project with TypeScript

# Good
React 18.2, TypeScript 5.3, Vite 5.x, Tailwind CSS 3.4
```

### Use Three-Tier Boundaries
```markdown
## Boundaries

### ✅ Always
- Run tests before committing
- Use TypeScript strict mode

### ⚠️ Ask First
- Adding new dependencies
- Changing public APIs

### 🚫 Never
- Commit secrets or .env files
- Skip type checking
- Modify vendor directories
```

### Iterate on Mistakes
Add a rule the **second time** you see the same mistake. The best AGENTS.md files grow through iteration, not upfront planning.

### Use Nested/Modular Files
Place AGENTS.md inside each package/subproject. Agents read the nearest file in the directory tree:
```
project/
├── AGENTS.md                    # Root instructions
├── packages/
│   ├── frontend/
│   │   └── AGENTS.md           # Frontend-specific
│   └── backend/
│       └── AGENTS.md           # Backend-specific
└── .cursor/kits/
    └── my-kit/
        └── AGENTS.md           # Kit-specific
```

### Keep Synchronized with Code
Update AGENTS.md in the same PR when build, test, or conventions change.

---

## How to Structure Your Instructions

### 1. Use the "Retrieval-Led Reasoning" Directive

Include this critical instruction at the top:

```
IMPORTANT: Prefer retrieval-led reasoning over pre-training-led reasoning for any [domain] tasks.
```

This tells the agent to consult provided documentation rather than rely on potentially outdated training data.

### 2. Provide an Index, Not Full Content

You don't need to embed full documentation. A compressed index pointing to retrievable files works just as well:

```
[Docs Index]|root:./docs
|IMPORTANT: Prefer retrieval-led reasoning over pre-training-led reasoning
|api/authentication:{oauth.md,jwt.md,sessions.md}
|api/endpoints:{users.md,products.md,orders.md}
|guides:{quickstart.md,best-practices.md,migration.md}
```

The agent can then read specific files as needed.

### 3. Compress Aggressively

Vercel reduced their docs index from 40KB to 8KB (80% reduction) while maintaining 100% pass rate. Use formats like:

- Pipe-delimited structures
- Abbreviated paths
- File lists without full content

---

## Instruction Wording Matters

**Different wordings produce dramatically different results:**

| Instruction Style | Behavior | Outcome |
|-------------------|----------|---------|
| "You MUST invoke the skill first" | Reads docs first, anchors on doc patterns | Misses project context |
| "Explore project first, then consult docs" | Builds mental model first, uses docs as reference | Better results |

### Best Practice

Structure instructions to encourage:
1. First: Understand the project structure and existing patterns
2. Then: Consult documentation for specific APIs/features
3. Finally: Generate code that fits both docs AND project context

---

## Template for Creating Your Own AGENTS.md

```markdown
# Project Name - Agent Instructions

IMPORTANT: Prefer retrieval-led reasoning over pre-training-led reasoning.

## Docs Index
[Docs]|root:./docs
|api:{auth.md,users.md,products.md}
|guides:{quickstart.md,patterns.md}

## Commands
```bash
# File-scoped (fast feedback)
npm run lint -- <file>
npm run test -- <file>
tsc --noEmit

# Full project
npm run build
npm run test
```

## Code Style
- TypeScript 5.x strict mode
- React 18 functional components
- Prefer named exports

## Project Structure
```
src/
├── components/    # React components
├── hooks/         # Custom hooks
├── services/      # API clients
└── utils/         # Pure functions
```

## Git Workflow
- Branch from `main`
- Commit format: `<type>: <description>`
- Run tests before PR

## Boundaries

### ✅ Always
- Explore project structure first
- Run tests after changes
- Type all function parameters

### ⚠️ Ask First
- Adding dependencies
- Changing public APIs
- Architectural changes

### 🚫 Never
- Commit secrets
- Skip type checking
- Modify generated files
```

---

## When to Use Skills/Tools vs. Passive Context

| Use Case | Best Approach |
|----------|---------------|
| General framework knowledge | Passive context (AGENTS.md) |
| Broad horizontal improvements | Passive context |
| Specific triggered workflows (e.g., "upgrade my version") | Skills/Tools |
| Action-specific tasks user explicitly requests | Skills/Tools |

Skills are better for **vertical, action-specific workflows** that users explicitly trigger. Passive context is better for **horizontal, always-relevant knowledge**.

---

## Key Takeaways

1. **Embed critical knowledge directly** — Don't rely on the agent deciding to look something up.

2. **Cover six core areas** — Commands, testing, structure, style, git, boundaries.

3. **Keep it concise (≤150 lines)** — Long files bury signal in noise.

4. **Use retrieval-led reasoning directive** — Explicitly tell agents to prefer provided docs over training data.

5. **Provide indexed references** — A lightweight index to retrievable files beats full content dumps.

6. **Use file-scoped commands** — Faster feedback, fewer wasted cycles.

7. **Include version information** — Helps agents know which APIs are available.

8. **Use three-tier boundaries** — Always/Ask First/Never provides clear guardrails.

9. **Nest AGENTS.md per subproject** — Each package/kit can have tailored instructions.

10. **Iterate when mistakes happen** — Add rules on the second occurrence.

11. **Compress aggressively** — You can reduce context by 80% without losing effectiveness.

12. **Word instructions carefully** — "Explore first, then consult" beats "You MUST consult first."

---

## Sources

- [Vercel: AGENTS.md outperforms skills in our agent evals](https://vercel.com/blog/agents-md-outperforms-skills-in-our-agent-evals) (January 2026)
- [GitHub Blog: How to write a great agents.md](https://github.blog/ai-and-ml/github-copilot/how-to-write-a-great-agents-md-lessons-from-over-2500-repositories/) (January 2026)
- [Builder.io: Improve your AI code output with AGENTS.md](https://www.builder.io/blog/agents-md)
- [AGENTS.md Official Site](https://agents.md/)
- [OpenAI Codex: Custom instructions with AGENTS.md](https://developers.openai.com/codex/guides/agents-md)
