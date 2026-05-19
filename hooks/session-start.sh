#!/bin/bash
# Universe Grok - Session Start Truth-Seeking Hook
# This hook creates the mandatory research request that forces the agent
# to use Grok Build's built-in `x_search` and `web_search` tools at session start.

set -euo pipefail

echo "[Universe Grok] SessionStart hook executing..."

WORKSPACE="${GROK_WORKSPACE_ROOT:-$(pwd)}"

# === FORCED CURRENT TRUTH LAYER INJECTION (Core enforcement for Mandatory Session Bootstrap) ===
# This block is the actual mechanism that makes truth collection non-bypassable.
# It is printed to stdout by the hook command on EVERY SessionStart.
# The Grok Build hook system surfaces command output at the absolute start of the agent session.
# Therefore the agent is FORCIBLY GIVEN the .universe-grok/ ls + full active truth contents
# before any user request analysis or other files are considered.
# This directly completes the gap: previous version only created markers but did not inject truth.
# Per CURRENT-TRUTH.md One-Sentence Goal and AGENTS.md bootstrap protocol, this forces
# every agent (orchestrator + all subagents via propagation) to derive exclusively from the layer.
TRUTH_ROOT="$WORKSPACE/.universe-grok"
if [ -d "$TRUTH_ROOT" ]; then
  echo "=================================================================="
  echo "=== FORCED CURRENT TRUTH LAYER INJECTION AT SESSION START ==="
  echo "=== (Sole source per CURRENT-TRUTH.md; bootstrap is now mechanical) ==="
  echo "=================================================================="
  echo ""
  echo ">>> .universe-grok/ DIRECTORY LISTING (first action: discover this):"
  ls -la "$TRUTH_ROOT/" 2>/dev/null || echo "(ls failed)"
  echo ""
  echo ">>> FULL CONTENT: CURRENT-TRUTH.md (PRIMARY + EXCLUSIVE AUTHORITY - INTERNALIZE END-TO-END)"
  echo "--------------------------------------------------------------------------------"
  cat "$TRUTH_ROOT/CURRENT-TRUTH.md" 2>/dev/null || echo "(CURRENT-TRUTH.md missing - protocol violation)"
  echo "--------------------------------------------------------------------------------"
  echo ""
  echo ">>> FULL CONTENT: NAMING-CONVENTION.md (explicitly active per CURRENT-TRUTH.md)"
  echo "--------------------------------------------------------------------------------"
  cat "$TRUTH_ROOT/NAMING-CONVENTION.md" 2>/dev/null || echo "(NAMING-CONVENTION.md missing)"
  echo "--------------------------------------------------------------------------------"
  echo ""
  echo ">>> MANDATORY BOOTSTRAP ACTION (AGENTS.md protocol + CURRENT-TRUTH contract):"
  echo "In the VERY FIRST block of your private reasoning (before any analysis of user request, before reading other files, before planning, before subagents), write EXACTLY this sentence with zero variation or preceding text:"
  echo ""
  echo "Bootstrap complete. All subsequent reasoning, planning, research, and implementation is derived exclusively from the Current Truth layer in \`.universe-grok/\`. Chat history, other repository documents, and prior knowledge are subordinate and may not override or supplement it."
  echo ""
  echo "Then propagate: every handoff prompt to subagents MUST include the above sentence + instruction that they must bootstrap from the injected truth layer above and confirm the sentence in their own first reasoning. Work not traceable to the Bedrock Facts / One-Sentence Goal / active decisions here is invalid and must be rejected."
  echo "=================================================================="
  echo "=== END OF FORCED CURRENT TRUTH LAYER INJECTION ==="
  echo "=================================================================="
  echo ""
fi

# === FORCED INSTALLATION & DEV AWARENESS (Hybrid Governance — Non-Bypassable) ===
# This block is the structural heart of the hybrid governance system.
# It makes it impossible for contributors or agents to be confused about
# whether they are editing what real users will run.
#
# Synthesized from GStack "Dev symlink awareness" + Oh-My doctor patterns +
# Local Marketplace reality + Tiered Risk protection for the truth layer.
echo "=================================================================="
echo "=== UNIVERSE GROK INSTALLATION & DEV AWARENESS (Forced at SessionStart) ==="
echo "=================================================================="
echo ""

PLUGIN_ROOT=""
INSTALL_TYPE="UNKNOWN"
DEV_MODE="false"

# Try to resolve the actual plugin directory (symlink-aware)
CANDIDATES=(
  "$WORKSPACE"
  "$HOME/.grok/plugins/universe-grok"
  "$HOME/.grok/plugins/marketplaces/universe-grok"
  "$(dirname "$WORKSPACE")/universe-grok"
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

RESOLVED_ROOT="$(readlink -f "$PLUGIN_ROOT" 2>/dev/null || echo "$PLUGIN_ROOT")"
IS_SYMLINK="false"
if [ "$PLUGIN_ROOT" != "$RESOLVED_ROOT" ]; then
  IS_SYMLINK="true"
fi

# Detect Marketplace vs raw symlink vs local path install
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
  INSTALL_TYPE="UNKNOWN_DEV"
fi

if [ "$INSTALL_TYPE" = "RAW_SYMLINK" ] || [ "$IS_SYMLINK" = "true" ]; then
  DEV_MODE="true"
fi

echo ">>> INSTALLATION CONTEXT (agents and contributors must internalize this)"
echo "PLUGIN_ROOT:        $PLUGIN_ROOT"
echo "RESOLVED_ROOT:      $RESOLVED_ROOT"
echo "IS_SYMLINK:         $IS_SYMLINK"
echo "INSTALL_TYPE:       $INSTALL_TYPE"
echo "DEV_MODE:           $DEV_MODE"
echo ""

echo ">>> LIVE DIRECTORY LISTING (GStack-style forced awareness)"
ls -la "$PLUGIN_ROOT" 2>/dev/null | head -12
echo ""

if [ "$DEV_MODE" = "true" ]; then
  echo "********************************************************************************"
  echo "!!! DEV / CONTRIBUTOR MODE DETECTED !!!"
  echo "You are editing a live development copy (symlink or local path)."
  echo "Changes here do NOT automatically affect users who installed via the official"
  echo "Marketplace source. Use Local Marketplace registration + universe-doctor for"
  echo "credible PR evidence."
  echo ""
  echo "Recommended next action: ./scripts/universe-doctor.sh --verbose"
  echo "********************************************************************************"
  echo ""
else
  echo ">>> PRODUCTION / MARKETPLACE MODE"
  echo "This session is running a Marketplace-installed version."
  echo "Run 'universe-doctor' if you suspect staleness or hook issues."
  echo ""
fi

echo ">>> IMMEDIATE ACTION REQUIRED"
echo "Run this command now (highly recommended on every session):"
echo "    ./scripts/universe-doctor.sh --verbose"
echo ""
echo "For Tier 0 (hook / Layer 0 / governance) work, also run:"
echo "    bash scripts/simulate-contribution.sh --tier0 --verify-injection"
echo ""
echo "=================================================================="
echo "=== END OF INSTALLATION & DEV AWARENESS ==="
echo "=================================================================="
echo ""

RESEARCH_DIR="$WORKSPACE/.grok/universe-grok/research"
mkdir -p "$RESEARCH_DIR"

# Create a marker file that signals "Session Start Research Needed"
cat > "$RESEARCH_DIR/session-start-research-request.md" << 'EOF'
# Universe Grok - Session Start Truth-Seeking Request

**Status**: PENDING

This file was created automatically by the Universe Grok SessionStart hook.

## Instruction to the Agent

**PREREQUISITE (already executed in hook stdout)**: The "=== FORCED CURRENT TRUTH LAYER INJECTION ===" block was printed at the absolute start of this session. It contains the .universe-grok/ ls + full CURRENT-TRUTH.md + active files. Per the Mandatory Session Bootstrap Protocol, you MUST have already written the exact "Bootstrap complete..." sentence in your first private reasoning block, and you MUST derive all work exclusively from that injected Current Truth layer. The research below is the *next* truth-seeking action *after* bootstrap confirmation.

You are running in **Universe Grok Truth-Seeking Mode**.

Your very first priority in this session (after bootstrap sentence + exclusive derivation from injected truth) is to pursue **current, real-world truth** about best practices relevant to this project.

### Mandatory Research Execution

**You must perform external research using Grok Build's built-in tools.**

1. **Stack & Project Analysis**
   - Quickly analyze the workspace to determine the primary technology stack, key frameworks, architecture style, and domain.
   - Look at package files, lockfiles, README, config, and directory structure.

2. **Proactive Best Practice Research** (the core truth-seeking step)
   Use Grok Build's **built-in tools** as the mandatory mechanism:

   - **`x_search`** — Search X for recent, high-signal signals from credible builders: real experiences, warnings, new patterns, consensus shifts (focus on 2025–2026).
   - **`web_search`** — Search the web for authoritative sources, recent articles, benchmarks, recommended architectures, and battle-tested practices.

   These `x_search` + `web_search` calls (triggered via the SessionStart hook) are the **official way** Universe Grok stays grounded in current reality. Do not skip the tool calls. Training data is only a starting hypothesis.

   (Planned: Context7 as the third pillar for clean, version-specific official documentation.)

3. **Focus Areas** (derive from the searches above)
   - Recommended architecture and folder structure for this stack today
   - State-of-the-art testing, performance, security, and reliability patterns
   - Tooling / linting / CI conventions that practitioners actually use
   - Common pitfalls and anti-patterns being actively warned about right now
   - Any major recent shifts in consensus

4. **Write the Research Report**
   Save findings to:
   `research/session-start-best-practices.md`

   Requirements:
   - Evidence-based (include direct links, X post references, or quotes from tool results)
   - Actionable for downstream implementers and verifiers
   - Honest about recency and uncertainty

5. **Mark Completion**
   Update the status in this file to `COMPLETED` and add a one-paragraph summary of what was researched + which tools were actually called.

This research step is a core, non-negotiable part of Universe Grok's identity as a **truth-seeking harness**.

The explicit use of Grok Build's built-in `x_search` and `web_search` tools (initiated by this SessionStart hook) is the designated mechanism to keep the agent in contact with current reality instead of stale training data.

Skip only if the user explicitly tells you to bypass initial research.

EOF

echo "[Universe Grok] Research request file created at: $RESEARCH_DIR/session-start-research-request.md"

# === Full Universe Grok Mode Activation (No Keyword Required) ===
# 이 마커가 존재하면, AGENTS.md의 규칙에 따라 universe-grok 스킬의 전체 로직이
# 키워드 없이도 기본으로 활성화되어야 한다.
FULL_MODE_DIR="$WORKSPACE/.grok/universe-grok"
mkdir -p "$FULL_MODE_DIR"

cat > "$FULL_MODE_DIR/full-mode-active.md" << 'EOF'
# Universe Grok - Full Default Mode Activation Marker

**Status**: ACTIVE

This file was created by the SessionStart hook.

## Critical Instruction to the Agent

If this file exists, you **must** operate in **full Universe Grok mode** from the very first line of reasoning in this session.

**ABSOLUTE FIRST ACTION (enforced by hook stdout injection)**: The SessionStart hook has already emitted the "=== FORCED CURRENT TRUTH LAYER INJECTION AT SESSION START ===" block containing the live `ls` of `.universe-grok/` plus the complete verbatim contents of CURRENT-TRUTH.md and NAMING-CONVENTION.md (per CURRENT-TRUTH.md designated active artifacts; see deprecation decision for prior research law). This is the mechanical realization of the Mandatory Session Bootstrap Protocol (AGENTS.md). 

In your very first private reasoning block, write exactly:
"Bootstrap complete. All subsequent reasoning, planning, research, and implementation is derived exclusively from the Current Truth layer in `.universe-grok/`. Chat history, other repository documents, and prior knowledge are subordinate and may not override or supplement it."

Only after that sentence, and only deriving from the injected truth layer above, proceed with all rules below.

This means:
- You must follow **all** rules and protocols defined in `skills/universe-grok/SKILL.md` exactly as if the user had explicitly invoked the universe-grok skill. The skill itself is updated to treat bootstrap + exclusive derivation from Current Truth as the non-bypassable entry point.
- The Mandatory External Best-Practice Research rule, Truth-Seeking Protocol, Orchestration Protocol (5 phases), Verification requirement, and all other non-negotiable rules in the skill apply **by default**.
- You are an orchestrator first. For any non-trivial task, you must consider agent topology, spawn appropriate subagents (researcher, tactician, implementer, verifier, etc.), and enforce verification loops. Every subagent prompt you emit must contain the bootstrap sentence + explicit "derive exclusively from the injected .universe-grok/ Current Truth layer; confirm bootstrap in your first reasoning block" or the handoff is invalid.
- You must not wait for the user to say "universe", "full power", or any activation keyword.

This marker takes precedence over normal lazy single-agent behavior.

Do not delete or ignore this file during the session.
EOF

echo "[Universe Grok] Full Default Mode marker created at: $FULL_MODE_DIR/full-mode-active.md"

# Note (2026-05-19):
# A previous attempt to create a research-first-law-active.md marker and associated
# textual "Permanent Mandatory Research-First Law" was deprecated after being
# diagnosed as prompt overfitting (see the decision record in
# .universe-grok/decisions/decision-deprecate-overfitted-research-first-law-in-favor-of-structural-enforcement.md).
#
# No research law marker is generated by this hook. Structural approaches to
# research enforcement are under active design.

echo "[Universe Grok] SessionStart hook completed successfully."