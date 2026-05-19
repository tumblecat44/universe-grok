# .universe-grok/ Naming Convention

**Authority**: This document is part of the Current Truth layer. All files and directories under `.universe-grok/decisions/` **must** follow these rules. (The `.universe-grok/truth/` subdir was removed during 2026-05-19 deprecation cleanup of the overfitted research law; no new files are placed there.)

**Purpose**:  
Enable AI agents to understand the purpose and content of every file using only `ls` output (or the injected directory listing at session start), without opening the files. This directly prevents the failure mode observed in CAIRO where critical decisions were buried in deep, non-self-describing paths and could not be discovered by agents.

---

## Core Rules (Non-Negotiable)

### 1. Word Count (Self-Describing Minimum)

- **Directory names**: 2 ~ 5 words
- **File names**: **Minimum 5 words, Maximum 10 words** (ideal range: 6~8 words)

**Rationale** (based on 2025–2026 AI agent practitioner signals):
- Fewer than 5 words: Insufficient semantic signal. Agents cannot reliably determine purpose from `ls` alone.
- More than 10 words: Reduces readability in directory listings, increases token waste, and makes `ls` output noisy.
- 5–10 words is the empirically observed sweet spot for LLM/agent discoverability in real agentic workflows (Cursor, Claude Code, etc.).

### 2. Character Limit

- **Maximum 100 characters** per filename (recommended: under 80 characters when possible).

### 3. Format (Mandatory)

- Use **kebab-case** only (`-` as separator). No spaces, underscores, or camelCase.
- Names must be **self-describing**: An agent reading only the name must be able to understand the file's role, domain, and key content without reading the file body.
- When chronology matters, prefer a `YYYY-MM-DD-` prefix.

### 4. Structure Recommendation

Preferred patterns (in order of preference):

1. `YYYY-MM-DD-[domain]-[purpose]-[key-detail]-[status].md`
2. `[domain]-[purpose]-[key-detail]-[version-or-status].md`

---

## Good vs Bad Examples

### Good Examples (Compliant)

- `2025-03-cairo-architecture-decision-session-unit-pivot.md` (7 words)
- `decisions-cairo-pricing-page-session-model-change.md` (6 words)
- `truth-universe-grok-enforcement-hook-injection-rule.md` (6 words)
- `2026-05-naming-convention-self-describing-file-rule.md` (6 words)

### Bad Examples (Violations)

- `decision.md`, `change.md`, `plan.md` — too short (< 5 words)
- `cairo-architecture-decision-from-project-based-to-independent-session-2025-march.md` — too long (> 10 words)
- `old-plan-v2-final.md` — not self-describing
- `session_decision.md` — uses underscore instead of kebab-case

---

## Enforcement

- This rule applies to **every** new file created under `.universe-grok/decisions/`. (Legacy reference to `.universe-grok/truth/` removed along with the directory in the deprecation cleanup.)
- When the Session Start hook injects directory listings, agents are expected to treat non-compliant names as a signal that the file may be low-quality or legacy.
- Violations should be corrected during the first relevant session (or explicitly justified in the file itself if legacy content must be preserved).

---

## Related Documents

- Root `AGENTS.md` — Mandatory Session Bootstrap Protocol (references this file)
- `.universe-grok/CURRENT-TRUTH.md` — Primary truth artifact

**Last Updated**: 2026-05-19 (Established during First Questions ritual after web + X research on AI-agent-friendly naming)