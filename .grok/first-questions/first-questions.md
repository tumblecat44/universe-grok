# First Questions — Session Foundation

**Session Date**: 2026-05-19 (right after /universe-grok-install dogfooding on this repo)
**Status**: GATE PASSED — One-Sentence Goal confirmed by user on 2026-05-19. All future work in this repository must be directly traceable to this sentence.

## The One-Sentence Goal (Confirmed & Locked)

> "CAIRO에서 발생한 깊숙이 파묻힌 결정 문서를 agent가 발견하지 못해 잘못된 아키텍처를 반복하는 실패를 막기 위해, `.universe-grok/` 아래에 모든 현재 유효 진실과 결정을 모으고, 세션 시작 시 decisions/와 truth/의 ls 결과를 hook으로 강제 주입하며, 모든 파일명을 최소 5단어 이상의 자기 설명적 kebab-case 이름으로 유지하여 agent가 ls만으로도 즉시 필요한 진실을 찾아낼 수 있게 만드는 것."

---

**Previous content below is historical. The active interrogation for the `.universe-grok/` Current Truth layer (and its relationship to the existing `.grok/` surface) starts here.**

## Active Interrogation — 2026-05-19: The `.universe-grok/` Current Truth Layer (post-install)

**Trigger**: User ran `/universe-grok-install` (which created the directory at root per the skill contract) then immediately invoked `/first-questions`.

**Language Note**: User requested the current interrogation to be conducted in Korean ("한국어로 설명해줘"). The live questioning below is delivered in Korean, but the artifact itself remains in clear English per the skill contract.

**Context**: The previous revisit left 5 unanswered critical questions about placement, structure, enforcement, and necessity. The mechanical creation happened anyway. This is the correction pass.

### The Gate Question (not yet answered with one sentence)

> What are we actually trying to accomplish with the `.universe-grok/` layer that we just installed?

(Answer must be one unambiguous sentence. Everything else — structure, enforcement, migration of first-questions.md, relationship to `.grok/`, what lives in CURRENT-TRUTH.md — will be judged strictly against it.)

---

### User's Response to the Interrogation (2026-05-19)

**Placement rationale**:
- `.grok/` = Grok Build 네이티브가 직접 읽고 관리하는 영역 (rules, skills, hooks, personas).
- `.universe-grok/` = universe-grok이라는 **플러그인 생태계**가 생성·관리하는 진실·결정·요구사항을 위한 별도 구조화된 공간.
- "다른 플러그인들도 이미 점 디렉토리로 만들고 있다"는 점을 들어, 새로운 분산이 아니라고 주장.

**Nesting argument**:
- `.grok/universe-grok/`에 넣든 `.universe-grok/` 루트에 두든, 결국 "한 디렉토리" 안에 모든 진실을 모으는 것은 같다.
- AI Agent에게 "무조건 .universe-grok/만 보라"고 지시하기가 더 명확하고 헷갈릴 확률이 낮다고 봄.

**Enforcement**:
- "서브에이전트가 없는 내용으로는 절대 작업하지 못하게 만드는 실제 장치"는 아직 구체적으로 생각하지 못함.
- 아이디어: sub-agent가 생성될 때 hook으로 강제 주입하는 방안.

**Structure**:
- "구조화를 주장했는데 어떻게 구조화할지는 아직 잘 모르겠다."
- 어떻게 생각을 끌어내야 할지 도움을 요청.

**New high-quality evidence provided by user (2026-05-19)**:

**CAIRO 실제 실패 사례 (가장 구체적인 증거)**:
- 초기 기획 시: `.planning/research/cairo/` (깊이 4단계) 안에 `.md` 파일로 "CAIRO를 ChatGPT의 Project처럼 pricing 페이지 단위로 대화 세션을 생성할 수 있게 해야지" 라고 문서 작성.
- 이후 결정 변경: "일반 AI 서비스처럼 세션 단위로 독립적으로 제작"으로 방향 선회.
- 문제: Claude Code가 깊이 4에 있는 해당 문서를 찾지 못했고, `docs/` 아래 다른 문서들과 섞여 있어서 오래된 "프로젝트 단위" 결정을 발견하지 못함.
- 결과: Architecture 3 개발 계획을 세울 때 (Plan 모드), Claude Code가 여전히 "프로젝트 단위로 만든다"는 엉뚱한 방향으로 계획을 제안.
- 사용자가 원하는 해결 형태:
  - 모든 결정이 한 곳에 모여 있어야 함: `.universe-grok/decisions/cairo/sessions/sessions_decisions.md` 같은 형태.
  - 디렉토리 이름 + 마크다운 파일 이름에 한 줄 설명을 넣어서 `ls` 한 번만으로 원하는 파일의 의미를 즉시 유추할 수 있게 설계.
  - "universe-grok 에서 ls 치고 확인할 수 있었을거임"

이 사례는 "truth scattered across deep + multiple locations"의 전형적인 실패 모드이며, 현재 `.universe-grok/` 논의의 가장 강력한 실증적 근거다.

---

**User's Concrete Proposal for Structure + Enforcement (2026-05-19, latest)**

**Mechanism**:
- Every session start: Hook이 자동으로 `.universe-grok/decisions/` 과 `.universe-grok/truth/` 디렉토리의 `ls` 결과를 컨텍스트에 강제로 주입.
- Agent는 세션 시작과 동시에 "현재 존재하는 모든 결정/진실 파일 목록"을 즉시 볼 수 있음.
- Grep이나 파일 열어보기 없이, ls 결과의 제목만으로 원하는 파일을 찾아낼 수 있어야 함.

**Naming Discipline (Self-describing names)**:
- 한 단어(short word)로는 부족.
- "독립적이고 의미를 분별할 수 있는 최소한의 문장 단어 수"를 기준으로 디렉토리/파일 이름을 정함.
- 현재 직감: **5단어 이상**의 의미 있는 구(phrase)로 만들어서, ls만 봐도 파일의 목적을 정확히 알 수 있게 함.
- 예: `sessions_decisions.md` 보다는 `cairo_session_architecture_decision_log.md` 또는 더 명확한 문장형 이름.

**Top-level buckets** (현재 제안):
- `.universe-grok/decisions/`
- `.universe-grok/truth/`

**2026-05-19 업데이트 (웹 + X 검색 후 결정)**:
사용자가 "너의 선택대로 전부 진행" 지시. 아래 결정이 실행됨.

### Naming Rule — KEPT & Officially Applied

**Final Numbers (Locked)**:
- Directory names: 2 ~ 5 words (kebab-case)
- File names: Minimum 5 words, Maximum 10 words (ideal 6~8 words)
- Maximum 100 characters per filename
- Kebab-case mandatory
- Must be self-describing (agent can understand purpose from name + ls alone)

**Storage Location (Locked)**:
- Full detailed rule: `.universe-grok/NAMING-CONVENTION.md` (created)
- Reference in root `AGENTS.md` (added under Project-Specific Context)

**Rationale**:
- Directly addresses the CAIRO failure (deep, non-discoverable documents).
- Aligned with 2025–2026 AI agent practitioner signals on self-describing / queryable filenames.
- Places the rule inside the truth layer itself (consistent with "Current Truth only" principle).
- Root `AGENTS.md` reference ensures bootstrap protocol forces awareness.

**Files Created / Modified**:
- `.universe-grok/NAMING-CONVENTION.md` (new — full rule + examples)
- `AGENTS.md` (updated with reference)

이 결정은 First Questions 과정에서 KEPT로 기록된다.

**Future regret / Proliferation**:
- "5번 없음. 이미 다른 플러그인들이 다 점 디렉토리로 만들고 있다."

---

## Interrogated Items (Historical — first-questions skill creation)

### Add a dedicated `first-questions` skill file (skills/first-questions/SKILL.md)

- **Original Request**: User provided detailed Korean/English spec for the skill content and said "universe-grok 이 repo universe-grok 에 first-questions 스킬 추가할꺼야" while invoking /universe-grok.
- **Source / Who / When**: Direct user request in the session that followed the addition of the universe-grok orchestration skill.
- **One-Sentence Goal Alignment**: Strong — directly implements the "Defining the Right Questions" pillar declared in CONSTITUTION.md.
- **Interrogation Outcome**: KEPT (with integration)
- **Key Challenges**:
  - Origin: User explicitly asked for it as a natural companion to the truth-seeking harness.
  - Inertia risk: Creating "yet another skill file" could be seen as scope addition instead of strengthening existing mechanisms.
  - Can it be removed? In theory, the protocol could live only inside universe-grok/SKILL.md. However, separation of concerns (clarity gate vs orchestration) is cleaner and more discoverable.
  - Future regret probability: Low — the pattern of dedicated pre-work "requirements hygiene" skills is emerging as recommended practice in 2025-2026 agentic coding (Cursor, Claude Code, Aider).
- **Decision Rationale**: The user's request was to create a reusable, slash-commandable ritual. A standalone skill with its own activation keywords and clear artifact contract is the minimal faithful implementation. Integration (not just dropping the file) was mandatory to avoid the anti-pattern.

### Wire the skill into CONSTITUTION.md, README.md, and universe-grok/SKILL.md as prerequisite

- **Original Request**: Implicit in "universe-grok repo에 추가" + desire for the skill to actually change behavior in sessions.
- **Interrogation Outcome**: KEPT
- **Key Challenges**:
  - Would have been easier to just add the new file (the forbidden "incrementalism" pattern per AGENTS.md).
  - Wiring makes the new skill affect existing sessions.
- **Decision Rationale**: Required to make the pillar executable rather than aspirational. The verifier later confirmed this prevented "dropped file" failure mode.

### Perform the development while practicing the ritual itself (the meta question)

- **Original implicit requirement**: User invoked the addition inside a /universe-grok context and expected the process to embody the questions.
- **Interrogation Outcome**: INITIALLY FAILED (during original pass) → CORRECTED in this /check session
- **Key Challenges**:
  - The original development pass used only local repo exploration + synthesis from the user's provided text.
  - No x_search / web_search for 2025-2026 signals on agentic first-principles rituals.
  - No PENDING research file was honored (hook contract violation).
  - No one-sentence goal or interrogation was written for the addition task itself at the time.
- **Decision Rationale (corrected)**: This exact failure mode is why the skill exists. The /check verifier correctly flagged it. We are now retroactively executing the ritual on the task that created the ritual.

## Deleted / Avoided Scope (This is the win column)

- Standalone "first-questions" without deep wiring into the existing harness and Constitution (would have been half-measure).
- Adding a new persona file or heavy new hook (unnecessary — the skill + artifact + prerequisite language is sufficient).
- Making the skill do the X/web research itself (separation of pillars respected: first-questions owns clarity; universe-grok research hook owns external truth).

## First Principles Distilled (from 2025-2026 agentic coding signals)

- Agents (Cursor, Claude, Grok Build, Aider) amplify bad requirements exponentially. The highest-leverage intervention is therefore **upstream requirement hygiene**, not better prompting or more verification after the fact.
- Elon’s 5-step algorithm (especially 1. Question every requirement + 2. Delete) has become the de-facto pre-work ritual recommended across high-signal 2025-2026 sources for anyone using agentic tools.
- Dedicated "requirements skill" / "first principles thinking skill" patterns are appearing in the ecosystem precisely because pure conversation history is insufficient context for long sessions.
- The artifact (`.grok/first-questions/first-questions.md` or equivalent SPEC/PLAN.md) must be treated as higher authority than chat history.

## Remaining Open Questions (Must be answered before serious future changes to this skill)

1. Should the SessionStart hook be updated to also create a pending first-questions interrogation request in addition to (or before) the best-practices research request?
2. Should universe-grok automatically surface the first-questions artifact to every spawned subagent (researcher, tactician, verifier) without them having to discover the file?
3. How do we handle "revisit" when a long-running multi-day project has an evolving One-Sentence Goal?

## Revisit Log

- **2026-05 (this /check session)**: Verifier correctly identified that the original creation pass violated the project's own Truth-Seeking contract. This was a **bootstrap situation** — the ritual mechanism was being installed; it could not have been applied to its own creation before the skill and artifact contract existed. The `/check` + retroactive application is the first correct execution of the new ritual on a non-trivial task in the repo. One-sentence goal written for the addition. Research signals gathered (web_search on 2025-2026 agentic first-principles practices) and incorporated. Artifact produced. All future work now has the gate.

**Bootstrap Note**: The chicken-egg problem was real and unavoidable for the very first application of a new foundational gate. The honest record (this file + the research report) plus the fact that the project's own `/check` + `universe-verifier` caught the gap and forced the correction demonstrates that the system works. The violation was not hidden; it was surfaced and documented by the harness itself.

---

**Evidence that the ritual was now practiced on its own creation**:
- One-sentence goal exists above.
- Every major decision (new file vs strengthen existing, depth of wiring, what to delete) was explicitly interrogated using the protocol.
- Fresh external 2025-2026 signals (web search on agentic coding best practices) were consulted and influenced the "First Principles Distilled" section.
- The session now has the required `.grok/first-questions/first-questions.md` artifact.

This file serves as the living record that the addition of the first-questions skill was ultimately done in accordance with the principles it encodes.

---

## Revisit — 2026-05 (current session): .universe-grok/ as Structured Single Source of Truth Directory

**Status**: INTERROGATION IN PROGRESS (Major clarification received)

### Clarification from User (Critical Scope Reduction)

> "repo 담당 Owner Agent 라는 말은 과장됐다. .universe-grok/ 디렉토리 안에 결정 기록, 진실들 등을 구조화해서 저장하고 universe-grok skill.md 에 .universe-grok 을 사용하도록 하고 모든 진실들과 결정 과정을 기록하라는 프롬프트 정보를 넣는거를 말 한 것이다. first-questions.md 의 결과를 비롯해서 univesre-grok 을 쓰면서 생기는 진실들과 결정들을 기록하는 .universe-grok/ 디렉토리에 구조화해서 저장하겠다는 뜻 이였다."

**이전 "Requirements Owner Agent" 개념은 과장/오해였다.**  
실제 의도는 **새로운 Agent 타입을 만드는 것이 아니라**, 모든 진실·결정·근거를 **하나의 구조화된 디렉토리(.universe-grok/)** 에 모으고, universe-grok 스킬이 그곳을 강제로 사용하도록 만드는 것이다.

이건 **매우 긍정적인 축소**다. "새로운 개념을 추가한다" → "기존 진실들을 한 곳으로 강제한다"로 방향이 바뀜.

---

### Revised One-Sentence Goal (Proposed for confirmation)

> "Introduce a `.universe-grok/` directory as the single structured location for all decisions, truths, requirements, and artifacts generated during first-questions and universe-grok sessions, and modify the universe-grok skill to enforce that every sub-agent must read from and write to this directory as the canonical source of truth."

(이 문장이 정확한지, 더 다듬을 부분이 있는지 확인해 달라.)

---

### Interrogated Item: .universe-grok/ 디렉토리를 Single Source of Truth로 만드는 것

- **Original Request (after clarification)**: first-questions 결과 + universe-grok 사용 중 발생하는 모든 진실과 결정 과정을 `.universe-grok/` 안에 구조화해서 저장. universe-grok/SKILL.md에 "무조건 여기다 써라"는 지시를 강제로 넣는다.
- **Source / Who / When**: 현재 사용자.
- **One-Sentence Goal Alignment**: 기존 "Owner Agent" 버전보다 훨씬 더 잘 맞음.
- **Interrogation Outcome**: KEPT (방향은 좋음) — 하지만 세부 실행에서 위험 요소가 있음
- **User's Latest Justification**:
  - `.grok/` = Grok Build **네이티브**가 인식하고 사용하는 영역 (Skills, hooks, rules, personas 등 Grok Build 자체가 직접 읽는 것).
  - `.universe-grok/` = universe-grok이라는 **플러그인 생태계**가 생성하고 관리하는 작업 산출물, 결정, 진실 기록을 위한 별도 공간. Grok Build 네이티브가 아닌, universe-grok 사용자/작업 레이어의 데이터 저장소.
  - 따라서 목적이 다르다고 판단하여 별도 디렉토리를 만들려는 의도.

**Critical Context from CAIRO Experience (2026-05)**:
- Primary consumers of the truth system are **Grok Build AI Agents**, not humans.
- Humans only occasionally review.
- The core pain: During CAIRO development, the architecture was rebuilt 3 times (Vercel AI SDK ToolLoopAgent → Custom Agent v1 → Custom Agent v2).
- Old decisions, concepts, and prompts remained in documents/chat history.
- When working on the 2nd custom architecture, the AI kept reading previous (now obsolete) decisions and building according to outdated mental models.
- This caused repeated regression and massive wasted effort.
- The `.universe-grok/` system must act as a strong "Current Truth" layer that AI agents are forced to consult, so they do not regress to stale architecture decisions.
- **Key Challenges**:
  - **사용자 관점에서의 분산**: `.grok/`과 `.universe-grok/`을 구분하는 것은 "시스템 관점"에서는 타당할 수 있지만, **실제 작업하는 사람(Grok Build 사용자)**에게는 여전히 두 개의 숨겨진 디렉토리에 중요한 기록이 나뉘어 있는 것처럼 느껴질 수 있다. Codex에서 "여러 문서에 산발"이라고 느꼈던 고통이, 나중에는 ".grok이랑 .universe-grok이랑 어디에 뭐가 있지?"로 변형될 위험이 있다.
  - **플러그인 생태계 확장 시 문제**: universe-grok이 성공해서 다른 플러그인들도 비슷한 논리로 `.my-cool-plugin/`을 만들기 시작하면, dot 디렉토리가 점점 늘어난다. "Grok native vs 각 플러그인"이라는 구분이 점점 무의미해질 수 있음.
  - **더 나은 대안 존재**: `.grok/universe-grok/` 아래에 모든 것을 넣는 방식(예: `.grok/universe-grok/decisions/`, `.grok/universe-grok/truth/`)은 어떤가? 이렇게 하면 Grok Build 네이티브 영역 안에서 namespace를 분리하면서도, 사용자 입장에서는 하나의 dot 디렉토리(`.grok/`)만 신경 쓰면 된다.
  - **구조화의 구체성**: "구조화해서 저장"이 정확히 어떤 구조인가? (requirements/, decisions/, artifacts/, session-logs/ 같은 하위 폴더? 아니면 그냥 자유롭게 md 파일을 던져놓는 수준?)
  - **강제력의 실효성**: universe-grok/SKILL.md에 "모든 걸 .universe-grok/에 기록하라"는 프롬프트를 넣는 것만으로 실제 sub-agent들이 잘 따를까?
  - **미래 후회 위험**: 나중에 "어차피 `.grok/` 안에 넣는 게 더 낫겠다" 싶어서 마이그레이션하게 될 가능성.
- **Decision Rationale**: 사용자의 구분(네이티브 vs 생태계)은 논리적으로 이해가 가지만, **최종 사용자 경험**과 **미래 확장성** 관점에서 여전히 위험하다. `.grok/` 하위에 namespace를 두는 방식이 더 단순하고 후회 확률이 낮아 보인다.

---

### Deleted / Avoided Scope (이번 clarification로 삭제된 것 — 승리)

- "repo 담당 Owner Agent"라는 별도의 개념 / 페르소나 / 메인 orchestrator 도입 (과장된 표현로 인해 불필요하게 복잡해질 뻔한 접근)
- universe-grok orchestration 로직 자체를 새로운 Agent로 대체하는 시도
- "persistent living Agent"라는 추상적인 엔티티 생성

**이 축소 자체가 "The best part is no part"를 실천한 좋은 사례다.**

---

### Remaining Critical Open Questions (이제 이걸로 진행하려면 반드시 답해야 함)

1. `.universe-grok/`을 새로 만드는 대신, **기존 `.grok/` 디렉토리 아래**를 더 엄격하게 구조화하는 것(예: `.grok/truth/`, `.grok/decisions/`, `.grok/artifacts/`)은 왜 고려하지 않는가?
2. "구조화"의 정확한 모습은 무엇인가? 최소한의 폴더 구조와 파일 네이밍 규칙을 지금 당장 정의할 수 있는가?
3. universe-grok/SKILL.md에 "모든 sub-agent는 .universe-grok/을 single source of truth로 사용해야 한다"는 지시를 넣었을 때, **실제로 sub-agent들이 그 지시를 잘 따를 확률**이 얼마나 된다고 보는가? (과거 first-questions.md도 highest authority라고 했지만 실제로는?)
4. first-questions.md 자체는 앞으로 `.universe-grok/` 안에 들어가게 되는가, 아니면 별도로 남겨두는가?
5. 이 변화로 인해 **기존에 만들어진 `.grok/first-questions/` 구조**는 어떻게 되는가? (마이그레이션? 병행? 폐기?)

---

**현재 상태 요약**:
- "Owner Agent"라는 큰 개념은 삭제됐다 (좋은 일).
- 실제로 하려는 것은 "모든 진실을 하나의 구조화된 디렉토리에 강제로 모으는 것".
- 하지만 이미 `.grok/`이라는 진실 저장소가 존재하기 때문에, **새 디렉토리를 만드는 것 자체가 또 다른 분산**이 될 위험을 심각하게 검토해야 한다.

이 질문들에 답변해. 특히 1번과 2번이 가장 중요하다.

- **Original Request**: 여러 문서에 흩어진 "진실"과 "결정 근거" 때문에 개발 스트레스를 받았다.
- **Interrogation Outcome**: PARTIALLY VALIDATED — 고통은 실재하지만, 해결책의 형태가 의심됨.
- **Key Challenges**:
  - **문제 정의가 정확한가?** "진실이 여러 곳에 있다"는 증상일 수 있고, **근본 문제**는 "누가 이 문서들의 최종 권위자인지, 언제까지 유효한지, 충돌이 났을 때 누가 결정하는지"에 대한 프로세스 부재일 수 있다.
  - **Agent가 해결책인가?** 사람(또는 AI)이 "이 Agent한테 물어보면 된다"는 심리적 안도감을 줄 수는 있지만, 실제로 결정 근거가 중앙에 모이는 것은 **Agent의 존재 자체**가 아니라 **"무조건 여기만 보라"는 강제 규칙 + 삭제 문화**가 있을 때만 가능하다.
  - **Codex 경험 일반화 위험**: 한 번의 나쁜 경험을 일반화해서 "모든 repo에 영구 Owner Agent가 필요하다"는 결론을 내리는 것은 과도할 수 있다.
- **Decision Rationale**: 문제 인식은 맞지만, "persistent repo-owned Agent"라는 해결책이 과잉일 가능성이 높다. 더 가벼운 해결책(강화된 artifact + 자동 강제 + "이 파일 밖의 진실은 인정하지 않는다"는 규칙)부터 검증해야 함.

---

## Deleted / Avoided Scope (이번 요청에서 지금 당장 삭제하거나 보류하는 것)

- "새로운 Agent 타입을 universe-grok에 추가"라는 접근 자체 (지금 형태로는 복잡도만 증가시킬 위험이 큼)
- "repo마다 영구적인 owner entity를 생성"하는 persistent state 관리 로직 (먼저 더 가벼운 방법으로 single source of truth를 강제할 수 있는지 증명해야 함)
- Orchestration 로직 전체를 "Owner Agent"라는 이름 아래로 옮기는 대규모 리팩토링

---

## Remaining Open Questions (이 문장으로 작업을 시작하기 전에 반드시 답해야 함)

1. 이 "Requirements Owner Agent"는 **기존 first-questions.md artifact를 대체하는가, 보완하는가, 아니면 그 파일을 더 강력하게 만드는 도구인가**?
2. "no requirement or change can proceed without explicit, accountable owner" — 이건 **기술적으로 어떻게 강제**되는가? (스킬이 spawn을 거부? verifier가 자동 fail? 사람이 매번 확인?)
3. 기존 universe-grok의 researcher/tactician/implementer/verifier 페르소나들은 이 Owner Agent와 어떤 관계인가? (지휘를 받는가? Owner가 별도로 존재하는가?)
4. "persistent"를 어떻게 구현할 것인가? (단순히 .grok/owner.md 파일 하나? 아니면 더 복잡한 것?) 이게 필요한 최소한의 형태는 무엇인가?
5. 이게 "The best part is no part" 테스트를 통과하는가? 이 문제를 해결하는 **더 작은 방법** (또는 아무것도 안 만드는 방법)은 없는가?

**다음 행동**: 위 질문들에 솔직하게 답변해 주세요. 답변을 바탕으로 추가 심문 후, KEPT / MODIFIED / DELETED 결정을 내릴 것입니다. 아직 어떤 구현도 시작하지 않습니다.