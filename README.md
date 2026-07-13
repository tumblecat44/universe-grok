# universe-grok

**Web-Grok-style parallel research for [Grok Build](https://x.ai/cli).**

Web Grok is great at real-time exploration: many searches at once, follow-ups, then a grounded answer. Grok Build has the same tools — it just doesn’t force that research mode. This plugin does.

```text
/universe-search <your question>
```

---

## Install

One command (recommended):

```bash
grok plugin install tumblecat44/universe-grok --trust
```

Then in Grok Build:

```text
/universe-search what is the current stable Node.js LTS version
```

You should see **multiple** web searches in one turn, then an answer grounded in those results.

### Other ways

| Method | Command |
|--------|---------|
| **TUI** | `/plugins` → `a` → `tumblecat44/universe-grok` → trust when prompted |
| **Update** | `grok plugin update universe-grok` |
| **Uninstall** | `grok plugin uninstall universe-grok` |
| **Local path** | `grok plugin install ./universe-grok --trust` after cloning |

<details>
<summary>Manual skill copy (no plugin system)</summary>

```bash
git clone https://github.com/tumblecat44/universe-grok.git
cp -R universe-grok/skills/universe-search ~/.grok/skills/
```

</details>

---

## What you get

| | |
|---|---|
| **Plugin** | `universe-grok` |
| **Skill / command** | `/universe-search` |
| **Does** | Fan out parallel web + page + X searches, then answer from fresh evidence |
| **Does not** | Auto-run on every message — only when you invoke `/universe-search` |

A [skill](https://agentskills.io/) is a `SKILL.md` folder of instructions. A **plugin** packages skills (and optionally more) so people install with one command.

---

## Requirements

- [Grok Build](https://x.ai/cli) (`grok` CLI)
- Network access for web / X search tools

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

Model auto-invoke is off — research mode only runs when you type `/universe-search`.

---

## How it works

No new APIs. The skill forces a web-Grok-shaped loop on tools Grok Build already has:

1. **Query pack** — distinct angles (canonical name, locale, benchmarks, reviews, comparison, X when relevant)
2. **Wave 1** — several `web_search` (and optional X) calls **in parallel**
3. **Wave 2** — open high-value pages; only re-search named gaps
4. **Answer** — direct answer first, tables when comparing, no invented numbers

Full instructions: [`skills/universe-search/SKILL.md`](./skills/universe-search/SKILL.md)

---

## Repository layout

```text
universe-grok/
├── README.md
├── LICENSE
├── .grok-plugin/
│   └── plugin.json          # plugin metadata
└── skills/
    └── universe-search/
        └── SKILL.md         # /universe-search
```

---

## License

[MIT](./LICENSE)
