# 2026-05-19 Hybrid Structural Governance System Adoption

**Authority**: This decision record is part of the `.universe-grok/` Current Truth layer. It supersedes prior thin governance approaches and records the deliberate synthesis from the best-of-6 tournament.

## One-Sentence Decision

We adopt a **Hybrid Structural Governance System** for Universe Grok that combines Diagnostic Powerhouse observability (forced dev/install awareness + universe-doctor), Local Marketplace as the golden development path, Tiered Risk classification with nuclear protection for Layer 0, mandatory evidence artifacts, Reasoning Ledger commit discipline, and Meta-Dogfood requirements for all governance/Layer 0 changes — replacing vague "read the docs" and "small PRs" theater with mechanical, self-describing, machine-checkable enforcement.

## Why This Hybrid (Directly from Research + Tournament)

The 2025–2026 real-world evidence from Oh-My-OpenAgent, GStack, and the broader Claude Code/Grok Build plugin ecosystem showed a consistent pattern:

- Raw symlinks are unavoidable for live development but create dangerous unawareness (contributor believes they are editing what users run).
- Marketplace distribution (the official path the user highlighted) makes end-user installation easy but makes contributor testing of hooks/personas/truth injection *harder* unless the dev workflow deliberately mirrors it.
- Hook and SessionStart changes have nuclear blast radius — a subtle regression silently poisons every future agent session for every user.
- Successful projects survived not by eliminating pain, but by making the execution environment (symlink vs marketplace, dev vs prod) **impossible to misunderstand** via forced diagnostics and awareness at the hook level.
- Flat rules fail: too strict kills contribution; too loose fails to protect the truth-injection core.

The best-of-6 tournament (6 fully implemented, testable worktrees) produced clear winners on different axes:

- Candidate 2 delivered the strongest practical diagnostics and forced awareness (GStack-style ls -la + Oh-My doctor).
- Candidate 3 delivered the best alignment with actual Marketplace reality (`create-local-marketplace.sh`, INSTALL TYPE classification).
- Candidate 5 delivered proportional gravity (Tier 0 nuclear bar for Layer 0/hook changes without strangling small contributions).
- Candidates 1, 4, and 6 contributed essential pieces (evidence artifacts, commit ledger provenance, and self-referential harness execution for governance itself).

Synthesizing only the strongest elements produces a system that is simultaneously:
- Extremely protective of the project's defining mechanism (forced truth layer + Permanent Law + bootstrap).
- Practical and welcoming for real contributors (human or agent).
- Aligned with how the plugin will actually be distributed and used.

## Exact Layer 0 Definition (Immutable Spine)

Layer 0 files/changes require the full nuclear process (Tier 0):
- `CONSTITUTION.md`
- `AGENTS.md` (bootstrap protocol and propagation rules)
- Entire `.universe-grok/` directory (CURRENT-TRUTH.md, truth/, decisions/, NAMING-CONVENTION.md)
- `hooks/session-start.sh` and `hooks/session-start.json`
- Core orchestration contract in `skills/universe-grok/SKILL.md` (bootstrap, truth-seeking protocol, verifier mandate)
- `GOVERNANCE.md` (this hybrid system itself)

Any change touching Layer 0 is automatically Tier 0.

## The Hybrid Model (Structural Enforcement, Not Text)

1. **Diagnostic Powerhouse Core** (from Candidate 2)
   - `universe-doctor.sh` (enhanced) is the daily tool and PR evidence requirement.
   - Forced "DEV / PROD + INSTALL TYPE + symlink status" block in `session-start.sh` on every session (non-bypassable stdout).
   - `dev-setup.sh` and `clear-grok-cache.sh` as official recovery tooling.

2. **Local Marketplace Golden Path** (from Candidate 3)
   - `scripts/create-local-marketplace.sh` + `marketplace.json` is the recommended and PR-preferred way to develop and prove changes.
   - Hook diagnostics explicitly classify "LOCAL_MARKETPLACE vs RAW_SYMLINK" and make the former the only acceptable claim for serious PRs.

3. **Tiered Risk with Nuclear Protection** (from Candidate 5)
   - `classify-risk.sh` mechanically raises the entire PR to the highest tier touched.
   - Tier 0 (Nuclear): Hook, Layer 0, truth injection, governance — requires simulation artifact + doctor from clean env + two verifiers + observation window.
   - Lower tiers have proportional (much lighter) process.

4. **Evidence Supremacy** (from Candidate 1)
   - Non-trivial PRs must attach harness-produced artifacts (first-questions + first-principles when relevant + research + doctor output + simulation for Tier 0).

5. **Reasoning Ledger** (from Candidate 4)
   - Commit discipline (`truth:`, `decision:`, `research:`, `gov:`, `impl:`, `verify:`) with `Ledger-Ancestors:` trailers.
   - `universe-doctor ledger-audit` makes provenance queryable.

6. **Meta-Dogfood Spirit** (from Candidate 6)
   - All Tier 2+ governance or Layer 0 changes must themselves be executed through the Universe Grok harness (first-questions + research + verifier PASS) and the resulting artifacts committed as part of the PR.

## Enforcement Mechanisms (Mechanical, Not Cultural)

- Hook-level forced awareness (stdout on every SessionStart).
- `universe-doctor` as first-class command (`/universe doctor`).
- PR template that will not pass without classifier output + evidence.
- CI + pre-commit for ledger hygiene on high-risk files.
- Simulation scripts that mechanically re-execute the real hook and fail on truth-injection regression.

## Adoption Process for This Decision

This decision record itself was created under the hybrid spirit (research + tournament evaluation + first-questions style interrogation of the problem). Future changes to GOVERNANCE.md, Layer 0 definitions, or the core enforcement mechanisms must follow the Tier 0 + Meta-Dogfood path.

**Last Updated**: 2026-05-19 (Synthesized from best-of-6 tournament after fresh external research on real plugin ecosystem survival patterns)

---

**This record is binding.** Any future agent or contributor operating on this repository must treat the hybrid model above as the current operational contract for contribution safety.