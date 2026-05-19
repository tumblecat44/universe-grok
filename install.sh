#!/bin/bash
# Universe Grok - One-line-ish installer

set -e

echo "Installing Universe Grok..."

PLUGIN_DIR="$HOME/.grok/plugins/universe-grok"

if [ -d "$PLUGIN_DIR" ]; then
    echo "Universe Grok already exists at $PLUGIN_DIR"
    echo "Pulling latest changes..."
    cd "$PLUGIN_DIR" && git pull --ff-only
else
    echo "Cloning into $PLUGIN_DIR..."
    git clone https://github.com/your-org/universe-grok.git "$PLUGIN_DIR"
fi

echo "Copying personas to global..."
mkdir -p "$HOME/.grok/personas"
cp "$PLUGIN_DIR/personas/"*.toml "$HOME/.grok/personas/" || true

echo "Registering skills via symlinks (idempotent)..."
mkdir -p "$HOME/.grok/skills"
for skill in first-questions first-principles universe-grok universe-grok-install; do
    ln -sfn "$PLUGIN_DIR/skills/$skill" "$HOME/.grok/skills/$skill" 2>/dev/null || true
done

echo "Making hook scripts executable..."
chmod +x "$PLUGIN_DIR/hooks/"*.sh 2>/dev/null || true

echo ""
echo "✅ Universe Grok installed / updated."
echo ""
echo "=== CRITICAL ACTIVATION STEPS (do these once) ==="
echo ""
echo "1. In Grok Build, press Ctrl+L to open the modal"
echo "   - Go to the Plugins tab (Tab to switch)"
echo "   - Select 'universe-grok (user)'"
echo "   - Press SPACE to toggle it from [disabled] → enabled (green)"
echo "   - Press 'r' to reload"
echo ""
echo "2. For this repository's SessionStart hook (the one that injects full Universe Grok mode + mandatory research):"
echo "   Run inside the project:   /hooks-trust"
echo "   (or open Ctrl+L → Hooks tab → trust this project)"
echo ""
echo "3. Restart Grok Build session or run /plugins reload"
echo ""
echo "After that, opening this repo will auto-activate full Universe Grok mode (no keyword needed)."
echo ""
echo "For updates later: cd $PLUGIN_DIR && git pull"
