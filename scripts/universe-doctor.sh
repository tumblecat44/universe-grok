#!/bin/bash
# Universe Grok - Diagnostic Powerhouse
# The central observability and evidence tool for the Hybrid Structural Governance System.
#
# Usage:
#   ./scripts/universe-doctor.sh --verbose
#   ./scripts/universe-doctor.sh --report
#   ./scripts/universe-doctor.sh ledger-audit <sha>
#   ./scripts/universe-doctor.sh --simulate
#
# This script is intentionally standalone and executable outside the harness
# so contributors can run it even before the plugin is fully loaded.

set -euo pipefail

VERSION="1.0.0-hybrid-2026-05-19"
MODE="${1:---verbose}"

WORKSPACE="${GROK_WORKSPACE_ROOT:-$(pwd)}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_header() {
  echo "=================================================================="
  echo "=== UNIVERSE GROK DIAGNOSTIC POWERHOUSE v$VERSION ==="
  echo "=== $(date) ==="
  echo "=================================================================="
  echo ""
}

detect_install_context() {
  echo ">>> INSTALLATION & ENVIRONMENT DETECTION"
  echo ""

  PLUGIN_ROOT=""
  RESOLVED=""
  INSTALL_TYPE="UNKNOWN"
  IS_SYMLINK="false"

  CANDIDATES=(
    "$WORKSPACE"
    "$HOME/.grok/plugins/universe-grok"
    "$HOME/.grok/plugins/marketplaces/universe-grok"
    "$HOME/.grok/plugins/cache/universe-grok"
  )

  for cand in "${CANDIDATES[@]}"; do
    if [ -d "$cand/.universe-grok" ]; then
      PLUGIN_ROOT="$(cd "$cand" && pwd -P)"
      break
    fi
  done

  if [ -z "$PLUGIN_ROOT" ]; then
    PLUGIN_ROOT="$WORKSPACE"
  fi

  RESOLVED="$(readlink -f "$PLUGIN_ROOT" 2>/dev/null || echo "$PLUGIN_ROOT")"
  if [ "$PLUGIN_ROOT" != "$RESOLVED" ]; then
    IS_SYMLINK="true"
  fi

  if echo "$PLUGIN_ROOT" | grep -q "marketplaces"; then
    INSTALL_TYPE="PROD_MARKETPLACE"
  elif [ -f "$HOME/.grok/config.toml" ] && grep -q "universe-grok" "$HOME/.grok/config.toml" 2>/dev/null; then
    if echo "$PLUGIN_ROOT" | grep -q "$HOME/.grok/plugins"; then
      INSTALL_TYPE="LOCAL_MARKETPLACE"
    else
      INSTALL_TYPE="GIT_MARKETPLACE"
    fi
  elif [ "$IS_SYMLINK" = "true" ]; then
    INSTALL_TYPE="RAW_SYMLINK"
  else
    INSTALL_TYPE="DIRECT_DEV"
  fi

  echo "PLUGIN_ROOT:        $PLUGIN_ROOT"
  echo "RESOLVED_ROOT:      $RESOLVED"
  echo "IS_SYMLINK:         $IS_SYMLINK"
  echo -e "INSTALL_TYPE:       ${GREEN}$INSTALL_TYPE${NC}"
  echo ""

  if [ "$INSTALL_TYPE" = "RAW_SYMLINK" ] || [ "$IS_SYMLINK" = "true" ]; then
    echo -e "${YELLOW}!!! WARNING: You are in RAW_SYMLINK / direct dev mode.${NC}"
    echo "   This is fine for rapid iteration but NOT sufficient evidence for Tier 1+ PRs."
    echo "   Use Local Marketplace registration + this doctor for credible claims."
    echo ""
  fi

  if [ "$INSTALL_TYPE" = "LOCAL_MARKETPLACE" ]; then
    echo -e "${GREEN}✓ LOCAL_MARKETPLACE mode — preferred for contribution evidence.${NC}"
    echo ""
  fi
}

check_truth_layer() {
  echo ">>> TRUTH LAYER HEALTH"
  echo ""

  TRUTH_ROOT="$PROJECT_ROOT/.universe-grok"
  if [ ! -d "$TRUTH_ROOT" ]; then
    echo -e "${RED}✗ .universe-grok/ directory missing — serious protocol violation${NC}"
    return 1
  fi

  echo "Location: $TRUTH_ROOT"
  ls -la "$TRUTH_ROOT/" | head -8
  echo ""

  if [ -f "$TRUTH_ROOT/CURRENT-TRUTH.md" ]; then
    echo -e "${GREEN}✓ CURRENT-TRUTH.md present${NC}"
    head -5 "$TRUTH_ROOT/CURRENT-TRUTH.md"
    echo "..."
  else
    echo -e "${RED}✗ CURRENT-TRUTH.md missing${NC}"
  fi

  echo ""
}

run_risk_classifier() {
  echo ">>> RISK CLASSIFICATION"
  echo ""

  if [ -x "$SCRIPT_DIR/classify-risk.sh" ]; then
    "$SCRIPT_DIR/classify-risk.sh" --auto --quiet || true
  else
    echo "(classify-risk.sh not yet present in this tree — run from a full checkout)"
  fi
  echo ""
}

print_recovery_commands() {
  echo ">>> RECOVERY & NEXT ACTIONS"
  echo ""
  echo "Most common fixes:"
  echo "  ./scripts/clear-grok-cache.sh          # After hook or skill edits"
  echo "  ./scripts/dev-setup.sh                 # Re-bootstrap contributor environment"
  echo "  ./scripts/universe-doctor.sh --verbose # Re-run this tool after fixes"
  echo ""
  echo "For Tier 0 work:"
  echo "  bash scripts/simulate-contribution.sh --tier0 --verify-injection"
  echo ""
}

main() {
  print_header
  detect_install_context
  check_truth_layer
  run_risk_classifier
  print_recovery_commands

  echo "=================================================================="
  echo "=== DOCTOR RUN COMPLETE ==="
  echo "Paste relevant sections (especially INSTALL_TYPE + truth health) into your PR."
  echo "=================================================================="
}

case "$MODE" in
  --verbose|--report|report)
    main
    ;;
  --help|help)
    echo "Universe Grok Diagnostic Powerhouse"
    echo "Usage: $0 [--verbose] [--report] [ledger-audit <sha>]"
    ;;
  ledger-audit)
    shift
    echo "Ledger audit mode not yet implemented in this synthesis version."
    echo "See Candidate 4 worktree for the full ledger-audit walker."
    ;;
  *)
    main
    ;;
esac