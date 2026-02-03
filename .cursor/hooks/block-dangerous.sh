#!/usr/bin/env bash
set -euo pipefail

input="$(cat || true)"
command="$(
  printf '%s' "$input" | jq -r '.command // empty' 2>/dev/null || true
)"

if [[ -z "${command}" || "${command}" == "null" ]]; then
  echo '{"decision":"allow"}'
  exit 0
fi

if printf '%s' "${command}" | grep -Eq '(^|[[:space:]])rm[[:space:]]+-rf([[:space:]]|$)|git[[:space:]]+push[[:space:]]+--force|git[[:space:]]+reset[[:space:]]+--hard|git[[:space:]]+clean[[:space:]]+-fd|DROP[[:space:]]+TABLE'; then
  echo '{"decision":"deny","reason":"Dangerous command blocked by Badger hook"}'
  exit 2
fi

echo '{"decision":"allow"}'

