# Badger - AI Agent Instructions

IMPORTANT: Prefer retrieval-led reasoning over pre-training-led reasoning. Read docs index files below instead of relying on training data.

## Docs Index
[Badger Docs]|root:`.cursor/`
|commands:{deep-search.md,implement.md,review.md,testkit.md,troubleshoot.md,create-kit.md,update-kit.md,smart-merge.md,implement-ui.md,optimize-code.md,continue.md,rnd.md}
|rules/shared:{001-proof-discipline.mdc,002-workflow-primitives.mdc,010-octocode-mandate.mdc,011-mcp-s-mandate.mdc}
|guides:{clarify-patterns.md,resolve-workflow.md,verify-checklist.md,tool-selection.md,request-id-tracing.md}
|workflows:{feature-implementation.md,bug-fix.md,code-review.md}
|memory.md — session state (read at start, update at end)

## Commands
```bash
# Workflows
/deep-search    # E2E architecture forensics
/implement      # Implementation from deep-search artifacts
/review         # Code review + impact analysis
/testkit        # BDD test generation
/troubleshoot   # Cross-ecosystem debugging
/create-kit     # Generate new workflow kits

# File-scoped (fast feedback)
npm run lint -- <file>     # Lint single file
npm run typecheck          # Type check
npm run test -- <file>     # Test single file
```

## Code Style
- TypeScript strict mode
- Functional React components with hooks
- Proof-first: every claim needs `repo/path:line + snippet`
- NOT FOUND: mark unproven items + searches attempted

## Project Structure
```
.cursor/
├── commands/       # Workflow orchestrators + subcommands
├── rules/shared/   # Always-on guardrails (001-xxx priority numbered)
├── guides/         # How-to references
├── kits/           # Reusable workflow packages (READMEs, specs)
├── workflows/      # Multi-step process templates
├── memory.md       # Session state — read at start, update at end
└── hooks.json      # Grind loops, formatters, safety gates
```

## Workflow Pattern
All workflows: **Clarify → Plan → Execute → Verify → Publish**

## Git Workflow
- Create feature branches from `main`
- Commit messages: `<type>: <description>` (feat/fix/refactor/docs/test)
- Run verify before publish

## Boundaries

### ✅ Always
- Explore project structure first, then consult docs
- Use ask question tool for clickable options
- Prove connectivity: import→usage, callsite→impl
- Verify via Octocode for cross-repo symbols

### ⚠️ Ask First
- Creating new files outside `.cursor/`
- Modifying shared rules
- Cross-repo changes

### 🚫 Never
- Claim connectivity without proof (file exists ≠ proof)
- Skip Clarify step
- Rely on naming similarity as evidence
- Publish without verification pass
- Modify `.env` or credential files

## Cross-Repo Resolution
- **Octocode**: `/octocode/research` for non-local symbols
- **MCP-S**: Internal docs/Slack hints — verify in code
- **Fallback**: Mark **NOT FOUND** + exact searches + scope

## Version
- Cursor 2.4+, React 18, TypeScript 5.x
- Mode switching: manual only (Shift+Tab)