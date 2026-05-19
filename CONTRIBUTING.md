# Contributing to Universe Grok

Thank you for your interest. This project exists to make the highest-leverage use of Grok Build the default for serious work. Protecting that identity while remaining usable for real contributors (human and agent) requires strong structural governance.

**Read `GOVERNANCE.md` first.** It is the binding contract.

---

## The Only Recommended Path (Local Marketplace + Diagnostic Powerhouse)

This is the golden path. Every serious PR (Tier 1+) must be able to truthfully claim:  
**"I tested this change via Local Marketplace and the doctor confirmed LOCAL_MARKETPLACE mode."**

### 8-Step Contributor Workflow

1. **Clone and enter safe dev mode**
   ```bash
   git clone https://github.com/<your-fork>/universe-grok.git
   cd universe-grok
   bash scripts/dev-setup.sh
   ```

2. **Create and register a Local Marketplace** (this is the key differentiator)
   ```bash
   bash scripts/create-local-marketplace.sh --print-toml-snippet
   ```
   Copy the output into your `~/.grok/config.toml` under `[[marketplace.sources]]` (use an absolute `path=`).

3. **Install via the real user surface**
   - Open Grok Build TUI → Marketplace tab (`Ctrl+L` or equivalent)
   - Refresh and install `universe-grok` from your local source
   - Start a **fresh** session

4. **Run the doctor on every session**
   ```bash
   ./scripts/universe-doctor.sh --verbose
   ```
   You must see `INSTALL TYPE: LOCAL_MARKETPLACE` (green). Paste this output in your PR.

5. **Do the actual work under the harness**
   - `/first-questions`
   - Fresh external research (`web_search` + `x_search`) when required by the Permanent Law
   - `/universe-grok` (or `/universe`) with proper subagent topology
   - `universe-verifier` loop until PASS

6. **For anything touching hooks, Layer 0, or governance (Tier 0)**
   ```bash
   bash scripts/simulate-contribution.sh --tier0 --verify-injection
   ```
   This mechanically re-runs the real `session-start.sh` in an isolated environment and fails if the truth injection or bootstrap sentence is broken.

7. **Commit with Reasoning Ledger discipline**
   Use one of: `truth:`, `decision:`, `research:`, `gov:`, `impl:`, `verify:`
   Include `Ledger-Ancestors:` trailers for high-risk changes.

8. **Open the PR using the correct template**
   The PR template will demand:
   - `classify-risk.sh` output
   - `universe-doctor --verbose` report
   - Harness artifacts (first-questions, research, verifier PASS)
   - Simulation proof for Tier 0

---

## What "Tested" Actually Means Here

- Raw `ln -s` into `~/.grok/plugins/` is allowed for rapid iteration but **does not count** as evidence for any Tier 1+ PR.
- Only changes proven under a registered Local Marketplace (or official git Marketplace source) + doctor confirmation are acceptable.
- Hook and truth-injection changes must survive `simulate-contribution.sh --tier0`.

---

## Risk Tiers at a Glance

| Tier | Examples | Evidence Required | Process |
|------|----------|-------------------|---------|
| 0 (Nuclear) | `hooks/session-start.sh`, `.universe-grok/`, `GOVERNANCE.md`, `AGENTS.md`, core bootstrap in SKILL.md | Full harness artifacts + simulation + doctor from clean env + 2 stewards + 72h observation | Nuclear |
| 1 (High) | New personas, major orchestration changes, new high-impact skills | Doctor + evidence artifacts + classifier | Strict review |
| 2 (Medium) | New features, refactors, behavior-affecting docs | Doctor + basic artifacts | Normal review |
| 3 (Low) | Typos, minor docs, small tests | Minimal (still run doctor) | Fast track |

Run `./scripts/classify-risk.sh --auto` before opening the PR.

---

## Reasoning Ledger Commit Types

All commits should use one of these prefixes:

- `truth:` — Changes to truth layer or CURRENT-TRUTH.md
- `decision:` — Architectural or governance decisions
- `research:` — Fresh external research being recorded
- `gov:` — Process, GOVERNANCE.md, templates, CI rules
- `impl:` — Normal implementation
- `verify:` — Verification results, tests, simulation artifacts

High-risk changes require `Ledger-Ancestors:` trailers linking back to the justifying decision/research commits.

---

## Recovery Commands (You Will Need These)

```bash
./scripts/universe-doctor.sh --verbose          # Daily truth + environment check
./scripts/clear-grok-cache.sh                   # After hook/skill edits (the #1 fix)
./scripts/dev-setup.sh                          # Re-enter safe contributor mode
```

---

## Persona Contributions

Personas are powerful. A bad one can affect thousands of users. They are treated as at least Tier 1. Include a "Failure Mode Analysis" in your evidence artifacts.

---

## Questions?

- The doctor output usually contains the answer.
- For governance or Layer 0 questions, open an issue first (or run the harness on the question itself).

We are building the strongest practical system that still lets serious people ship.

Welcome. Read the doctor. Respect the truth layer. Test like your users will run it.