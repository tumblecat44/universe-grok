#!/bin/bash
# Universe Grok - Safe Contributor Environment Setup
# Idempotent script that puts you into a healthy development mode.

set -euo pipefail

echo "=== Universe Grok Dev Environment Setup ==="

mkdir -p ~/.grok/plugins
mkdir -p ~/.grok/personas

# Create symlink if not already present
if [ ! -L ~/.grok/plugins/universe-grok ]; then
  ln -s "$(pwd)" ~/.grok/plugins/universe-grok
  echo "✓ Symlink created: ~/.grok/plugins/universe-grok -> $(pwd)"
else
  echo "✓ Symlink already exists"
fi

# Copy personas
if [ -d personas ]; then
  cp -f personas/*.toml ~/.grok/personas/ 2>/dev/null || true
  echo "✓ Personas copied"
fi

echo ""
echo "Next steps:"
echo "  1. Run: ./scripts/create-local-marketplace.sh --print-toml-snippet"
echo "  2. Add the output to your ~/.grok/config.toml"
echo "  3. Install via Marketplace tab in Grok Build"
echo "  4. Run: ./scripts/universe-doctor.sh --verbose"
echo ""
echo "Done."