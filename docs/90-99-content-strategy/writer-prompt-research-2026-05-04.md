# Research Archive: Writer Prompt Improvements (May 2026)

**Date**: 2026-05-04
**Trigger**: Posts B (`tdd-overkill-myth-lightweight-ruby`) and C (`refactor-step-tdd-three-line-discipline-ruby`) both scored 78/100 on the AI-detector agent's first read. Goal: drop first-draft score by >20% (target ≤62/100).
**Outcome shipped**: Options 1 (writer prompt overhaul) and 3 (voice guide updates) — see `docs/workflows/blog-pipeline.md` STEPs 4a/4b/4c/4d and `docs/90-99-content-strategy/strategy-analysis/90.11-voice-guide.md` "Banned structural patterns" table for the implementation.

This file archives the research so the next pipeline-improvement sprint doesn't redo it.

---

## Pattern Audit (Posts B + C, combined 5,046 words)

The drafts had **zero** obvious tells — em dashes, banned words, bold-header lists, and signposting all hit 0. The 78 score came from a subtler failure mode that the existing voice guide didn't name.

**Top 5 residual patterns (the "credentialed lecturer" fingerprint):**

| Pattern | Combined count | Density | Lever applied |
|---|---:|---:|---|
| Mannerism-noun refrain (`discipline`/`cycle`/`pattern`/`canonical`/`workflow`) | 33 | 6.5/1k words | Cap to 3/post combined (voice guide) |
| Round-number authority anchors (Q1 2026, $80K-$200K, 4,000-commit, etc.) | 12 | 2.4/1k | Budget: max 2 per H2 (voice guide + STEP 4b) |
| "every X / never X" generalizations | 19 | 3.8/1k | Replace with specific count (voice guide + STEP 4b) |
| Generalized-actor framing ("the developer", "the team", "most teams") | 10 | 2.0/1k | Force named actor or quoted speech (voice guide + STEP 4b) |
| Definitional cadence ("is the canonical X of Y") | 4+ | — | Ban construction; show story (voice guide + STEP 4b) |

**The fingerprint in plain English:** the writer reads as "credentialed lecturer." Not staccato, not signposting — the obvious tells are absent. What survives is subtler: definitional cadence stamps every concept ("X is the canonical Y"), every claim gets a round-number badge ("Q1 2026 / 4,000-commit / $80K-$200K"), actors are nameless ("the developer"), and a small set of comfort-blanket nouns refrain throughout ("discipline" 12×, "cycle" 15×). The credentials are real; the cadence is not.

The drafts read like a *Refactoring*-textbook chapter ghost-written by someone with real credentials. RLHF-trained models gravitate to this voice because it scored well on instruction-following benchmarks.

---

## Tool Comparison: External AI Detectors (May 2026)

| Detector | API | Pricing | False-positive rate | Long-form (1,500-3,000w) | Verdict |
|---|---|---|---:|---|---|
| **Pangram** | Yes | ~$0.005/scan, enterprise | **~0.004%** (1 in 10k, U. Chicago BFI validated) | Excellent | **Best** — beats humanizers (99.3% on paraphrased) |
| **GPTZero** | Yes | $14.99/mo, API tiered | **0.24%** (own benchmark Dec 2025) | Strong | Cheap, public methodology, "mixed-document" mode 96.5% |
| **Originality.ai** | Yes | $14.95/mo, API ~$0.01/credit | **4.79-5.7%** (Cybernews 2026) | Degrades 28-35% on paraphrased | Skip |
| **Copyleaks** | Yes | Enterprise quote | ~5% (1 in 20) | Good | Used in education; misclassifies non-native English |
| **Sapling** | Yes | $0.025/1k chars | **~35% on polished writing** | Mediocre | Skip — would flag voice-guide-compliant prose |
| **Binoculars** (open-source) | Self-host | Free | 0.7% (Mozilla evaluation) | Best at ~256 tokens | Free CI second opinion |
| **Ghostbuster** (open-source) | Self-host | Free | 99.0 F1 cross-domain | Good | NAACL 2024 |
| **OpenAI classifier** | — | Discontinued Jul 2023 | — | — | Don't use |

**Top 3 to integrate (if Option 2 is later activated):**
1. **Pangram** — lowest FP rate, validated independently, best on humanized content
2. **GPTZero API** — cheap, public methodology (perplexity + burstiness)
3. **Binoculars** (self-hosted) — free CI second opinion that detectors can't collude on

Skip Originality.ai (high FP + weak on paraphrased) and Sapling (35% FP on polished prose).

**Detection features ranked by fixability:**

| Feature | Detectability | Fixability |
|---|---|---|
| Perplexity at scale (token unpredictability across full doc) | Highest | **Hard** — intrinsic to the model unless content has named clients, exact numbers, real quotes |
| Burstiness (variance of sentence length AND per-sentence perplexity) | High | **Easy** — explicit cadence quotas (STEP 4b) |
| N-gram repetition (3-grams+) | High | **Easy** — paraphrase passes |
| Sentence-start variety | Medium | **Easy** — opener cluster monitoring |
| Vocabulary distribution / type-token ratio | Medium | **Easy** — inject domain-specific concrete nouns |
| Stylometric signatures (function-word frequencies, POS distribution) | Medium | Partially fixable |

**Hard to game:** perplexity at scale across a 2,000-word doc. If sentences are individually plausible to a reference LM, the doc reads as AI even when words are varied. Specific incidents, named clients, exact numbers raise perplexity organically.

---

## Prompt-Engineering Interventions (Ranked by Expected Score Drop)

| Rank | Intervention | Expected drop | Implementation |
|---|---|---|---|
| 1 | **In-prompt human reference samples** (3 verbatim, same domain) | -15 to -25 pts | `docs/workflows/blog-writer-reference-samples.md` + STEP 4a |
| 2 | **Burstiness-by-construction constraints** (sentence-length variance per H2) | -8 to -12 pts | STEP 4b cadence quotas |
| 3 | **Two-pass writer** (draft → rewrite-as-different-person) | -6 to -10 pts | STEP 4d |
| 4 | **Verbatim BAD/GOOD pairs** (not abstract bans) | -5 to -8 pts | STEP 4c |
| 5 | **Persona stack** (concrete writer + emotional state + named reader) | -3 to -6 pts | Optional; embedded in writer brief case-by-case |

**Combined expected impact**: 78 → 50-58 (a 25-35% drop), achievable via prompt changes alone before any review-round additions. The reference samples are the load-bearing piece — every paper and practitioner doc converges on the same finding: 3 inline samples of the target voice beat any quantity of abstract bans (SICO, Anthropic multishot docs, Chain-of-Density literature).

**Reference voices selected** (and why):
- **Patrick McKenzie / patio11** (kalzumeus.com / bitsaboutmoney.com) — practitioner anecdotes with named clients, dollar figures, specific systems. Voice: confident, long sentences, drops specifics.
- **thoughtbot blog** (thoughtbot.com/blog) — tested code, opinionated trade-offs. Voice: senior-engineer-explaining-to-peer.
- **Julia Evans / jvns.ca** — debugging stories with timestamps and exact failures. Voice: curious, conversational, "I" and "you" naturally.

**Avoided:**
- Sandi Metz — too aphoristic, hard to imitate without sounding fortune-cookie
- DHH — voice too distinctive, agent will overfit

**Stop doing in current brief:**
1. Stop listing banned words/patterns abstractly. Replace each with one verbatim BAD→GOOD pair.
2. Stop putting voice guide reads as `@references`. Inline the actionable rules.
3. Stop relying on instruction-only prompting. No amount of "don't sound AI" beats one reference sample.
4. Stop single-shot writing. Pass 1 of any instruction-tuned model gravitates to lecturer voice — it's an RLHF artifact, not a prompt failure.

---

## What We Did NOT Ship (Option 2 — deferred)

External-detector integration (Pangram + GPTZero API gates) was researched but not activated. Decision: ship Options 1+3 first, measure actual score drop on the next post, decide on Option 2 based on whether the LLM-judge measurement is now trustworthy. If the LLM judge consistently agrees with Pangram on test posts after Options 1+3, we don't need Pangram. If they disagree, Pangram's calibrated probability becomes ground truth.

**To activate Option 2 later:**
- Add Pangram + GPTZero APIs as Gate A (post-cold-eyes) and Gate B (pre-build)
- Block commit if either flags >50% AI on Gate A; >30% on Gate B
- Cost: ~$0.02/post for Pangram + ~2 hrs integration work
- Value: calibrated truth + auto-block + drift detection across posts

---

## Literature

- **Hans et al. 2024**, "Spotting LLMs With Binoculars" — [arxiv 2401.12070](https://arxiv.org/abs/2401.12070). Cleanest zero-shot detection method.
- **Thai et al. 2025**, "EditLens: Quantifying AI Editing in Text" — [arxiv 2510.03154](https://arxiv.org/html/2510.03154v1). Moves past binary detection to quantify edit magnitude on mixed authorship. Directly relevant since our pipeline IS human-edited LLM output.
- **SICO**, "Large Language Models can be Guided to Evade AI Text Detection" — [arxiv 2305.10847](https://arxiv.org/html/2305.10847v5). Demonstrates that 8 human samples + iterative substitution defeats detectors at $1 of API cost. Naked anti-pattern lists barely move scores.
- **Verma et al. 2024**, "Ghostbuster" — [arxiv 2305.15047](https://arxiv.org/abs/2305.15047) (NAACL 2024). Structured search over weaker-LM features; 99 F1 cross-domain.
- **Anthropic — Multishot prompting docs** — [docs.anthropic.com](https://docs.anthropic.com/en/docs/build-with-claude/prompt-engineering/multishot-prompting). Confirms 3-5 diverse examples yield biggest jump.
- **U. Chicago BFI 2025 study** — empirical comparison of commercial vs OSS detectors. Pangram dominates.
- **GPTZero — perplexity & burstiness methodology** — [gptzero.me/news](https://gptzero.me/news/perplexity-and-burstiness-what-is-it/).

---

## Re-running this research

If a future post still scores >70 after Options 1+3 are in place, re-run the pattern audit (Agent A's methodology) on that draft:

```bash
# Frequency-count helpers (run from repo root):
grep -ic "\bthe discipline\b\|\bthe cycle\b\|\bthe pattern\b\|\bthe canonical\b\|\bthe workflow\b" content/blog/<slug>/index.md  # mannerism-noun refrain
grep -ic "\bevery [a-z]\|never [a-z]\|always [a-z]" content/blog/<slug>/index.md  # generalizations
grep -ic "\bthe developer\b\|\bthe team\b\|\bmost teams\b" content/blog/<slug>/index.md  # generalized actors
grep -Eic "is the (canonical|largest|right|whole|real|first|last|part|version|move|cycle|rule|pattern|reason|kind) (of|that)" content/blog/<slug>/index.md  # definitional cadence
```

Score the post against these counts AND submit to Pangram (when integrated). If both signals agree the post is fine but the LLM judge says >70, the LLM judge's prompt needs refinement.

If both signals say AI but the LLM judge says <70, the LLM judge is missing something — re-run cold-eyes Agent J with the empirical patterns explicitly listed.
