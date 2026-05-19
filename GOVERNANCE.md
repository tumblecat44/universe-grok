# Universe Grok Governance — Hybrid Structural Enforcement System

**Version**: 1.0.0 (Synthesized Hybrid — 2026-05-19)  
**Authority**: This document, together with `CONSTITUTION.md`, `AGENTS.md`, and the `.universe-grok/` truth layer, constitutes the binding operational contract for all contribution, governance, and long-term integrity of the project.

---

## One-Sentence Governance Principle

We protect the project's defining identity (forced truth-seeking via hook-injected `.universe-grok/` Current Truth layer + Permanent Law + mandatory bootstrap) through **mechanical, self-describing, observable structural enforcement** rather than longer prompts or cultural exhortations — while keeping the system practical enough that real contributors (human and agent) can safely develop and prove changes that mirror how users will actually install the plugin via the decentralized Marketplace.

---

## The Hybrid Model (Best Elements from Real-World Research + Tournament)

This system was deliberately synthesized from:
- Real 2025–2026 survival patterns in Oh-My-OpenAgent, GStack, and the Claude Code/Grok Build plugin ecosystem (forced diagnostics + dev awareness beat raw symlinks).
- A complete best-of-6 tournament in which six fully implemented, testable governance systems competed on correctness, safety, and contributor usability.

The winning hybrid combines:

| Pillar | Source | What It Delivers |
|--------|--------|------------------|
| **Diagnostic Powerhouse** | Candidate 2 (strongest practical winner) | `universe-doctor.sh`, forced DEV/PROD + symlink/marketplace awareness at SessionStart, recovery scripts |
| **Local Marketplace Golden Path** | Candidate 3 | `create-local-marketplace.sh` + manifest, INSTALL TYPE classification, reproducible testing that matches real user experience |
| **Tiered Risk with Nuclear Bar** | Candidate 5 | Mechanical risk classifier; Tier 0 (nuclear) protection for hooks/Layer 0 without killing small contributions |
| **Evidence Supremacy** | Candidate 1 | Mandatory harness-produced artifacts (first-questions, research, doctor, simulation) for non-trivial work |
| **Reasoning Ledger** | Candidate 4 | Strict 6-type commit discipline + `Ledger-Ancestors:` trailers + auditability |
| **Meta-Dogfood** | Candidate 6 (spirit) | Governance and Layer 0 changes must themselves run through the Universe Grok harness |

---

## Layer 0 — The Immutable Spine (Nuclear Protection)

These files and mechanisms are the project's reason for existing. Any change touching them is **automatically Tier 0 (Nuclear)**.

**Exact list**:
- `CONSTITUTION.md`
- `AGENTS.md` (bootstrap protocol, propagation rules, dev awareness contract)
- Entire `.universe-grok/` (CURRENT-TRUTH.md, `truth/`, `decisions/`, NAMING-CONVENTION.md)
- `hooks/session-start.sh` + `hooks/session-start.json`
- Core truth-seeking and bootstrap sections in `skills/universe-grok/SKILL.md`
- `GOVERNANCE.md` itself

**Tier 0 Process (non-negotiable)**:
1. Full harness execution on the change (`/first-questions` + research + `/universe-grok` orchestration + `universe-verifier` PASS).
2. `universe-doctor` report from a clean local-marketplace environment.
3. `scripts/simulate-contribution.sh --tier0` (mechanical re-execution of the real hook proving truth injection still works).
4. Two human stewards + written justification.
5. Minimum 72-hour real-world observation window after merge (with rollback trigger defined in the PR).
6. Commit must follow Reasoning Ledger (`gov:` or `decision:` root).

---

## Tiered Risk Model (Proportional Gravity)

`scripts/classify-risk.sh` mechanically determines the tier of any PR by the files touched. The entire PR is raised to the highest tier present.

- **Tier 0 — Nuclear** (Layer 0 + hooks + truth injection + governance changes)
- **Tier 1 — High** (personas, core orchestration logic, new high-impact skills)
- **Tier 2 — Medium** (new features, significant refactors, documentation that affects behavior)
- **Tier 3 — Low** (typos, minor docs, tests, small examples)

Each tier has its own PR template and evidence requirements. Lower tiers are deliberately welcoming.

---

## The Only Recommended Development Path (Local Marketplace + Doctor)

**Golden Path (what serious contributors must use and claim in PRs)**:

1. `bash scripts/dev-setup.sh` (safe symlink + personas + skills)
2. `bash scripts/create-local-marketplace.sh --print-toml-snippet` → register as local `[[marketplace.sources]] path=...`
3. Install via the real Marketplace tab / TUI (exactly as users will)
4. Run `./scripts/universe-doctor.sh --verbose` on every session (must show `LOCAL_MARKETPLACE`)
5. Do the work under the harness (`/first-questions`, research, `/universe`, verifier)
6. For Tier 0: `scripts/simulate-contribution.sh --tier0 --verify-injection`
7. Commit with proper Reasoning Ledger types + trailers
8. Open PR using the tier-specific template (classifier output + doctor + artifacts required)

Raw `ln -s` into `~/.grok/plugins/` is still technically possible for emergency hot-patching but is **explicitly invalid** as evidence for any Tier 1+ PR.

---

## Forced Observability (The Real Defense)

Two non-bypassable mechanisms make confusion impossible:

1. **SessionStart Hook Awareness Block** (printed on *every* session)
   - Truth layer injection (the project's foundation)
   - Live `ls -la` on plugin root + skills links
   - Explicit classification: `DEV SYMLINK` vs `LOCAL_MARKETPLACE` vs `PROD MARKETPLACE`
   - Immediate instruction: "Run `universe-doctor` now"

2. **`universe-doctor`** (`/universe doctor` or `scripts/universe-doctor.sh`)
   - Detects exact install method and blast radius
   - Runs risk classifier
   - Surfaces hook health, persona conflicts, cache staleness, ledger hygiene
   - Produces the canonical evidence artifact required in every serious PR

---

## Reasoning Ledger (Commit History as Governance Surface)

All commits must use one of the six types:
- `truth:`, `decision:`, `research:`, `gov:`, `impl:`, `verify:`

High-risk commits require `Ledger-Ancestors:` trailers pointing to the decision/research/evidence commits that justified the change.

`universe-doctor ledger-audit <sha>` makes the full provenance chain queryable in any clone.

---

## Meta-Dogfood Requirement (for Governance Itself)

Any change to `GOVERNANCE.md`, Layer 0 definitions, the hybrid model, or the core enforcement mechanisms (hook awareness, doctor contract, risk classifier) must be executed as a Tier 0 change using the Universe Grok harness itself. The resulting first-questions + research + verifier artifacts become part of the PR.

This is the only way the project can credibly claim that its governance is consistent with its product.

---

## Tooling Inventory (All Executable in `scripts/`)

- `universe-doctor.sh` — the central diagnostic (use daily)
- `create-local-marketplace.sh` — generates `marketplace.json` and the exact config snippet
- `classify-risk.sh` — mechanical tier classifier
- `dev-setup.sh` — safe contributor environment bootstrap
- `clear-grok-cache.sh` — the #1 recovery command after hook/skill edits
- `simulate-contribution.sh` — Tier 0 nuclear testing harness (re-executes real hook)

Plus Makefile targets for the most common operations (`make doctor`, `make test-local-marketplace`, `make simulate-tier0`).

---

## How This System Was Adopted

This GOVERNANCE.md and the associated decision record (`2026-05-19-hybrid-structural-governance-system-adoption.md`) were created after:
- Fresh external research on real plugin ecosystem failures and successes.
- A complete best-of-6 parallel implementation tournament in isolated worktrees.
- Explicit first-questions interrogation of the problem.
- Synthesis of only the highest-signal elements that directly address the documented pain (Marketplace distribution + hook safety + contributor unawareness).

Future evolution of this document must itself follow the rules it defines.

---

**This is the current contract.**  
Violations (especially bypassing Layer 0 awareness or claiming "tested" without LOCAL_MARKETPLACE + doctor evidence on Tier 1+) are treated as protocol failures and will be rejected by verifiers and maintainers.

We build in the open. We protect the truth layer mechanically. We make the dangerous surfaces visible. We stay usable.

This is how a truth-seeking orchestration harness survives its own success.