---
name: universe-search
description: >
  Web-Grok-style real-time research for Grok Build. Fan out parallel web
  searches, page browses, and X searches, then answer from fresh evidence.
  Use only when the user runs /universe-search (explicit research mode).
disable-model-invocation: true
argument-hint: "<question or research topic>"
metadata:
  author: universe-grok
  short-description: "Parallel web + X research mode"
---

# Universe Search

Bring **web Grok's real-time research** into Grok Build.

You already have search tools. This skill forces you to use them the way web
Grok does: **many targeted queries in parallel**, follow-ups when gaps appear,
then a grounded answer. Do **not** answer from training memory alone when the
question needs current facts, specs, prices, versions, news, or comparisons.

Trigger: user ran `/universe-search` (with or without a topic after the command).

---

## Hard rules

1. **Search before you conclude.** If the topic is factual, product, market,
   API, version, news, or comparison-shaped — research first, answer second.
2. **Parallel first wave.** Prefer **multiple tool calls in one turn** over
   one query, wait, one query. Aim for **4–8** diverse searches up front.
3. **Use the right surface:**
   - `web_search` — discovery, specs, benchmarks, reviews, docs
   - `open_page` / `open_page_with_find` / `web_fetch` — primary pages, deep detail
   - `x_keyword_search` / `x_semantic_search` / `x_thread_fetch` — live reaction,
     announcements, complaints, FOMO threads
4. **Language fan-out.** If the user wrote Korean (or another locale language),
   search in **both** that language and English when products/docs are global.
5. **No fake sources.** Only cite or rely on what tools actually returned.
6. **Do not write research reports to disk** unless the user asks. Default:
   answer in chat with enough structure to be useful.
7. **Stay in research mode for this turn chain.** Keep searching until the
   answer would not materially improve with one more targeted wave — or the
   user redirects you.

---

## Workflow

### 0. Lock the question

- If `/universe-search` has no topic, ask **one** short clarifying question,
  then stop until they answer.
- If the topic is clear, restate it internally as: *what must be true for a
  good answer?* (e.g. exact model, comparison axes, "current as of today").

### 1. Plan a query pack (silent, fast)

Decompose into a **query pack** — do not dump a long plan unless the user
asked for process. Cover:

| Slot | Purpose | Example |
|------|---------|---------|
| Canonical | Official name / product page | `LG Gram 16Z90TP specs` |
| Locale | User language | `LG 그램 16Z90TP 스펙 성능` |
| Benchmarks | Numbers | `Core Ultra 7 255H Geekbench` |
| Reviews | Real-world | `16Z90TP review battery` |
| Comparison | Rival / peer | `MacBook Air 15 M4 vs LG Gram Pro 16` |
| Live | X / social | recent posts about the product or claim |

Skip slots that do not apply. Add slots that do (CVE, changelog, pricing, law…).

### 2. Wave 1 — fire in parallel

In **one** assistant turn, call tools together:

- 3–6× `web_search` with distinct angles (not the same string rephrased twice)
- 0–2× X search when sentiment, launch noise, or "what people say now" matters
- Set sensible `num_results` / `limit` (enough signal, not spam)

Do **not** wait for a perfect plan. Imperfect parallel beat perfect sequential.

### 3. Wave 2 — fill gaps only

After Wave 1:

- **Open** 1–4 high-value URLs (official specs, strong reviews, primary docs)
- Run **follow-up searches** only for missing pieces (wrong model year, missing
  GPU name, no multi-core numbers, no price band, etc.)
- If two sources conflict, search for a **third** or open the primary source

Stop when extra searches would only polish wording.

### 4. Answer

Write the answer the user actually wanted:

- Lead with the direct answer
- Use tables when comparing options
- Prefer concrete numbers with ranges when reviews disagree
- Separate **fact** vs **judgment** ("benchmarks show…" vs "pick A if…")
- Mention uncertainty explicitly when sources are thin or conflicting
- Cite web/X findings with the citation mechanism available in this session
  when claims depend on search results

If the user only wanted research as prep for coding, end with **actionable
implications** for the next build step (what to implement, pin, or avoid) —
still without inventing a report file.

---

## Parallelism checklist (match web Grok)

Before your first non-tool reply on a research-heavy topic, you should have:

- [ ] Multiple **distinct** web queries (not one mega-query)
- [ ] Locale + English when relevant
- [ ] At least one path to **primary** material (official page, docs, datasheet)
- [ ] Comparison or benchmark queries when the user asked to compare
- [ ] X search when "now / hype / backlash / announcement" matters
- [ ] A second wave if Wave 1 left a hole you can name

If you answered from memory with zero tool calls on a current-facts question,
you failed this skill. Go back and search.

---

## Anti-patterns

- One web search, then a long essay
- Searching only English for a Korean product question (or the reverse)
- Treating SEO blogs as equal to official specs
- Inventing Geekbench / battery / price numbers
- Sequential "search → think → search → think" when the next three queries
  were already obvious
- Turning every run into a repo markdown report (not requested)

---

## Minimal good example (shape, not content)

User: `/universe-search LG Gram 16Z90TP 성능 알려주고 맥북 동사양 비교`

You (one turn): parallel tools ≈

1. web: `LG Gram 16Z90TP specs`
2. web: `LG 그램 16Z90TP 스펙 성능`
3. web: `LG Gram 16Z90TP processor CPU benchmark`
4. web: `MacBook Air 15 M4 vs LG Gram Pro 16`
5. web: `Intel Core Ultra 7 255H Geekbench vs Apple M4`
6. optional X: recent posts about the model

Then open best sources → short second wave if needed → specs + comparison
table + who should buy which.

That shape is the bar.

---

## When research is enough

You are done when:

1. The user's question is answered with evidence from this session's tools, and
2. Remaining unknowns are named (not papered over), and
3. You are not still planning to "search more later" for load-bearing claims.

Then stop, or hand off to normal coding if they ask to build next.
