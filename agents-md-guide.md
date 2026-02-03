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

## How to Structure Your Instructions

### 1. Use the "Retrieval-Led Reasoning" Directive

Include this critical instruction:

```
IMPORTANT: Prefer retrieval-led reasoning over pre-training-led reasoning for any [domain] tasks.
```

This tells the agent to consult provided documentation rather than rely on potentially outdated training data.

### 2. Provide an Index, Not Full Content

You don't need to embed full documentation. A compressed index pointing to retrievable files works just as well:

```
[Docs Index] | root: ./docs

IMPORTANT: Prefer retrieval-led reasoning over pre-training-led reasoning

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

## Template for Creating Your Own AGENTS.md / CLAUDE.md

```markdown
# Project Instructions for AI Agents

## Project Overview
[Brief description of what this project does]

## Critical Instruction
IMPORTANT: Prefer retrieval-led reasoning over pre-training-led reasoning for any [framework/domain] tasks. Consult the documentation index below before relying on training data.

## Documentation Index
[Docs Index] | root: ./docs
|section-1:{file1.md,file2.md}
|section-2:{file3.md,file4.md}

## Project-Specific Patterns
- [Pattern 1]: We use X approach for Y
- [Pattern 2]: Always prefer A over B
- [Pattern 3]: Follow this naming convention...

## Version Information
- Framework version: X.Y.Z
- Key dependencies: [list versions that affect API usage]

## Workflow Guidelines
1. Explore the project structure to understand existing patterns
2. Consult the documentation index for API-specific questions
3. Match new code to existing project conventions
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

## Key Takeaways for AI Systems Generating Instructions

1. **Embed critical knowledge directly** — Don't rely on the agent deciding to look something up.

2. **Use retrieval-led reasoning directive** — Explicitly tell agents to prefer provided docs over training data.

3. **Provide indexed references** — A lightweight index to retrievable files beats full content dumps.

4. **Include version information** — Helps agents know which APIs are available.

5. **Document project-specific patterns** — Agents should match existing conventions, not just follow generic best practices.

6. **Avoid conditional triggers** — "If you need X, look up Y" fails 50%+ of the time. Just provide X upfront.

7. **Compress aggressively** — You can reduce context by 80% without losing effectiveness.

8. **Word instructions carefully** — "Explore first, then consult" beats "You MUST consult first."

---

## Source

This guide synthesizes findings from Vercel's agent evaluation research published January 27, 2026:
https://vercel.com/blog/agents-md-outperforms-skills-in-our-agent-evals
