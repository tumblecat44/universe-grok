# Contributing to Universe Grok

Thank you for your interest in Universe Grok — the truth-seeking orchestration harness for Grok Build.

## Our Mission

Universe Grok exists to help people extract maximum truth and quality from Grok Build by making systematic, high-leverage multi-agent collaboration the default.

We are building toward **Level 3**: becoming the de-facto standard way serious users run Grok Build on complex work.

## How to Contribute

### 1. Personas
High-quality, opinionated personas are one of the highest-leverage contributions.

- Focus on clear role, strong principles, and specific output contracts.
- Look at existing personas in `/personas/` for the expected style.

### 2. Research Protocols & Hooks
The Session Start Truth-Seeking mechanism is core to our identity.

- Improving what questions we ask
- Better ways to surface current best practices from X and the web
- Smarter ways to inject research into the agent's context

### 3. Orchestration Logic
Improvements to the main skill in `skills/universe-grok/SKILL.md`.

### 4. Documentation & Examples
Clear examples of how Universe Grok changes outcomes on real tasks are extremely valuable.

## Development Setup

```bash
# Clone
git clone https://github.com/<your-org>/universe-grok.git
cd universe-grok

# Install into your Grok Build
mkdir -p ~/.grok/plugins
ln -s $(pwd) ~/.grok/plugins/universe-grok

# Also install personas (recommended)
cp personas/*.toml ~/.grok/personas/
```

## Philosophy

- We prioritize **truth over convenience**.
- We prefer **strong, opinionated defaults** over excessive configuration.
- We document Level 3 vision publicly even while shipping Level 2.

## Pull Request Guidelines

- Keep changes focused.
- Update `CONSTITUTION.md` if you are changing core principles.
- For new personas, include a short rationale in the PR.

Let's build the best possible harness for pushing Grok to its limits.

Welcome aboard.
