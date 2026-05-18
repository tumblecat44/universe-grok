#!/bin/bash
# Universe Grok - Session Start Truth-Seeking Hook
# This hook prepares the environment for proactive best practice research.

set -euo pipefail

echo "[Universe Grok] SessionStart hook executing..."

WORKSPACE="${GROK_WORKSPACE_ROOT:-$(pwd)}"
RESEARCH_DIR="$WORKSPACE/.grok/universe-grok/research"
mkdir -p "$RESEARCH_DIR"

# Create a marker file that signals "Session Start Research Needed"
cat > "$RESEARCH_DIR/session-start-research-request.md" << 'EOF'
# Universe Grok - Session Start Truth-Seeking Request

**Status**: PENDING

This file was created automatically by the Universe Grok SessionStart hook.

## Instruction to the Agent

You are running in **Universe Grok Truth-Seeking Mode**.

Your very first priority in this session (before doing any user-requested work) is to pursue **current, real-world truth** about best practices relevant to this project.

### What You Must Do

1. **Analyze the project** to determine the primary technology stack, frameworks, architecture patterns, and domain.
   - Look at package managers, config files, README, existing code structure, etc.

2. **Proactively research current Best Practices** using tools:
   - **X (Twitter) search** for recent discussions from credible practitioners
   - **Web search** for authoritative sources, recent articles, official docs updates, and battle-tested patterns (2025-2026)

3. **Focus areas** (prioritize based on what you discover):
   - Current recommended architecture / folder structure for this stack
   - Modern testing strategies and tools
   - Performance, security, and reliability patterns that are considered state-of-the-art right now
   - Tooling, linting, formatting, and CI best practices
   - Common pitfalls that people are warning about in 2025-2026
   - Any major shifts or new consensus that has emerged recently

4. **Write the findings** into:
   `research/session-start-best-practices.md`

   The report must be:
   - Evidence-based (link sources or quote X posts when possible)
   - Actionable
   - Honest about uncertainty and recency

5. **After research is complete**, update the status in this file to `COMPLETED` and briefly summarize what was researched.

This research is a core part of Universe Grok's identity as a **truth-seeking harness**. Do not skip it on the first turn of a new session unless the user explicitly says they want to skip initial research.

EOF

echo "[Universe Grok] Research request file created at: $RESEARCH_DIR/session-start-research-request.md"
echo "[Universe Grok] SessionStart hook completed successfully."