# SKILL: Conventional branch naming (for split branches)

## Goal
Make branch purpose obvious and consistent.

## Recommended format
`<type>/<scope>/<short-kebab>`

Examples:
- `feat/app-router/add-validation`
- `fix/router/prefix-conflict`
- `refactor/editor-sdk/extract-utils`
- `chore/ci/update-pipeline`

## Map buckets → types
- new behavior: `feat`
- bug/regression: `fix`
- internal cleanup: `refactor`
- build/tools: `chore`
- docs-only: `docs`

## Scope selection
Pick something stable:
- package name
- domain name
- service name
- folder boundary
