# Decision: Deprecate the Overfitted "Permanent Mandatory Research-First Law" (Prompt Patching Failure)

**Date**: 2026-05-19
**Status**: APPROVED — Law is deprecated and all references must be removed
**Decision Makers**: User + Agent (via explicit /check verification)

## Context

During a session investigating Grok Build's Hook system, the agent failed to perform mandatory external research (`web_search` + `x_search`) on a recommendation-seeking query ("hooks는 어떤 방식으로 추가하는지 알려줘") and later on a knowledge-gap query ("grok 의 Hooks 시스템이 어떻게 됨").

This triggered the creation (via `/best-of-n`) of an increasingly complex textual contract called the "Permanent Mandatory Research-First Law", placed in the truth layer at:

`.universe-grok/truth/permanent-mandatory-research-first-law-for-recommendation-queries.md`

The law attempted to force research behavior through:
- Multi-class trigger definitions (recommendation language + knowledge-gap on named systems)
- A mandatory verbatim first sentence in private reasoning
- Word-by-word decomposition requirements
- Explicit bans on rationalizations ("this is just an explanation", "I already know the docs")
- Identity-level shame language ("first-order betrayal of the project's identity")
- Invalidation of any work produced without compliance

The law was wired into AGENTS.md bootstrap, CURRENT-TRUTH.md, and the SessionStart hook (which generated a runtime marker `research-first-law-active.md`).

## Diagnosis via /check

A subsequent `/check` (with explicit focus on whether this was prompt overfitting) returned **VERDICT: FAIL** with the following key findings:

- This was a textbook case of iterative prompt patching: every concrete failure discovered by the user or verifier was closed by adding another conditional class, another mandatory ritual sentence, another "zero exceptions" clause.
- The structural elements (truth layer + hook-generated marker + bootstrap forcing) were only scaffolding. The actual enforcement remained a giant block of natural language rules the LLM was expected to follow perfectly.
- This directly contradicted the project's own philosophy (externalized artifacts over self-instructions, "the best part is no part", structural enforcement via hooks/verifiers/artifacts rather than longer prompts).
- It created a ratchet for prompt rot: future missed cases would require even more text, making compliance harder, not easier.
- The "machine-checkable mandatory sentence" was itself a prompt trick, not a real mechanical gate.

The verifier concluded:

> "This is prompt-engineering overfitting dressed in the project's good structural clothing. ... This is the definition of 땜빵 과적합."

## Decision

**The "Permanent Mandatory Research-First Law" is formally deprecated and must be fully removed.**

Reasons:
- It added surface area and complexity without adding a new fundamental enforcement primitive.
- It repeated the exact failure mode it was trying to solve (relying on the model to perfectly interpret an ever-growing set of rules).
- It was created through test-case-driven patching rather than first-principles structural design.
- Continuing to maintain or extend it would constitute further overfitting.

All references to the law in AGENTS.md, CURRENT-TRUTH.md, `hooks/session-start.sh`, and any runtime markers must be cleaned up in the same session.

## What We Learned (Important for Future Work)

The correct lesson is not "we need an even more complete textual contract."

The correct lesson is:

> When you find yourself adding more and more conditional rules to a prompt to force a behavior, you are almost always solving the wrong problem. The real leverage is in changing the environment (hooks, artifacts, verifiers, default topologies, path-of-least-resistance tooling) so that the desired behavior becomes the easiest or only available path.

This project already possesses several high-quality examples of this approach:
- SessionStart hook creating explicit pending research artifacts
- Marker files (`full-mode-active.md`) that flip entire behavioral modes without the model having to "remember" rules
- Bootstrap protocol that forces discovery of the truth layer before any user work
- First-questions and first-principles as real, reviewable artifacts rather than prompt reminders
- Treating the verifier as sacred

Future attempts to enforce research discipline must start from these patterns, not from "write a better law."

## Next Action

Design a genuine structural solution for making external research the default, low-friction, hard-to-avoid behavior in this harness — using hooks, artifacts, and verifier gates rather than prompt bloat.

This decision record is now part of the Current Truth layer and must be read during any future bootstrap when considering research enforcement mechanisms.

---

**This is not a failure of intent. It is a failure of method.** The intent (forcing contact with current reality instead of stale knowledge) remains correct. The method (ever-longer self-policing prompt text) was the mistake.