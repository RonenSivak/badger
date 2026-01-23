# Skill: Octocode Cross-Repo Research

## When to use
Any time a symbol/call is not fully provable in the current workspace.

## How to use (required)
Run: /octocode/research

Goal: resolve the symbol to:
1) definition (where declared)
2) implementation (where it actually runs)
3) side-effect boundary snippet (network/persist/render/throw)

## Output discipline (required)
- Always include repo + path + line range + snippet.
- Record exact query strings in:
  .cursor/deep-search/<feature>/octocode-queries.md
- If ambiguous, run multiple queries until disambiguated.
- If still not found: mark NOT FOUND and list searches + scope.
