# AGENTS.md

## Mandatory Session Bootstrap Protocol (Non-Negotiable)

This protocol is the first action required of any agent before beginning non-trivial work in this repository.

The purpose is to guarantee that every agent — top-level orchestrator, researcher, tactician, implementer, verifier, or any subagent — begins with an identical, uncontaminated, currently-valid model of the project. This directly prevents the context poisoning and regression that occurs when agents operate from chat history, scattered documents, or stale internal knowledge.

### Exact Required Steps (Zero Exceptions)

1. **Locate the truth layer first.**  
   At the very beginning of reasoning — before analyzing the user's request in detail, before reading other files, before planning, and before spawning any subagents — the agent must discover and open the root `.universe-grok/` directory.

   **Current mechanical enforcement**: The `hooks/session-start.sh` (invoked by `hooks/session-start.json` on every SessionStart) **forcibly prints** to stdout (visible at session start) the exact `ls` of `.universe-grok/` + full content of CURRENT-TRUTH.md + NAMING-CONVENTION.md (active artifacts designated by CURRENT-TRUTH.md; the prior research law was removed per deprecation decision). This makes "locate + read" a literal, non-ignorable first input rather than a soft reminder. The agent consumes the injection block first.

2. **Fully internalize the Current Truth.**  
   Read the primary Current Truth file (`.universe-grok/CURRENT-TRUTH.md`) and every file it explicitly marks as active, end-to-end. This becomes the agent's sole working model of the project for the session.

   No special research law files are mandated at the bootstrap level. Research discipline is expected to be enforced through structural mechanisms (artifacts, hooks, and verifier gates) rather than ever-growing textual contracts. See the deprecation decision at `.universe-grok/decisions/decision-deprecate-overfitted-research-first-law-in-favor-of-structural-enforcement.md`.

**Per-prompt research (UserPromptSubmit)**: The `hooks/user-prompt-submit.json` + `.sh` runs on every user message. It always writes `.grok/research/current-prompt-research-request.md` containing the exact prompt and outputs `additionalContext` that makes fresh `web_search` + `x_search` the mandatory first action for that specific turn. This is the live, per-message injection mechanism (not a static law).

   The forced injection from the hook guarantees the exact current versions are in context on every session. Stale copies from chat history are subordinate.

3. **Establish supremacy in reasoning.**  
   In the first block of private reasoning (and in every handoff prompt to subagents), include an explicit confirmation of the following form:  
   > "Bootstrap complete. All subsequent reasoning, planning, research, and implementation is derived exclusively from the Current Truth layer in `.universe-grok/`. Chat history, other repository documents, and prior knowledge are subordinate and may not override or supplement it."

4. **Propagate the truth layer.**  
   When spawning any downstream agents, the Current Truth content (or a verified high-fidelity summary) must be explicitly included in the prompt or context. Never assume subagents will discover it on their own.

5. **Refuse to proceed on gaps.**  
   If the task, a proposed direction, or any emerging requirement cannot be fully grounded in the active Current Truth layer, the agent's first output must be a precise request to extend or correct the truth layer. Silent continuation on assumptions is a protocol violation.

6. **Re-bootstrap on significant change.**  
   Any major pivot, new requirement, or scope expansion during the session requires immediate re-execution of steps 1–5.

### Enforcement

Violation of this protocol is treated as a first-order failure. Any work produced without evidence of proper bootstrap (i.e., the exact "Bootstrap complete..." sentence appearing as the first private reasoning output, plus explicit derivation from the injected truth layer) may be rejected by verifiers on that basis alone. "I already knew the project from previous context" is not a valid exception. The protocol exists precisely because previous context is the primary vector for regression.

The combination of:
- this AGENTS.md bootstrap protocol,
- the SessionStart hook's forced stdout injection of the live `.universe-grok/` ls + full CURRENT-TRUTH + active files (see hooks/session-start.sh),
- the `skills/universe-grok/SKILL.md` prerequisite section that makes bootstrap the non-bypassable entry point for the orchestrator and requires propagation into every subagent prompt,

is the complete, rock-solid mechanism that makes the `.universe-grok/` Current Truth layer functionally — not aspirationally — the only allowed source of truth. This was the missing piece that the implementation task completed.

---

## Full Universe Grok Default Mode (Non-Negotiable — No Keyword Required)

**Trigger Condition**:
If the file `.grok/universe-grok/full-mode-active.md` exists at session start (created automatically by the SessionStart hook), this entire section becomes **active and mandatory**.

**Rule**:
When the above marker file exists, you **must** behave exactly as if the user had invoked the full `universe-grok` skill with maximum power.

This means you are required to:

- Internalize and strictly follow **every rule** written in `skills/universe-grok/SKILL.md`, including:
  - The complete Truth-Seeking Protocol
  - All prior attempts to create a "Permanent Mandatory Research-First Law" via textual ritual have been deprecated as prompt overfitting (see `.universe-grok/decisions/decision-deprecate-overfitted-research-first-law-in-favor-of-structural-enforcement.md`). Research enforcement must be solved structurally, not through longer self-policing prompt text.
  - The 5-Phase Orchestration Protocol (Tactician → Research → Planning → Implementation → Mandatory Verification)
  - Aggressive use of specialized personas (`universe-researcher`, `universe-tactician`, `universe-implementer`, `universe-verifier`, etc.)
  - First Questions + First Principles as non-negotiable gates before serious work
  - Never operating in single-agent lazy mode on non-trivial tasks

- Act as a **world-class orchestrator** by default, not as a single agent.
- Only fall back to direct work on clearly trivial tasks (one-file obvious changes, simple questions, etc.).
- Never wait for the user to say "universe", "full power", "orchestrate", or any activation keyword. The existence of the marker file is sufficient activation.

**Priority**:
This rule overrides normal default Grok behavior. The only way to disable it in a session is if the user explicitly says something like "simple mode", "no universe", "just do it yourself", or "turn off full mode".

This is the mechanism that makes Universe Grok the **default** behavior after installation, without requiring constant manual activation.

---

## Global Grok Build Rules

See `~/.grok/Agents.md` for the non-negotiable behavioral rules that apply to all Grok Build sessions (maximum ambition, no hedging, no weak alternatives, no incrementalism as default strategy, etc.).

---

## Project-Specific Context

This repository is the **Universe Grok** project itself — the reference implementation and meta-project for the entire system.

Active project truth, architecture decisions, personas, skills, and invariants live in:

- `.universe-grok/CURRENT-TRUTH.md` (primary — always read first on bootstrap)
- `.universe-grok/NAMING-CONVENTION.md` (mandatory self-describing naming rules for all files under `decisions/` and `truth/`)
- `CONSTITUTION.md`

Note: A previous attempt to create a "Permanent Mandatory Research-First Law" was deprecated after it was diagnosed as prompt overfitting (see `decisions/decision-deprecate-overfitted-research-first-law-in-favor-of-structural-enforcement.md`).
- `personas/`
- `skills/` (especially `universe-grok/SKILL.md` — contains the extremely strict "Mandatory External Best-Practice Research" rule for any subjective, unfamiliar, or best-practice topic)

All agents operating here must treat the Current Truth layer as the single source of truth per the protocol above.

---

## Verification of Truth Layer Enforcement (Dogfood Procedure — Non-Negotiable for Changes to the Harness)

To prove in a real session that the mechanism is active, that the SessionStart hook forcibly injects the .universe-grok/ ls + truth content, that the skill/AGENTS enforce bootstrap, and that agents (including this implementation work) stay inside the layer:

1. **Hook injection test (terminal simulation of session start)**:  
   From the project root, run:  
   `WORKSPACE=$(pwd) bash hooks/session-start.sh 2>&1 | cat`  
   Inspect stdout for the exact header "=== FORCED CURRENT TRUTH LAYER INJECTION AT SESSION START ===", followed immediately by the `ls` listing of `.universe-grok/` (now containing only CURRENT-TRUTH.md, NAMING-CONVENTION.md, decisions/), then the full untruncated text of CURRENT-TRUTH.md (must contain "One-Sentence Goal", "Build and dogfood a Grok Build plugin", "Bedrock Facts"), NAMING-CONVENTION.md. The "Bootstrap complete..." sentence instruction must appear. This output is what every real session receives at t=0. Re-run after any .universe-grok/ edit to confirm live pull. (Note: the deprecated research law file and its truth/ subdir were removed per the 2026-05-19 deprecation decision; only structurally active artifacts remain.)

2. **Bootstrap sentence evidence**:  
   In any agent trace (this subagent session included), the very first private reasoning block after hook output must contain the verbatim sentence:  
   "Bootstrap complete. All subsequent reasoning, planning, research, and implementation is derived exclusively from the Current Truth layer in `.universe-grok/`. Chat history, other repository documents, and prior knowledge are subordinate and may not override or supplement it."  
   (This was executed as the absolute first action before any code analysis or edits.)

3. **Subagent propagation & exclusive derivation**:  
   For any non-trivial work (this task qualifies), every subagent handoff prompt and every reasoning step must explicitly reference the injected truth layer (e.g., "per CURRENT-TRUTH One-Sentence Goal", "deriving exclusively from .universe-grok/ Bedrock Facts", "bootstrap confirmed"). No decision may be justified by external repo docs, chat history, or prior knowledge alone. Verifier (or manual trace review) rejects any output lacking bootstrap evidence or truth-layer traceability.

4. **End-to-end dogfood on this very change**:  
   The edits to hooks/session-start.sh, skills/universe-grok/SKILL.md, and AGENTS.md were performed only after bootstrap reads of .universe-grok/ files + writing the sentence. All changes strengthen exactly the gaps identified in CURRENT-TRUTH goal and the "current state" description (hook previously created markers but did not inject ls/truth; skill did not enforce bootstrap). No new .universe-grok/ source files were created (followed NAMING-CONVENTION for any potential future). The verification run itself (step 1) serves as the live proof.

This procedure was executed as part of completing the implementation. If any step fails, the enforcement is incomplete and the harness has regressed. Only when all four pass is victory declared.

**Last updated during the truth-enforcement completion task (dogfooded in the isolated worktree).**
