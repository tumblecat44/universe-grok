#!/bin/bash
# universe-grok-install — Complete one-command per-project harness setup script
#
# Invoked by the universe-grok-install skill (via bash execution from the agent
# following SKILL.md instructions). Performs the full filesystem operations
# reliably using cp and cat, avoiding any reliance on LLM file content generation.
#
# Guarantees the exact target tree required:
#   AGENTS.md (full canonical)
#   .universe-grok/CURRENT-TRUTH.md (standard header + only ${PROJECT_NAME} in goal + bedrock placeholder)
#   .universe-grok/NAMING-CONVENTION.md
#   .universe-grok/decisions/ (empty dir, zero files)
#   .universe-grok/truth/ (empty dir, zero files)
#   hooks/{session-start.json, session-start.sh, user-prompt-submit.json, user-prompt-submit.sh,
#          full-mode-active.md, research-first-law-active.md}
#
# - Uses basename "$(pwd)" for project name only.
# - Creates .grok/rules/ for installable rules (naming-convention etc.) that are loaded on-demand
#   when the agent modifies .universe-grok/decisions/ or truth/. The old hard "never touch .grok"
#   policy has been lifted for this specific purpose.
# - chmod +x the two .sh files in target hooks/.
# - Works whether run from dev checkout, symlinked skill, or marketplace-installed plugin.
# - Idempotent overwrites on re-run (safe).
#
# This makes "/universe-grok-install" literally "just finish all the setup" in one command.

set -euo pipefail

TARGET_DIR="$(pwd -P)"
PROJECT_NAME="$(basename "$TARGET_DIR")"

echo "=== Universe Grok Install: Complete Harness Setup ==="
echo "Target: $TARGET_DIR (project folder name: ${PROJECT_NAME})"
echo ""

# Locate the canonical source root containing the master copies of AGENTS.md, hooks/, .universe-grok/NAMING-CONVENTION.md etc.
# Walk upward from the real location of *this* script (handles both real tree and symlinked ~/.grok/skills/universe-grok-install).
find_source_root() {
  local dir
  dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
  while [ -n "$dir" ] && [ "$dir" != "/" ]; do
    if [ -f "$dir/AGENTS.md" ] && [ -f "$dir/hooks/session-start.sh" ] && [ -d "$dir/.universe-grok" ]; then
      echo "$dir"
      return 0
    fi
    dir="$(dirname "$dir")"
  done

  # Fallbacks matching the pattern from root install.sh (standard locations after marketplace or git install)
  local -a candidates=(
    "$HOME/.grok/plugins/universe-grok"
    "$HOME/.grok/plugins/marketplaces/universe-grok"
  )
  local cand resolved
  for cand in "${candidates[@]}"; do
    if resolved="$(cd "$cand" 2>/dev/null && pwd -P)"; then
      if [ -f "$resolved/AGENTS.md" ] && [ -f "$resolved/hooks/session-start.sh" ] && [ -d "$resolved/.universe-grok" ]; then
        echo "$resolved"
        return 0
      fi
    fi
  done
  return 1
}

SOURCE_ROOT="$(find_source_root || true)"
if [ -z "$SOURCE_ROOT" ]; then
  echo "ERROR: Cannot locate Universe Grok canonical source (needs AGENTS.md + hooks/session-start.sh + .universe-grok/)."
  echo "       Make sure the plugin is installed (marketplace or dev) and the skill dir is reachable."
  exit 1
fi
echo "Source harness found at: $SOURCE_ROOT"
echo ""

# Safety: never install the harness if the current working directory itself is inside .grok/
# (prevents accidentally installing into the plugin's own state). 
# However, creating .grok/rules/ inside a normal target project is now explicitly supported.
case "$TARGET_DIR" in
  */.grok|*/.grok/*)
    echo "ERROR: Refusing to run inside any .grok/ path (install only targets real projects)."
    exit 1
    ;;
esac

# === Create the exact required target tree ===

mkdir -p "$TARGET_DIR/.universe-grok/decisions"
mkdir -p "$TARGET_DIR/.universe-grok/truth"
mkdir -p "$TARGET_DIR/hooks"

# Rules (including naming convention) are installed under the target's .grok/rules/
# so they can be loaded on-demand when the agent actually modifies decisions/truth.
mkdir -p "$TARGET_DIR/.grok/rules"

# Exact file copies (identical content from canonical source)
cp -f "$SOURCE_ROOT/AGENTS.md" "$TARGET_DIR/AGENTS.md"
cp -f "$SOURCE_ROOT/.universe-grok/NAMING-CONVENTION.md" "$TARGET_DIR/.universe-grok/NAMING-CONVENTION.md"

# Install the modifiable-time rule (naming convention) into .grok/rules/
# This is the separate canonical rule file (not part of the always-injected truth layer).
cp -f "$SOURCE_ROOT/rules/naming-convention.md" "$TARGET_DIR/.grok/rules/naming-convention.md"

cp -f "$SOURCE_ROOT/hooks/session-start.json" "$TARGET_DIR/hooks/session-start.json"
cp -f "$SOURCE_ROOT/hooks/session-start.sh" "$TARGET_DIR/hooks/session-start.sh"
cp -f "$SOURCE_ROOT/hooks/user-prompt-submit.json" "$TARGET_DIR/hooks/user-prompt-submit.json"
cp -f "$SOURCE_ROOT/hooks/user-prompt-submit.sh" "$TARGET_DIR/hooks/user-prompt-submit.sh"

# Activation markers are written via heredoc (baked into this script) so the install works
# even in clean marketplace clones that do not ship a .grok/ directory. Placed under hooks/
# per the explicit install contract (not under .grok/universe-grok/).
cat > "$TARGET_DIR/hooks/full-mode-active.md" << 'MARKER_EOF'
# Universe Grok - Full Default Mode Activation Marker

**Status**: ACTIVE

This file was placed by /universe-grok-install (the SessionStart hook creates the runtime activation instance under .grok/universe-grok/ in the current harness).

## Critical Instruction to the Agent

If this file exists, you **must** operate in **full Universe Grok mode** from the very first line of reasoning in this session.

**ABSOLUTE FIRST ACTION (enforced by hook stdout injection)**: The SessionStart hook has already emitted the "=== FORCED CURRENT TRUTH LAYER INJECTION AT SESSION START ===" block containing the live `ls` of `.universe-grok/` plus the complete verbatim contents of CURRENT-TRUTH.md and NAMING-CONVENTION.md (per CURRENT-TRUTH.md designated active artifacts; see deprecation decision for prior research law). This is the mechanical realization of the Mandatory Session Bootstrap Protocol (AGENTS.md). 

In your very first private reasoning block, write exactly:
"Bootstrap complete. All subsequent reasoning, planning, research, and implementation is derived exclusively from the Current Truth layer in \`.universe-grok/\`. Chat history, other repository documents, and prior knowledge are subordinate and may not override or supplement it."

Only after that sentence, and only deriving from the injected truth layer above, proceed with all rules below.

This means:
- You must follow **all** rules and protocols defined in `skills/universe-grok/SKILL.md` exactly as if the user had explicitly invoked the universe-grok skill. The skill itself is updated to treat bootstrap + exclusive derivation from Current Truth as the non-bypassable entry point.
- The Mandatory External Best-Practice Research rule, Truth-Seeking Protocol, Orchestration Protocol (5 phases), Verification requirement, and all other non-negotiable rules in the skill apply **by default**.
- You are an orchestrator first. For any non-trivial task, you must consider agent topology, spawn appropriate subagents (researcher, tactician, implementer, verifier, etc.), and enforce verification loops. Every subagent prompt you emit must contain the bootstrap sentence + explicit "derive exclusively from the injected .universe-grok/ Current Truth layer; confirm bootstrap in your first reasoning block" or the handoff is invalid.
- You must not wait for the user to say "universe", "full power", or any activation keyword.

This marker takes precedence over normal lazy single-agent behavior.

Do not delete or ignore this file during the session.
MARKER_EOF



# CURRENT-TRUTH.md — standard authoritative header + ONLY the project folder name in the goal.
# Bedrock Facts section is pure placeholder. No references to specific decision files
# (because decisions/ and truth/ are shipped empty — user populates after install).
# We use split heredocs + printf to safely embed literal backticks and expand only $PROJECT_NAME.

cat << 'PRE_GOAL' > "$TARGET_DIR/.universe-grok/CURRENT-TRUTH.md"
# CURRENT TRUTH — The Only Allowed Source of Truth

**Authority**: Absolute and exclusive for this entire repository.

The contents of the `.universe-grok/` directory — starting with this file and every artifact it explicitly designates as active — constitute the **sole, complete, and binding source of truth** for every AI agent and subagent that operates in this repository on any non-trivial task.

All other material has strictly lower authority:
- Chat histories, raw conversation transcripts, and prior session context
- README, docs/, architecture notes, design documents, and any other markdown
- Previous versions of this layer, git history, or model-intrinsic knowledge of the project

Only what is explicitly recorded in the active Current Truth layer is considered valid project truth for the current session.

## Why This Layer Exists

Long-running agentic work, especially repeated architecture rebuilds, suffers from a recurring failure mode: truth scatters. Decisions, rationales, and architectural principles accumulate across chat histories and superseded documents. When the project undergoes a major directional change, agents continue to operate from stale mental models, causing systematic regression and expensive rework.

This layer exists to eliminate that failure mode at the root. It maintains **only currently valid truth in the primary AI-visible surface**. Anything that is no longer operative is removed from this layer and exists only in git history. The result is a clean, forward-only operating reality with zero context contamination from superseded decisions.

This is not documentation. It is the operational contract that keeps the entire Universe Grok harness in continuous contact with living reality rather than accumulated baggage.

## Agent Contract

On any non-trivial session, every agent — including the orchestrator and all spawned subagents — operates under this contract:

- The Current Truth layer is the first and highest authority.
- All reasoning, planning, research, implementation, and verification must be directly derivable from what is explicitly present here.
- What is absent from this layer is outside current truth for this session.

Work that cannot be traced to this layer has violated the fundamental protocol of the system.

## One-Sentence Goal

> Build and evolve the 
PRE_GOAL

printf '%s project using the full Universe Grok .universe-grok/ Current Truth layer + hooks mechanical enforcement for all agent sessions and non-trivial work.\n' "$PROJECT_NAME" >> "$TARGET_DIR/.universe-grok/CURRENT-TRUTH.md"

cat << 'POST_GOAL' >> "$TARGET_DIR/.universe-grok/CURRENT-TRUTH.md"

## Bedrock Facts & Active Decisions

(Active architecture, constraints, invariants, and "why" rationales that are currently operative go here.)

POST_GOAL

# Post-write assertion (cheap insurance against heredoc/printf regression)
if ! grep -q "$PROJECT_NAME project using the full Universe Grok" "$TARGET_DIR/.universe-grok/CURRENT-TRUTH.md" || grep -q "dogfood a Grok Build plugin" "$TARGET_DIR/.universe-grok/CURRENT-TRUTH.md"; then
  echo "ERROR: CURRENT-TRUTH.md name injection or placeholder leakage detected"
  exit 1
fi

# Make the hook scripts executable in the target (required for Grok Build to invoke them)
chmod +x "$TARGET_DIR/hooks/session-start.sh" "$TARGET_DIR/hooks/user-prompt-submit.sh"

echo ""
echo "✅ COMPLETE — One command produced the full enforceable harness."
echo ""
echo "Files / structure created in ${TARGET_DIR}:"
echo "  AGENTS.md"
echo "  .universe-grok/"
echo "    CURRENT-TRUTH.md          (One-Sentence Goal contains only: ${PROJECT_NAME})"
echo "    NAMING-CONVENTION.md      (legacy copy for current bootstrap; rule is also in .grok/rules/)"
echo "    decisions/                (empty — zero template files)"
echo "    truth/                    (empty — zero template files)"
echo "  .grok/rules/"
echo "    naming-convention.md      (the rule to follow when creating/editing files in decisions/ or truth/)"
echo "  hooks/"
echo "    session-start.json"
echo "    session-start.sh"
echo "    user-prompt-submit.json"
echo "    user-prompt-submit.sh"
echo "    full-mode-active.md       (placed here per design; runtime instance created under .grok/ by hook)"
echo ""
echo "Note: .grok/rules/ is now intentionally created by the install for on-demand rules"
echo "(naming convention etc.). The rule is loaded when the agent actually touches decisions/truth."
echo "(Runtime .grok/research/ and .grok/universe-grok/ are still created by the copied hooks.)"
echo ""
echo "Mechanical enforcement is ready:"
echo "  • On next SessionStart in this project, hooks/session-start.sh will execute"
echo "    and forcibly inject the .universe-grok/ ls + full CURRENT-TRUTH.md +"
echo "    NAMING-CONVENTION.md (the bootstrap protocol in AGENTS.md now has real teeth)."
echo "  • The full-mode marker under hooks/ + runtime creation provides the activation surface."
echo ""
echo "Next step for this project (recommended): run /first-questions to replace the"
echo "placeholder goal with the real One-Sentence Goal + Bedrock Facts for ${PROJECT_NAME}."
echo "All future decisions go in .universe-grok/decisions/ using the naming convention."
echo ""
echo "=== universe-grok-install finished. Full setup complete. ==="
echo ""

exit 0
