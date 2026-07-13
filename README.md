# universe-search

**Web-Grok-style parallel research for [Grok Build](https://grok.x.ai).**

Web Grok is great at real-time exploration: many searches at once, follow-ups, then a grounded answer. Grok Build has the same tools — it just doesn’t force that research mode. This skill does.

```text
/universe-search <your question>
```

---

## What is this?

A single [Agent Skill](https://agentskills.io/) (`SKILL.md`) for **Grok Build**. Skills are folders of instructions the agent loads on demand so it handles a class of tasks the same way every time.

| | |
|---|---|
| **Skill** | `universe-search` |
| **Command** | `/universe-search` |
| **Does** | Fan out parallel web + page + X searches, then answer from fresh evidence |
| **Does not** | Auto-run on every message — only when you invoke it |

Repo name: **universe-grok** (skill pack home). First (and currently only) skill: **universe-search**.

---

## Requirements

- [Grok Build](https://grok.x.ai) (skills under `.grok/skills/` or `~/.grok/skills/`)
- Network access so the agent can run web / X search tools

---

## Install

### Option A — Use in every project (recommended)

```bash
git clone https://github.com/tumblecat44/universe-grok.git
cp -R universe-grok/.grok/skills/universe-search ~/.grok/skills/
```

Grok loads skills from `~/.grok/skills/` for all projects.

### Option B — This project only

```bash
git clone https://github.com/tumblecat44/universe-grok.git
cd your-project
mkdir -p .grok/skills
cp -R /path/to/universe-grok/.grok/skills/universe-search .grok/skills/
```

Open that project in Grok Build. Repo-local skills under `.grok/skills/` are discovered automatically.

### Option C — Skill path in config

Keep the clone anywhere and point Grok at it in `~/.grok/config.toml`:

```toml
[skills]
paths = ["/absolute/path/to/universe-grok/.grok/skills"]
```

### Verify

In Grok Build:

1. Slash menu should list `/universe-search` (skills reload when files change on disk).
2. Run:

```text
/universe-search what is the current stable Node.js LTS version
```

You should see **multiple** web searches in one turn, then an answer grounded in those results — not a one-shot memory reply.

---

## Usage

```text
/universe-search <question or research topic>
```

| Example | What you get |
|---------|----------------|
| `/universe-search LG Gram 16Z90TP specs vs closest MacBook` | Specs, benchmarks, comparison table, who should buy which |
| `/universe-search breaking changes in React 19 for Next.js apps` | Primary docs + migration notes from current sources |
| `/universe-search latest security advisories for package X` | Current CVE / advisory signal, with uncertainty called out |

**Explicit only:** model auto-invoke is off (`disable-model-invocation: true`). Research mode runs when you type `/universe-search`.

If you omit the topic, the agent asks one clarifying question first.

---

## How it works

The skill does not add new APIs. It forces a web-Grok-shaped loop on tools Grok Build already has:

1. **Query pack** — split the question into distinct angles (canonical name, locale language, benchmarks, reviews, comparison, live X when relevant).
2. **Wave 1** — fire **several** `web_search` (and optional X search) calls **in parallel**.
3. **Wave 2** — open high-value pages; only search again for named gaps or conflicts.
4. **Answer** — lead with the direct answer, tables when comparing, no invented numbers, cite session sources when claims depend on search.

Details live in [`.grok/skills/universe-search/SKILL.md`](./.grok/skills/universe-search/SKILL.md).

---

## Repository layout

```text
universe-grok/
├── README.md
├── LICENSE
└── .grok/skills/
    └── universe-search/
        └── SKILL.md    # agent instructions
```

---

## License

[MIT](./LICENSE)
