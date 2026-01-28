---
description: Cross-repo resolution via Octocode/MCP-S (READ-ONLY); enrich ANALYSIS.md
globs:
alwaysApply: false
---

# /address-pr.resolve — Cross-Repo Resolution

Input:
- `.cursor/address-pr/<pr-number>/ANALYSIS.md`

## Git Read-Only Reminder

**FORBIDDEN:** `git commit`, `git push`, `gh pr comment`, `gh pr review`

This step only gathers information — no writes to git or PR.

## When to Use

This step is **mandatory** when:
- Comment references symbols not defined in the current repo
- Fix requires understanding external API contracts
- Cross-repo dependencies identified in analysis

## Octocode Research (for non-local symbols)

For each non-local symbol:

1) **Identify the symbol** — function, type, class, constant
2) **Use Octocode** to find:
   - Definition location (repo + file + line)
   - Implementation details
   - Usage patterns across repos
3) **Record proof** — file path + line numbers + snippet

See: `.cursor/skills/octocode-research/SKILL.md`

## MCP-S Context Gathering

When additional context needed:

1) **Jira** — linked tickets, acceptance criteria, related issues
2) **Slack** — discussions about this PR or feature
3) **Docs** — internal documentation, API specs
4) **DevEx** — code ownership, build status

See: `.cursor/skills/mcp-s/SKILL.md`

## Output

Update: `.cursor/address-pr/<pr-number>/ANALYSIS.md`

Add for each resolved symbol:
```markdown
### Cross-Repo Resolution

#### Symbol: {name}
- **Definition**: {repo}:{path}:{line}
- **Proof snippet**:
\`\`\`{lang}
{snippet}
\`\`\`
- **Contract/Interface**:
\`\`\`{lang}
{interface or type definition}
\`\`\`

#### Context from MCP-S
- **Jira**: {ticket links and relevant info}
- **Slack**: {thread links and summary}
- **Ownership**: {team/person from DevEx}
```

## Hard-fail if:
- Non-local symbol referenced but no Octocode proof recorded
- Cross-repo change needed but contract not verified

Then instruct: "Run `/address-pr.plan`."
