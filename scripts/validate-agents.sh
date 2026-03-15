#!/usr/bin/env bash
# Validates all agent definition files in .claude/agents/
# Checks: YAML front matter exists, required fields present, body is non-empty

set -euo pipefail

AGENTS_DIR="${1:-.claude/agents}"
total_errors=0
checked=0

if [ ! -d "$AGENTS_DIR" ]; then
  echo "Error: agents directory not found at $AGENTS_DIR"
  exit 1
fi

for file in "$AGENTS_DIR"/*.md; do
  [ -f "$file" ] || continue
  checked=$((checked + 1))
  file_errors=0
  filename=$(basename "$file")

  # Check for YAML front matter delimiters
  first_line=$(head -1 "$file")
  if [ "$first_line" != "---" ]; then
    echo "FAIL  $filename: missing YAML front matter (no opening ---)"
    total_errors=$((total_errors + 1))
    continue
  fi

  # Find closing delimiter
  closing_line=$(tail -n +2 "$file" | grep -n "^---$" | head -1 | cut -d: -f1)
  if [ -z "$closing_line" ]; then
    echo "FAIL  $filename: missing closing --- in front matter"
    total_errors=$((total_errors + 1))
    continue
  fi

  # Extract front matter (between the two --- lines)
  front_matter=$(sed -n "2,$((closing_line))p" "$file")

  # Check required fields
  for field in name description tools; do
    if ! echo "$front_matter" | grep -q "^${field}:"; then
      echo "FAIL  $filename: missing required field '$field'"
      file_errors=$((file_errors + 1))
    fi
  done

  # Check body content (after closing ---)
  body_start=$((closing_line + 2))
  body=$(tail -n +"$body_start" "$file" | sed '/^$/d')
  if [ -z "$body" ]; then
    echo "FAIL  $filename: empty body (no agent instructions)"
    file_errors=$((file_errors + 1))
  fi

  # Check name field is not empty
  name_value=$(echo "$front_matter" | grep "^name:" | sed 's/^name:[[:space:]]*//')
  if [ -z "$name_value" ]; then
    echo "FAIL  $filename: 'name' field is empty"
    file_errors=$((file_errors + 1))
  fi

  if [ $file_errors -eq 0 ]; then
    echo "OK     $filename"
  fi

  total_errors=$((total_errors + file_errors))
done

if [ $checked -eq 0 ]; then
  echo "No agent files found in $AGENTS_DIR"
  exit 1
fi

echo ""
if [ $total_errors -gt 0 ]; then
  echo "RESULT: $total_errors error(s) in $checked agent file(s)"
  exit 1
else
  echo "RESULT: All $checked agent file(s) passed validation"
  exit 0
fi
