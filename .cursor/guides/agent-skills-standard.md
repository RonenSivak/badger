# Agent Skills Standard Reference

Quick reference for the [Agent Skills](https://agentskills.io/home) open standard, as supported by Cursor.

> **Sources**: [Overview](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/overview) | [Best Practices](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices)

---

## SKILL.md Structure

```yaml
---
name: skill-name-here
description: "What it does AND when to use it. Third person."
---

# Skill Title

Instructions, workflows, examples...
```

---

## Frontmatter Requirements

| Field | Requirement |
|-------|-------------|
| `name` | Required. ≤64 chars, lowercase letters/numbers/hyphens only. No XML tags. No "anthropic" or "claude". |
| `description` | Required. ≤1024 chars, non-empty. No XML tags. Third person voice. |

---

## Naming Convention

**Preferred**: Gerund form (verb + -ing)

| Good | Bad |
|------|-----|
| `processing-pdfs` | `pdf-processor` |
| `reviewing-code` | `code-review` |
| `implementing-features` | `implement` |
| `troubleshooting` | `troubleshoot` |
| `merging-branches` | `smart-merge` |

---

## Body Guidelines

- **Length**: Keep under 500 lines for optimal performance
- **Quick Start**: Include at the top
- **Workflow Checklist**: Copy-paste checklist pattern encouraged
- **Progressive Disclosure**: Link to reference files (one level deep)
- **Examples**: Include input/output examples where helpful

---

## Progressive Disclosure Pattern

```markdown
# Main Skill

## Quick Start
[Brief instructions]

## Detailed Guide
See [reference.md](reference.md) for complete details.
See [examples.md](examples.md) for patterns.
```

**Rule**: Keep references one level deep from SKILL.md.

---

## Description Best Practices

Include BOTH:
1. **What it does**: The capability
2. **When to use it**: Trigger conditions

```yaml
# Good
description: "Generate BDD tests using proven patterns. Use when adding tests for a feature, following the codebase's testing stack."

# Bad (missing "when to use")
description: "Generates tests for code."

# Bad (missing "what it does")
description: "Use when you need tests."
```

---

## File Structure

```
.cursor/skills/
├── skill-name/
│   ├── SKILL.md          # Required
│   ├── REFERENCE.md      # Optional detailed docs
│   ├── EXAMPLES.md       # Optional examples
│   └── scripts/          # Optional utility scripts
│       └── helper.py
```

---

---

## Skill Types (Badger Pattern)

**Full Workflow Skills** — Complete workflows with all sections:
- Quick Start, Workflow Checklist, Examples, Hard-fail conditions
- Examples: `deep-searching`, `implementing`, `troubleshooting`

**Minimal/Pointer Skills** — Intentionally small, point to passive context:
- Reference AGENTS.md sections or guides
- Examples: `querying-mcp-s`, `researching-octocode`

Both are valid per the "concise is key" principle.

---

## Compliance Checklist

Use this when creating or auditing skills:

### Frontmatter (Required)
- [ ] `name` present and valid (lowercase, hyphens, ≤64 chars)
- [ ] `name` uses gerund form (verb + -ing)
- [ ] `description` present and non-empty (≤1024 chars)
- [ ] `description` includes WHAT it does
- [ ] `description` includes WHEN to use it
- [ ] `description` uses third person voice

### Body Structure (Full Workflow Skills)
- [ ] Title matches the skill name
- [ ] Quick Start section at the top
- [ ] Workflow Checklist (copy-paste pattern)
- [ ] Examples section with concrete input/output
- [ ] Hard-fail conditions section
- [ ] Body under 500 lines

### Body Structure (Minimal Skills)
- [ ] Clear pointer to AGENTS.md sections or guides
- [ ] Explains when to use
- [ ] Under 50 lines total

### Progressive Disclosure
- [ ] References to other files are one level deep
- [ ] All referenced files exist (no orphans)
- [ ] Links use relative paths (`../guide.md`)

### Verification
- [ ] No broken internal references
- [ ] Title header matches `name` field
- [ ] No time-sensitive information
