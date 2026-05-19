---
name: universe-grok-install
description: >
  One-command *complete* setup of the full enforceable Universe Grok harness in any target project.
  Produces exact structure: full AGENTS.md, .universe-grok/ (CURRENT-TRUTH..., NAMING-CONVENTION, empty decisions/ + truth/), .grok/rules/naming-convention.md (rule for decisions/truth edits), hooks/ (4 enforcement files + full-mode-active marker).
  Install itself creates no .grok/. Runtime hooks create .grok/research/ + .grok/universe-grok/ only for research artifacts and activation (documented). After this, SessionStart hook injection + bootstrap protocol are mechanically live.
metadata:
  short-description: "One-command complete setup of the full .universe-grok/ truth layer + hooks mechanical enforcement (empty decisions/truth, full AGENTS.md, full-mode marker under hooks/, project name only). Install creates no .grok/; runtime research state under .grok/ is documented. Aligns with research-law deprecation."
  version: "1.0.0"
  keywords: ["install", "setup", "truth layer", "current truth", "agents.md", "bootstrap", "universe-grok", "hooks", "complete", "one-command"]
  slash_command: "/universe-grok-install"
---

# universe-grok-install — Complete One-Command Harness Setup

This skill performs the **full, complete** per-project harness installation in a single invocation. No partial skeleton. No "run something else next" requirement for the mechanical layer to be live.

Running `/universe-grok-install` (inside any target project) executes the companion `install.sh` script (sibling to this SKILL.md) which:

- Detects the current working directory as the target project and uses only `basename "$(pwd)"` as the project name.
- Copies the **exact full** `AGENTS.md` (complete English Mandatory Session Bootstrap Protocol + Full Universe Grok Default Mode + verification procedure) from the canonical source.
- Creates `.universe-grok/` with `CURRENT-TRUTH.md` (standard authoritative header + One-Sentence Goal containing **only** the target project folder name + minimal Bedrock Facts placeholder), exact `NAMING-CONVENTION.md`, and the two empty directories `decisions/` and `truth/` (zero template files, per "템플릿은 절대로 안넣는다").
- Creates `hooks/` containing the four mechanical enforcement files (session-start.{json,sh} + user-prompt-submit.{json,sh}) **plus** the committed full-mode activation marker placed inside hooks/:
  - `full-mode-active.md`
  (The research-first-law-active.md marker is intentionally not shipped — it was formally deprecated on 2026-05-19 per .universe-grok/decisions/decision-deprecate-overfitted-research-first-law-in-favor-of-structural-enforcement.md; the hook no longer generates it and the install aligns with that Current Truth decision.)
- `chmod +x` on the two `.sh` files.
- The install creates `.grok/rules/` (for on-demand rules such as naming-convention that are only needed when the agent actually modifies files in .universe-grok/decisions/ or truth/). Runtime .grok/research/ and .grok/universe-grok/ are still created by the copied hooks as before.

The resulting tree in the target project is identical in structure and design to the reference harness (truth layer + structural enforcement via hooks) without any source-specific content.

After this single command, the next Grok Build SessionStart in the target will run `hooks/session-start.sh`, which forcibly injects the `.universe-grok/` ls + full `CURRENT-TRUTH.md` + `NAMING-CONVENTION.md`. The bootstrap protocol in the copied `AGENTS.md` now has real, mechanical teeth. Full mode activation and per-prompt research forcing are present.

This is the realization of the user's requirement: "universe-grok-install 스킬은 그냥 다 세팅을 완료 하는거임" — one command, everything finished, ready for enforcement.

---

## Exact Files Written (Canonical Source → Target)

- `AGENTS.md` — full content
- `.universe-grok/CURRENT-TRUTH.md` — header + goal with `${PROJECT_NAME}` only
- `.universe-grok/NAMING-CONVENTION.md` — legacy copy (for current bootstrap injection)
- `.universe-grok/decisions/` — empty directory
- `.universe-grok/truth/` — empty directory
- `.grok/rules/naming-convention.md` — the rule for decisions/truth file naming (installed under .grok/rules/ for on-demand use)
- `hooks/session-start.json`
- `hooks/session-start.sh`
- `hooks/user-prompt-submit.json`
- `hooks/user-prompt-submit.sh`
- `hooks/full-mode-active.md`

No other files or directories are created. (The research-first-law marker is omitted to comply with the active deprecation decision in the Current Truth layer.)

---

## Known Runtime Behavior (Honest Documentation of Current Harness)

The install script and the tree it produces contain **no** `.grok/` directory. All static harness files are under the project root, `.universe-grok/`, and `hooks/`.

However, the *copied* runtime hooks (`session-start.sh` and `user-prompt-submit.sh`) and the activation logic in the copied `AGENTS.md` are written against the current structural design:

- On first SessionStart / UserPromptSubmit after install, the hooks will create:
  - `.grok/research/current-prompt-research-request.md` (per-turn research forcer — the live structural mechanism that replaced the deprecated textual "Permanent Mandatory Research-First Law").
  - `.grok/universe-grok/full-mode-active.md` (runtime instance of the full-mode marker; the static copy under `hooks/` is the committed source of its content).
  - `.grok/universe-grok/research/session-start-research-request.md` (session-start research request).

This is the minimal runtime state surface required for the hook-based truth-seeking and full-mode activation to operate. It is *not* "pollution" introduced by the install; it is how the harness the user is installing achieves mechanical enforcement (hooks + artifacts) rather than prompt text.

The `hooks/full-mode-active.md` placed by the install satisfies the explicit "markers inside hooks/" contract from the original requirements. The research-law marker is correctly absent.

Future canonical harness evolution may move these runtime artifacts under `hooks/` or `.universe-grok/`, at which point a future install update can remove the .grok/ note entirely.

---

## Implementation Notes (for agents invoking this skill)

1. Execute the script directly for reliability:
   ```bash
   # From within the target project (cwd = target root)
   SKILL_DIR="$(cd "$(dirname "$(realpath "$HOME/.grok/skills/universe-grok-install/SKILL.md" 2>/dev/null || echo "$(dirname "$0")")")" && pwd)"
   bash "$SKILL_DIR/install.sh"
   ```
   Or simply let the runtime execute `install.sh` next to SKILL.md (the script auto-locates the canonical source via walking + standard ~/.grok paths and performs all copies + templating).

2. The script is self-contained, idempotent, and prints a complete success summary with the exact tree.

3. Source location logic follows the exact pattern established in `install.sh` (root) and `hooks/session-start.sh`.

This skill + script together are the minimal, focused mechanism that delivers "one command = all settings complete."

---

**"The best part is no part."**

Every project using Universe Grok now receives the identical complete, enforceable truth layer + hook enforcement in literally one command inside its own directory. No manual reinvention, no missing pieces, no pre-creation of .grok/ by the install, and the deprecated research-law marker is correctly omitted. Runtime .grok/ state for research artifacts is the current (documented) cost of structural enforcement. The harness is live the moment the command finishes.