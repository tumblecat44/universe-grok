# Universe Grok

**A truth-seeking orchestration harness for Grok Build.**

Universe Grok turns Grok Build from a powerful model into a **system that actively pursues current truth** instead of relying on stale training data.

It is not just another skill. It is an attempt to build the highest-leverage way to use Grok for serious software engineering work.

## Core Philosophy

> The biggest limitation of current coding agents is not intelligence — it is operating on outdated internal knowledge.

Universe Grok's defining behavior:

- At the start of every session, it proactively researches **current best practices** using X (Twitter) and Web search.
- It treats "what the model already knows" as a hypothesis, not as truth.
- All orchestration, verification, and agent collaboration exists to serve **better contact with reality**.

See [CONSTITUTION.md](./CONSTITUTION.md) for the full principles and Level 2 → Level 3 vision.

## Current Status

- **Target**: Level 2 (Reliable, high-quality harness)
- **Vision**: Level 3 (The standard way serious people use Grok Build)

We are building this in the open as a public project.

## Features (Current)

- Strong curated personas (`universe-verifier`, `universe-researcher`, `universe-tactician`, etc.)
- Session Start automatic best-practice research hook (X + Web)
- **First Questions** companion skill (`/first-questions`) — ruthless "Question every requirement" ritual that forces a one-sentence goal and deletes scope before any work begins
- **First Principles** companion skill (`/first-principles`) — forces explicit sourced bedrock facts and reconstruction from reality (not analogy) before solution work; co-equal highest-authority artifact with first-questions.md
- Clear Constitution that actually influences behavior
- Deep integration philosophy with existing high-quality skills (`/check`, `/best-of-n`, etc.)

## Installation

```bash
# 1. Clone the repo
git clone https://github.com/your-org/universe-grok.git ~/.grok/plugins/universe-grok

# 2. Install the personas (recommended)
cp ~/.grok/plugins/universe-grok/personas/*.toml ~/.grok/personas/

# 3. Restart Grok Build or reload plugins
```

After installation, activate with natural language:
- "universe mode" / "full power"
- "first questions" + "first principles" (the required non-negotiable pair as the very first steps on any serious work)
- "first principles" (the required reconstruction step after first-questions, before orchestration)
- "push Grok to the limit"

Recommended order for maximum-leverage sessions:
1. `/first-questions` — Kill ambiguity and delete everything that fails the test.
2. `/first-principles` (on surviving scope) — Reconstruct the minimal solution from explicit bedrock truths before any design or implementation.
3. research hook if needed
4. `/universe` — Orchestrate with the two sacred artifacts (first-questions.md + first-principles.md) as co-equal contracts.

Or explicitly with `/universe` and `/first-questions`.

## How It Works

**The highest-leverage flow** (use this):

1. **First Questions** (`/first-questions`) — Before anything else, force the One-Sentence Goal and ruthlessly interrogate every requirement using Elon’s "Question every requirement" protocol. Delete what fails. Produce the sacred `.grok/first-questions/first-questions.md` artifact.
2. **Session Start Research** — Universe Grok’s hook triggers fresh X + web research into current best practices.
3. **Orchestration** — Uses strong personas and optimal subagent topologies.
4. **Verification** — Independent `universe-verifier` on every meaningful change.

First Questions is the foundation. Universe Grok orchestration is only as good as the clarity of the goal it receives.

## Project Structure

```
universe-grok/
├── skills/
│   ├── universe-grok/SKILL.md        # Main orchestration logic
│   └── first-questions/SKILL.md      # Ruthless requirement interrogation (run this first)
├── personas/                         # Universe-optimized personas
├── hooks/                            # SessionStart truth-seeking hook
├── CONSTITUTION.md                   # The soul of the project
├── plugin.toml
└── README.md
```

## Roadmap

See [CONSTITUTION.md](./CONSTITUTION.md) for Level definitions.

High priority:
- Stronger Session Start research protocol
- Better automatic stack detection
- More powerful personas
- Richer research artifact consumption by subagents

## Contributing

We welcome contributions, especially in:
- High-signal personas
- Research protocols and truth-seeking mechanisms
- Real usage examples and case studies

Please read [CONTRIBUTING.md](./CONTRIBUTING.md) and [CONSTITUTION.md](./CONSTITUTION.md) first.

## License

MIT

---

**"The difference between a strong model and a strong system is the relentless pursuit of truth."**

This project is in active development toward Level 3. Star the repo and follow along if you want to push Grok Build to its absolute limits.
