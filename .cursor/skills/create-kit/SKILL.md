# Create-Kit Skill

Purpose: help the agent generate **repeatable Cursor workflows** (commands + rules + skills) without bloating context.

## Principles
- Start with a plan (KIT SPEC + FILE-MAP).
- Keep commands procedural, rules enforceable, skills instructional.
- Prefer modular subcommands over one long command to reduce drift.
- Add verification gates before publishing.

## KIT SPEC template
- Kit name:
- Orchestrator command:
- Subcommands:
- Rules:
- Skills:
- Required tools/MCPs:
- Outputs generated:
- Quality gates:
- Example prompt:

## FILE-MAP template
For each file:
- Path:
- Type: command | rule | skill | docs
- Referenced by:
- Purpose:

## Verify checklist
- Frontmatter present on all `.mdc`
- Delegates exist
- Rule/skill references exist
- Naming consistent
- README created
