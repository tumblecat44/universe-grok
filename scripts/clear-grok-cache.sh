#!/bin/bash
# Universe Grok - Cache & Stale State Cleaner
# Run this after editing hooks, skills, or personas during development.
# This is the most common recovery command contributors will need.

set -euo pipefail

echo "=== Clearing Grok Build caches for Universe Grok development ==="

# Common cache locations
CACHES=(
  "$HOME/.grok/plugins/cache"
  "$HOME/.grok/plugins/marketplaces/cache"
  "$HOME/.cache/grok"
  "$HOME/.grok/universe-grok"
)

for cache in "${CACHES[@]}"; do
  if [ -d "$cache" ]; then
    echo "Cleaning: $cache"
    rm -rf "$cache"/* 2>/dev/null || true
  fi
done

# Remove session markers that might hold stale state
find "$HOME/.grok" -name "*universe-grok*" -type f -delete 2>/dev/null || true

echo ""
echo "✓ Cache cleared."
echo ""
echo "Recommended next steps:"
echo "  1. Restart Grok Build (or reload plugins)"
echo "  2. Start a fresh session"
echo "  3. Run: ./scripts/universe-doctor.sh --verbose"
echo ""
echo "Note: If you are using Local Marketplace, you may need to re-install the plugin from the Marketplace tab after clearing."