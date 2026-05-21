# Naming Convention for .universe-grok/decisions and .universe-grok/truth

**Type**: Installable Rule (placed in target `.grok/rules/` by universe-grok-install)

**Purpose**: 
When an agent needs to create or rename files inside `.universe-grok/decisions/` (or legacy truth/), this rule must be followed so that `ls` alone makes the purpose and content of every decision/truth file immediately obvious. This prevents the common failure where important records get buried under vague or non-self-describing filenames and become hard to find later.

This rule is **not** part of the always-injected Current Truth layer. It is loaded on demand when the agent is about to modify the truth layer files.

---

## Core Rules (Non-Negotiable)

### 1. Word Count (Self-Describing Minimum)

- **Directory names**: 2 ~ 5 words
- **File names**: **Minimum 5 words, Maximum 10 words** (ideal range: 6~8 words)

**Rationale**:
- Fewer than 5 words: Insufficient semantic signal. Agents cannot reliably determine purpose from `ls` alone.
- More than 10 words: Reduces readability in directory listings and wastes tokens.
- 5–10 words is the empirically observed sweet spot for LLM/agent discoverability.

### 2. Character Limit

- **Maximum 100 characters** per filename (recommended: under 80 when possible).

### 3. Format (Mandatory)

- Use **kebab-case** only (`-` as separator). No spaces, underscores, or camelCase.
- Names must be **self-describing**: reading only the filename must tell an agent the file's role, domain, and key content.
- When chronology matters, prefer a `YYYY-MM-DD-` prefix.

### 4. Preferred Patterns

1. `YYYY-MM-DD-[domain]-[purpose]-[key-detail]-[status].md`
2. `[domain]-[purpose]-[key-detail]-[version-or-status].md`

---

## Good Examples

- `2026-05-19-hybrid-structural-governance-system-adoption.md`
- `decision-deprecate-overfitted-research-first-law-in-favor-of-structural-enforcement.md`
- `2026-05-naming-convention-rule-for-decisions-layer.md`

## Bad Examples (Violations)

- `decision.md`, `change.md` — too short
- `very-long-description-of-the-entire-decision-with-dates-and-everything.md` — too long
- `session_decision.md` — underscore instead of kebab-case

---

## When This Rule Applies

This rule is enforced only when the agent performs file creation, rename, or significant modification inside:
- `.universe-grok/decisions/`
- `.universe-grok/truth/` (if present)

The rule file lives in the target's `.grok/rules/naming-convention.md` and is injected by the harness only at the moment of such modification.

---

**Last Updated**: 2026-05-19 (Restructured per clarified intent: rule for modification time only, installed via .grok/rules/)
