# First Principles — Session Reconstruction

**Session Date**: 2026-05-18
**Status**: TEST SIMULATION (Live verification of /first-principles skill)
**Complements**: `.grok/first-questions/first-questions.md` (historical; new One-Sentence Goal derived for this test problem as prerequisite enforcement)

## The One-Sentence Goal (from First Questions simulation for this test problem)

> "Enable users and the community to contribute additional skills to the universe-grok plugin as independent directories under skills/ (e.g. skills/my-skill/SKILL.md) that are automatically discovered, registered for natural-language and slash-command activation, and isolated so that they cannot pollute core orchestration logic or cause activation keyword/slash_command collisions with built-in skills or other contributions."

## Bedrock Facts (Irreducible, Sourced Truths)

### 1. Flat Directory Tree as Skill Packaging Unit

- **Statement**: "The skills/ directory in the universe-grok source tree contains zero or more immediate subdirectories; each sub-directory that is a valid skill contains exactly one file named SKILL.md at its root. Discovery is performed by enumerating immediate children of skills/ and parsing the frontmatter of each SKILL.md."
- **Source**: Direct filesystem measurement via list_dir and find on /Users/dgsw67/grok-build-project/universe-grok/skills (2026-05-18): exactly three sibling entries (first-principles/, first-questions/, universe-grok/), each containing precisely one SKILL.md. No deeper nesting, no index file, no loader script in the repo.
- **Why this is bedrock (cannot be reduced further here)**: If the packaging unit were not "one dir = one SKILL.md", the current three skills would not exist in their observed form, and the act of adding first-principles by creating skills/first-principles/SKILL.md would not have been a valid addition. Any proposed architecture that assumes packages, zip files, or remote registries as the atomic unit contradicts this observed physical structure of the working system.

### 2. Frontmatter Schema Is the Sole Activation Contract

- **Statement**: "Activation (slash command and natural language keyword matching) is driven exclusively by two fields inside the leading YAML frontmatter of SKILL.md: `metadata.slash_command` (string) and `metadata.keywords` (array of strings). The host (Grok Build) and the universe-grok skill itself match user input against these strings."
- **Source**: Primary text extraction from the exact bytes of the three SKILL.md files (read_file tool, first 30 lines of each, 2026-05-18). All three declare `slash_command:` and `keywords:` in identical structure under `metadata:`. No other registration mechanism (no JSON manifest, no exported function, no plugin.toml [skills] array) appears in the parsed content.
- **Why this is bedrock**: Changing or adding a skill's invocability requires editing only those two strings in its SKILL.md. If the host used a different contract, the observed SKILL.md files would be non-functional, yet the first-principles skill was created precisely by writing a file with those fields and expecting `/first-principles` to work.

### 3. No Built-in Uniqueness or Conflict Enforcement Exists in the Current System

- **Statement**: "There is no code, script, or runtime check anywhere in the checked-out universe-grok tree that enumerates all declared slash_command or keyword values across skills/ and rejects duplicates or overlaps."
- **Source**: Exhaustive content search (grep for "slash_command", "keywords", "conflict", "collision", "unique" across all *.md, *.sh, *.toml, *.json in the repo) returned matches only inside the three skill frontmatters themselves and in descriptive prose; zero enforcement logic. git grep and file reads of hooks/, install.sh, plugin.toml confirm absence.
- **Why this is bedrock**: The mathematical consequence is that as the number of contributed skills N increases, the probability of accidental or malicious collision on a popular term ("first", "question", "universe") grows at least linearly with N (and quadratically for pairwise checks if done naively). A system that claims "without causing activation conflicts" must introduce an enforcement point; the current physical state has none.

### 4. Plugin-Level Activation vs Skill-Level Activation

- **Statement**: "The plugin.toml [activation] section only registers top-level natural language triggers for the entire plugin ('universe', 'full power', etc.). Individual skills inside the plugin are activated by string match against their own frontmatter keywords and slash_command, independent of the plugin manifest."
- **Source**: Exact content of plugin.toml (read_file, lines 14-18): `keywords = ["universe", "universe grok", ...]` at the [activation] level. No per-skill registration. Combined with the flat skills/ observation (fact 1) and frontmatter observation (fact 2).
- **Why this is bedrock**: Any architecture that tries to route all skill discovery through plugin.toml updates will necessarily pollute the core manifest on every contribution, violating the "without polluting the core" constraint in the goal. The separation of plugin activation (coarse) from per-SKILL.md activation (fine) is an observed invariant of the running design.

### 5. Artifact + Wiring Pattern Is the Only Proven Way to Make a New Skill Authoritative

- **Statement**: "For a newly added skill file (skills/X/SKILL.md) to actually change agent behavior in universe-grok sessions, three non-file actions were required in the immediately prior first-questions addition: (a) modification of CONSTITUTION.md to name the pillar, (b) modification of README.md to document the sequence and command, (c) modification of skills/universe-grok/SKILL.md to add prerequisite language and artifact reference."
- **Source**: git diff output on 2026-05-18 for CONSTITUTION.md, README.md, skills/universe-grok/SKILL.md (the exact hunks that added first-questions references but did *not* add equivalent first-principles references). The first-questions.md artifact itself documents "Wiring the skill into CONSTITUTION.md, README.md, and universe-grok/SKILL.md as prerequisite" as a KEPT item with explicit rationale against the "just drop the file" anti-pattern.
- **Why this is bedrock**: Human users and sub-agents discover and internalize behavior through the highest-authority documents (README, CONSTITUTION, the main skill). A lone SKILL.md in the filesystem, even if syntactically perfect, produces zero effect on the "third pillar" claim until those documents are updated. Therefore any architecture claiming "users can contribute skills" must include a mandatory, minimal wiring surface that does not require editing the three core documents for every contribution.

### 6. Irreducible Cost of Namespace Pollution and Cognitive Load

- **Statement**: "Every additional top-level concept or directory that a user must know about to use the harness increases the probability that the user will fail to invoke the correct ritual at the correct time (first-questions before first-principles before universe-grok)."
- **Source**: Direct observation of the current first-questions artifact (the long open-questions section at the end still interrogating .universe-grok/ vs .grok/ structure precisely because "multiple hidden directories" create user confusion). Also the AGENTS.md rule quoted in system context: "기존 아티팩트를 건드리지 않고 새 파일을 하나 더 쌓는 방식" is forbidden. The existence of the first-principles skill file itself, while unmentioned in any user-facing document except its own prose, demonstrates the exact discoverability failure mode.
- **Why this is bedrock**: This is a statement about human working memory and attention economics, not preference. If the architecture adds a fourth thing the user "should" run after the two they already barely remember, the entire truth-seeking harness loses its mandatory character. The goal's "without ... causing activation conflicts" and "minimal" qualifiers are therefore not optional; they are load-bearing for the harness to remain usable.

## Reconstructed Approach (Derived Only From Bedrock + Goal)

- **Core Insight from Bedrock**: The physical unit of contribution is already correct (one directory = one SKILL.md with frontmatter). The missing mechanisms are (1) a load-time uniqueness guard that lives *outside* any individual skill and (2) a contribution contract whose only required edit surface for a new contributor is inside their own skill directory plus one small, append-only registry file that the core documents can reference without being edited on every addition.

- **Minimal Viable Structure**:
  - Keep skills/ as a flat or lightly-namespaced tree of contrib dirs (each containing only SKILL.md + optional supporting files the skill itself owns).
  - Add a single new file at the plugin root: `skills/registry.json` (or `CONTRIBUTED_SKILLS.md` as the human surface). Each entry is the relative path to a skill dir + a hash or last-modified of its SKILL.md frontmatter for collision detection.
  - At the very beginning of universe-grok/SKILL.md (and in the SessionStart hook or a new tiny loader), before any orchestration, execute a deterministic scan: parse every SKILL.md under skills/, collect all slash_command + keywords, fail hard (or warn + deactivate) on any duplicate string across the entire set. This guard is the single point that enforces "no activation conflicts".
  - For human discoverability and wiring: the README and CONSTITUTION name only the *protocol* ("After first-questions, always run first-principles if invention is required; all contributed skills are listed in skills/registry.json and must pass the uniqueness gate"). New skills are advertised solely by their presence in the registry + their own self-description in the frontmatter. No per-skill edits to the three sacred documents.
  - The first-principles skill (and future ones) ships with its own `example-contribution/` or just its own dir as the living demonstration. The act of the verifier (this session) creating the skill is the first test case.

- **What Popular Solutions Get Wrong** (contradicting bedrock):
  - "Just document a convention and let people PR skills" — violates bedrock 5 (wiring cost) and 3 (no enforcement). Leads to the current state where first-principles exists on disk but is invisible to the harness.
  - "Use a package manager / marketplace with remote installs" — violates bedrock 1 (current atomic unit is local dir tree). Introduces new physics (network, auth, versioning) not present in the observed system.
  - "Namespaced subdirectories like skills/contrib/first-principles/" with loader magic — adds cognitive load (bedrock 6) without solving the real conflict problem unless the loader also implements the uniqueness guard.

- **Deliberately Not Built**:
  - Any new top-level command or persona whose name overlaps common words.
  - A separate "skill marketplace" service (would be solution by analogy to VS Code / npm, not derived from the flat-dir + frontmatter physics we actually have).
  - Requiring every skill to edit plugin.toml (direct violation of "without polluting the core").

- **10x Levers** (places where bedrock reasoning produces non-incremental improvement):
  - The uniqueness guard + registry turns "adding a skill" from a high-regret, high-coordination act (current first-principles situation) into a low-friction, self-service act that cannot break the harness. This is the difference between a living ecosystem and a private monolith that occasionally accepts PRs.
  - By making the guard live in the main orchestration path (universe-grok), every future /universe session automatically benefits from the safety property without contributors having to think about it.

## Anti-Theater Log (What We Explicitly Rejected and Why)

- Proposal "Model it after how Claude Code or Cursor skills/extensions are installed" → Rejected: No bedrock fact established that remote distribution, signing, or third-party hosting is fundamental to this problem. The observed system is 100% local filesystem + frontmatter parse. Introducing those would add attack surface and complexity that directly contradicts bedrock 1 and 6.
- Proposal "Add a skills/index.ts that exports a map of all skills" → Rejected: This would be code that must be edited on every contribution, violating the "minimal" and "no core pollution" constraints. The guard must be data-driven from the SKILL.md files themselves.
- "Use the existing create-skill skill from ~/.grok/skills" → Rejected on bedrock 3 and 5: external tool has no knowledge of our uniqueness requirement or our registry; using it would not enforce the invariants we derived as load-bearing.

## Open Questions Requiring Primary Research

1. What is the exact collision-detection algorithm (case sensitivity? substring overlap on keywords? exact string only?) that the guard must implement? (Requires reading the actual Grok Build skill loader source or empirical testing with duplicate frontmatters.)
2. Should the registry be JSON (machine) + a generated human-readable section in README, or a single markdown file that both the loader and humans edit?

## Revisit Log

- 2026-05-18 (this verifier live test): Created as simulation of /first-principles execution on the meta-problem of skill contribution. The Bedrock list above was populated *before* any Reconstructed Approach text was written. The output was then immediately subjected to the skill's own anti-theater rules (see separate verifier critique).

---

**This is a test artifact produced under the verifier protocol to exercise the newly created first-principles skill.**
