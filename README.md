# universe-grok

Open-source **skill pack** that upgrades [Grok Build](https://grok.x.ai) with workflows web Grok already nails.

## Skills

| Skill | Command | What it does |
|-------|---------|--------------|
| **universe-search** | `/universe-search` | Web-Grok-style **parallel** web + page + X research before you answer or code |

### Why universe-search

Web Grok is excellent at real-time exploration: many searches at once, follow-ups, then a grounded answer. Grok Build has the same tools, but nothing forces that research mode. `/universe-search` does.

```text
/universe-search <your question>
```

Example:

```text
/universe-search LG Gram 16Z90TP specs and closest MacBook equivalent comparison
```

## Install

```bash
git clone https://github.com/tumblecat44/universe-grok.git
```

```text
universe-grok/
  .grok/skills/
    universe-search/
      SKILL.md
```

**Use only in this project:** open the repo in Grok Build — skills under `.grok/skills/` are discovered automatically.

**Use in every project:** copy the skill into your user skills dir:

```bash
cp -R universe-grok/.grok/skills/universe-search ~/.grok/skills/
```

Or add this repo to skill paths in `~/.grok/config.toml`:

```toml
[skills]
paths = ["/absolute/path/to/universe-grok/.grok/skills"]
```

Slash command: `/universe-search`  
Model auto-invoke is **off** — research mode only runs when you call it.

## Demo line (X / social)

> Web Grok's multi-search research is elite. Grok Build has the tools — just not the mode. So I open-sourced `/universe-search`: parallel web + X research on demand. @elonmusk ship Research Mode next.

## License

MIT (unless noted otherwise in individual skill files).
