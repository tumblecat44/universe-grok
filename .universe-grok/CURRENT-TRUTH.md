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

> Build and dogfood a Grok Build plugin (universe-grok) whose core mechanism forces every agent session to discover the .universe-grok/ Current Truth layer first, collect all active truth/decision artifacts, and derive all reasoning, planning, and implementation exclusively from them — so that complex, long-running work no longer produces repeated regressions, wrong architecture decisions, and expensive mistakes caused by scattered or stale context — the exact problem this harness was built to solve.

## Bedrock Facts & Active Decisions

(Active architecture, constraints, invariants, and "why" rationales that are currently operative go here.)

### Important Historical Decision (Must Be Read)

- `.universe-grok/decisions/decision-deprecate-overfitted-research-first-law-in-favor-of-structural-enforcement.md`

  A previous attempt to create a complex textual "Permanent Mandatory Research-First Law" to force external research was formally deprecated on 2026-05-19 after a `/check` diagnosis determined it was prompt overfitting (iterative if/switch patching to cover observed failure cases). The project has learned that lengthening self-policing prompt text is the wrong direction. Future research enforcement must be structural (hooks + artifacts + verifier gates).
