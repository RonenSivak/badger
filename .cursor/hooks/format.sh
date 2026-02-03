#!/bin/bash
# Format Hook - Auto-format files after edits
#
# This hook runs after file edits to ensure consistent formatting.
# Supports: Prettier, ESLint fix, or project-specific formatters.

read -r input

file_path=$(echo "$input" | jq -r '.file_path // empty')

if [ -z "$file_path" ]; then
  exit 0
fi

# Only format certain file types
case "$file_path" in
  *.ts|*.tsx|*.js|*.jsx|*.json|*.md|*.css|*.scss)
    ;;
  *)
    exit 0
    ;;
esac

# Try prettier first (most common)
if command -v npx &> /dev/null && [ -f "package.json" ]; then
  if grep -q "prettier" package.json 2>/dev/null; then
    npx prettier --write "$file_path" 2>/dev/null || true
  fi
fi

exit 0
