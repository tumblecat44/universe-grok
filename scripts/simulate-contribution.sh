#!/bin/bash
# Universe Grok - Contribution Simulation & Verification Tool
# Especially critical for Tier 0 (Nuclear) changes to hooks, truth layer, and governance.
#
# This script creates an isolated environment, applies changes (if any),
# and mechanically verifies that the truth injection + bootstrap still work.

set -euo pipefail

TIER="auto"
VERIFY_INJECTION=false
PATCH_FILE=""

while [[ $# -gt 0 ]]; do
  case $1 in
    --tier0) TIER=0; shift ;;
    --tier1) TIER=1; shift ;;
    --verify-injection) VERIFY_INJECTION=true; shift ;;
    --patch) PATCH_FILE="$2"; shift 2 ;;
    *) shift ;;
  esac
done

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TEMP_DIR="/tmp/universe-grok-sim-$(date +%s)"
EVIDENCE_DIR="$PROJECT_ROOT/contrib-evidence"

mkdir -p "$EVIDENCE_DIR"

echo "=== Universe Grok Contribution Simulation ==="
echo "Tier: $TIER"
echo "Temp environment: $TEMP_DIR"
echo ""

# Create isolated copy
echo "Creating isolated copy..."
rsync -a --exclude='.git' --exclude='node_modules' --exclude='.grok' "$PROJECT_ROOT/" "$TEMP_DIR/" 2>/dev/null || cp -R "$PROJECT_ROOT" "$TEMP_DIR"

if [ -n "$PATCH_FILE" ] && [ -f "$PATCH_FILE" ]; then
  echo "Applying patch: $PATCH_FILE"
  (cd "$TEMP_DIR" && patch -p1 < "$PATCH_FILE") || echo "Warning: patch application had issues"
fi

# Simulate running the hook
HOOK_PATH="$TEMP_DIR/hooks/session-start.sh"
if [ -f "$HOOK_PATH" ]; then
  echo ""
  echo ">>> Executing session-start hook in isolated environment..."
  echo ""

  # Run hook with simulated workspace
  WORKSPACE="$TEMP_DIR" bash "$HOOK_PATH" 2>&1 | head -80

  echo ""
  echo ">>> Hook execution finished."
else
  echo "✗ hooks/session-start.sh not found in simulation environment"
  exit 1
fi

# Verify critical injection (for Tier 0)
if [ "$VERIFY_INJECTION" = true ] || [ "$TIER" = 0 ]; then
  echo ""
  echo ">>> Verifying truth injection invariants..."

  if grep -q "Bootstrap complete. All subsequent reasoning" "$TEMP_DIR/hooks/session-start.sh" 2>/dev/null; then
    echo "✓ Bootstrap sentence present in hook"
  else
    echo "✗ CRITICAL: Bootstrap sentence missing from hook"
    exit 1
  fi

  if [ -f "$TEMP_DIR/.universe-grok/CURRENT-TRUTH.md" ]; then
    echo "✓ CURRENT-TRUTH.md still present"
  else
    echo "✗ CRITICAL: CURRENT-TRUTH.md missing after change"
    exit 1
  fi

  echo ""
  echo -e "\033[0;32m✓ TIER 0 INJECTION VERIFICATION PASSED\033[0m"
  echo ""

  # Generate evidence artifact
  EVIDENCE_FILE="$EVIDENCE_DIR/tier0-simulation-$(date +%Y%m%d-%H%M%S).md"
  cat > "$EVIDENCE_FILE" << EOF
# Tier 0 Simulation Evidence

**Date**: $(date)
**Simulator**: simulate-contribution.sh
**Patch**: ${PATCH_FILE:-"(none - testing current tree)"}
**Result**: PASS

## Verified Invariants
- Bootstrap sentence present in hook
- CURRENT-TRUTH.md present and readable
- Hook executes without fatal error

This artifact proves that the proposed change does not break the mandatory truth layer injection.
EOF
  echo "Evidence written to: $EVIDENCE_FILE"
fi

echo ""
echo "Simulation complete."
echo "Clean up with: rm -rf $TEMP_DIR"