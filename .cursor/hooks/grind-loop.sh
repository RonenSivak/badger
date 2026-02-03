#!/bin/bash
# Grind Loop Hook - Run until tests pass (up to MAX_ITERATIONS)
#
# This hook is triggered on the "stop" event and decides whether to:
# - stop: Tests pass or max iterations reached
# - continue: Tests fail, keep iterating
#
# Usage: Configure in .cursor/hooks.json under "stop" event

set -e

read -r input

MAX_ITERATIONS=${MAX_ITERATIONS:-10}
current=$(echo "$input" | jq -r '.iteration // 0')

# Check if we have a package.json with test script
if [ ! -f "package.json" ]; then
  echo '{"decision": "stop"}'
  exit 0
fi

# Run tests and capture output
npm test 2>&1 > /tmp/test-output.txt
test_exit_code=$?

if [ $test_exit_code -eq 0 ]; then
  echo '{"decision": "stop"}'
  exit 0
fi

if [ "$current" -ge "$MAX_ITERATIONS" ]; then
  echo '{"decision": "stop", "user_message": "⚠️ Max iterations ('"$MAX_ITERATIONS"') reached. Tests still failing. Review manually."}'
  exit 0
fi

# Count failures for context
failures=$(grep -c "FAIL\|Error\|✗" /tmp/test-output.txt 2>/dev/null || echo "unknown")
next_iteration=$((current + 1))

# Continue with context about failures
cat << EOF
{
  "decision": "continue",
  "followup_message": "Tests failing ($failures issues). Iteration $next_iteration/$MAX_ITERATIONS. Analyzing failures and fixing...",
  "iteration": $next_iteration
}
EOF
