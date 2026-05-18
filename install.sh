#!/bin/bash
# Universe Grok - One-line-ish installer

set -e

echo "Installing Universe Grok..."

PLUGIN_DIR="$HOME/.grok/plugins/universe-grok"

if [ -d "$PLUGIN_DIR" ]; then
    echo "Universe Grok already exists at $PLUGIN_DIR"
    echo "Pulling latest changes..."
    cd "$PLUGIN_DIR" && git pull
else
    echo "Cloning into $PLUGIN_DIR..."
    git clone https://github.com/your-org/universe-grok.git "$PLUGIN_DIR"
fi

echo "Copying personas..."
mkdir -p "$HOME/.grok/personas"
cp "$PLUGIN_DIR/personas/"*.toml "$HOME/.grok/personas/" || true

echo ""
echo "✅ Universe Grok installed."
echo ""
echo "Next steps:"
echo "  1. Restart Grok Build (or run /plugins reload if available)"
echo "  2. Try: 'universe mode' or '/universe' on a complex task"
echo ""
echo "For updates: cd $PLUGIN_DIR && git pull"
