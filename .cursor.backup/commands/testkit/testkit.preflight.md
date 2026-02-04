---
description: Preflight the repo so lint/tsc/tests can run deterministically before implementing tests
globs:
alwaysApply: false
---

# /testkit.preflight — Preflight 🧰✅

Goal: ensure the repo is runnable BEFORE writing code.

## Steps (MANDATORY)
1) Detect package manager + workspace root:
- Prefer lockfile detection:
  - `yarn.lock` → yarn
  - `pnpm-lock.yaml` → pnpm
  - `package-lock.json` → npm

2) Install dependencies deterministically:
- yarn: `yarn install --immutable` (or repo’s documented equivalent)
- pnpm: `pnpm install --frozen-lockfile`
- npm: `npm ci` (requires lock in sync)

3) Discover the canonical commands:
- read package scripts and/or repo docs:
  - lint command
  - typecheck/tsc command
  - test command

4) Run a smoke check:
- pick ONE fast signal:
  - typecheck OR lint
- if it fails:
  - fix environment issues first (missing install, wrong node, wrong workspace root)

## Output (MANDATORY)
Write `.cursor/testkit/<feature>/PREFLIGHT.md` with:
- detected package manager + root
- exact commands run
- results (PASS/FAIL)
- if FAIL: what was fixed / what blocks running
