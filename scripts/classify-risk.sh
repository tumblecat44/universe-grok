#!/bin/bash
# Universe Grok - Risk Classifier (Tiered Governance)
# Mechanical classification of contribution risk based on files touched.

set -euo pipefail

AUTO=false
QUIET=false

while [[ $# -gt 0 ]]; do
  case $1 in
    --auto) AUTO=true; shift ;;
    --quiet) QUIET=true; shift ;;
    *) shift ;;
  esac
done

TIER=3
REASON=""

# Nuclear / Tier 0
if git diff --name-only --cached --diff-filter=ACM 2>/dev/null | grep -qE '(\.universe-grok/|hooks/session-start|GOVERNANCE\.md|AGENTS\.md|CONSTITUTION\.md|skills/universe-grok/SKILL\.md)'; then
  TIER=0
  REASON="Layer 0 / hook / governance file touched"
fi

# High / Tier 1
if [ "$TIER" -gt 1 ] && git diff --name-only --cached --diff-filter=ACM 2>/dev/null | grep -qE '(personas/|skills/.*SKILL\.md)'; then
  TIER=1
  REASON="Persona or core skill change"
fi

echo "TIER: $TIER"
if [ "$QUIET" != "true" ]; then
  echo "Reason: $REASON"
  echo ""
  case $TIER in
    0) echo "NUCLEAR (Tier 0) — Full harness + simulation + stewards required" ;;
    1) echo "HIGH (Tier 1) — Doctor + evidence artifacts required" ;;
    2) echo "MEDIUM (Tier 2) — Doctor + basic artifacts" ;;
    3) echo "LOW (Tier 3) — Doctor recommended" ;;
  esac
fi

exit 0