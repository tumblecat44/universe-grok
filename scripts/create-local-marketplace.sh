#!/bin/bash
# Universe Grok - Local Marketplace Generator
# Creates a marketplace.json manifest and prints the exact config snippet
# for registering this repo as a local development Marketplace source.
#
# This is the canonical tool for the "Local Marketplace Golden Path".

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

NAME="Universe Grok (Local Dev)"
ID="universe-grok-local"
VERSION=$(grep '^version' "$PROJECT_ROOT/plugin.toml" | head -1 | cut -d'"' -f2 || echo "dev")

OUTPUT_FILE="$PROJECT_ROOT/marketplace.json"

print_usage() {
  echo "Usage: $0 [--print-toml-snippet] [--validate] [--for-git]"
  echo ""
  echo "  --print-toml-snippet   Print the config.toml block to register this as local source"
  echo "  --validate             Validate the generated marketplace.json"
  echo "  --for-git              Output a version suitable for git-based marketplace source"
}

generate_manifest() {
  cat > "$OUTPUT_FILE" << EOF
{
  "name": "$NAME",
  "id": "$ID",
  "version": "$VERSION",
  "description": "Truth-seeking multi-agent orchestration harness for Grok Build (local development copy)",
  "plugins": [
    {
      "name": "universe-grok",
      "version": "$VERSION",
      "path": ".",
      "description": "Automatic extreme orchestration with forced truth layer injection",
      "capabilities": ["skills", "personas", "hooks"],
      "requires": {
        "grok_build": ">=0.1"
      }
    }
  ],
  "metadata": {
    "generated_by": "create-local-marketplace.sh",
    "generated_at": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")",
    "project_root": "$PROJECT_ROOT"
  }
}
EOF
  echo "✓ Generated $OUTPUT_FILE"
}

print_toml_snippet() {
  echo ""
  echo "Add this block to your ~/.grok/config.toml:"
  echo "───────────────────────────────────────────────────────────────"
  cat << EOF
[[marketplace.sources]]
name = "Universe Grok (Local Dev)"
path = "$PROJECT_ROOT"
enabled = true
EOF
  echo "───────────────────────────────────────────────────────────────"
  echo ""
  echo "Then in Grok Build TUI:"
  echo "  1. Open Marketplace tab"
  echo "  2. Press 'r' to refresh sources"
  echo "  3. Find 'universe-grok' under your local source and install it"
  echo ""
}

validate() {
  if [ ! -f "$OUTPUT_FILE" ]; then
    echo "✗ marketplace.json not found. Run without flags first."
    exit 1
  fi
  echo "✓ marketplace.json exists and is readable"
  # Basic structure check
  if grep -q '"universe-grok"' "$OUTPUT_FILE"; then
    echo "✓ Plugin entry found"
  else
    echo "✗ Plugin entry missing"
    exit 1
  fi
}

case "${1:-}" in
  --print-toml-snippet)
    generate_manifest > /dev/null
    print_toml_snippet
    ;;
  --validate)
    validate
    ;;
  --for-git)
    echo "For git-based marketplace source, use the repository URL instead of path."
    ;;
  --help|help)
    print_usage
    ;;
  *)
    generate_manifest
    echo ""
    echo "Next: run with --print-toml-snippet to get the registration block."
    ;;
esac