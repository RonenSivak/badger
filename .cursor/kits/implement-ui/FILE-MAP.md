# implement-ui File Map

All files to be created during scaffolding.

## Commands

| Path | Role | Referenced By |
|------|------|---------------|
| `.cursor/commands/implement-ui.md` | Orchestrator | User invokes `/implement-ui` |
| `.cursor/commands/implement-ui/implement-ui.clarify.md` | Clarify input mode + requirements | Orchestrator |
| `.cursor/commands/implement-ui/implement-ui.analyze.md` | Extract specs from Figma/semantic | Orchestrator |
| `.cursor/commands/implement-ui/implement-ui.plan.md` | Map to WDS components | Orchestrator |
| `.cursor/commands/implement-ui/implement-ui.implement.md` | Generate React+TS code | Orchestrator |
| `.cursor/commands/implement-ui/implement-ui.verify.md` | Visual/requirements verification | Orchestrator |
| `.cursor/commands/implement-ui/implement-ui.publish.md` | Summary + usage notes | Orchestrator |

## Rules

| Path | Role | Referenced By |
|------|------|---------------|
| `.cursor/rules/implement-ui/implement-ui-laws.mdc` | Workflow gates + hard constraints | Orchestrator, all subcommands |
| `.cursor/rules/implement-ui/wds-mandate.mdc` | WDS usage rules (must check list first, NOT FOUND flow) | analyze, plan, implement |
| `.cursor/rules/shared/octocode-mandate.mdc` | When to use Octocode for non-local symbols + pattern search | plan, implement |

## Skills

| Path | Role | Referenced By |
|------|------|---------------|
| `.cursor/skills/implement-ui/SKILL.md` | Quick reference for the kit | User, other agents |

## Summary

- **Commands**: 7 files (1 orchestrator + 6 subcommands)
- **Rules**: 3 files
- **Skills**: 1 file
- **Total**: 11 files

## Generated During Runs (not scaffolded)

| Path Pattern | Created By |
|--------------|------------|
| `.cursor/implement-ui/<task>/UI-SPEC.md` | clarify |
| `.cursor/implement-ui/<task>/COMPONENT-MAP.md` | plan |
| `.cursor/implement-ui/<task>/VERIFICATION-REPORT.md` | verify |
