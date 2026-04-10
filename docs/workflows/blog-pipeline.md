# Blog Pipeline — From Idea to Published Post

## Quick start prompt

Copy this prompt to write the next post:

```
Write the next blog post following the full pipeline.

STEP 1 — PICK TOPIC
Read the content plan: docs/projects/2510-seo-content-strategy/20-29-strategy/20.07-content-plan-icp-e-q2-2026.md
Find the next 🔲 Planned topic. Confirm the slug, primary keyword, and target publish date.

STEP 2 — READ CONTEXT (mandatory, do not skip)
Read these 3 files before writing anything:
- ICP: docs/90-99-content-strategy/strategy-analysis/90.10-icp-primary-website-target.md
- Content plan brief: the topic's brief section in the content plan (required sections, vibe coding angle, internal links, CTA)
- Design spec: .stitch/design.md (for cover image later)

STEP 3 — RESEARCH
- Web search for 5+ authoritative sources on the topic (official docs, industry reports, founder forums)
- Check existing blog posts for duplication: ls content/blog/ | grep -iE "<key-terms>"
- Verify every statistic has a citable source — zero fabricated claims

STEP 4 — DRAFT
Create content/blog/<slug>/index.md following these rules:
- Frontmatter: title ≤45 chars, description 150-160 chars, date, slug, keywords, tags, cover_image: cover.png, metatags.image: cover.png
- Voice: plain English, empathy first, founder-to-founder tone, specific data over vague claims
- Structure: punchy hook → primary keyword in first 100 words → numbered H2 sections → vibe coding angle section → "When NOT to" section → JetThoughts proof point → CTA → related reading (2-3 internal links in prose) → further reading (5+ external citations)
- Paragraphs ≤3 sentences. Word count 1,200-1,800.
- BANNED words: unlock, harness, leverage, dive in, game-changer, journey, seamless, robust, supercharge, revolutionize, embark, delve, discover

STEP 5 — REVIEW LOOP (3 parallel critic agents, iterate until pass)

Spawn 3 critic agents in parallel:

Agent 1 — ICP-E FOUNDER PERSONA:
"You are Alex, a 38-year-old non-technical founder. You raised $800K, hired a dev shop,
they missed 4 deadlines and your app crashes daily. Review the post at
content/blog/<slug>/index.md AS THIS PERSONA. Score 1-10 on: human feel, hook strength,
language accessibility, action concreteness, author trust, CTA appeal. Flag any jargon
a non-technical founder would stumble on. Would you contact JetThoughts after reading? Why/why not?"

Agent 2 — SEO + AI SLOP DETECTOR:
"Review content/blog/<slug>/index.md. Part 1: Go paragraph by paragraph, rate AI probability
0-100% for each, flag any >30% with rewrite suggestion. Watch for: parallel structure,
filler transitions, hedging, performative empathy, sentences that say nothing specific.
Part 2: SEO checklist — title ≤45, desc 150-160, keyword in first 100 words, 4+ internal
links, 5+ external citations, no keyword stuffing. Part 3: Humanization score 1-10, list
TOP 5 sentences needing rewrite."

Agent 3 — SENIOR COPY EDITOR:
"You are a senior copy editor at a YC-backed content studio. Review content/blog/<slug>/index.md.
Check: voice consistency (founder-to-founder vs vendor-to-prospect), 10 weakest sentences
with rewrites, structure for mobile scanning, emotional resonance (understood vs lectured),
CTA positioning. Verdict: publish as-is / minor edits / major rewrite. The ONE change that
would most improve the post."

After all 3 complete, synthesize findings and apply fixes. Iterate until:
- Founder persona scores ≥8/10
- SEO/slop humanization score ≥8/10
- Copy editor says "publish as-is" or "minor edits only"

STEP 6 — COVER IMAGE
Read .stitch/design.md for the canonical 6-slot layout.
Duplicate an existing HTML from .stitch/designs/ (e.g., rails-8-1-active-job-continuations-cover.html).
Change ONLY: title, category, pill, 3 headline lines, 3 chip labels+values, status text.
Render: chrome-devtools new_page → emulate viewport=2400x1260x2 → wait 2s → take_screenshot
Downsample: magick {screenshot} -filter Lanczos -resize 2400x1260 -sampling-factor 4:4:4 -strip -quality 95 content/blog/<slug>/cover.png

STEP 7 — VALIDATE
- bin/hugo-build must pass (zero errors)
- Chrome DevTools: open the post page, verify:
  - Zero console errors
  - Zero 404s in Network tab
  - Title not truncated
  - og:image resolves
  - Cover image renders correctly
  - All internal links work

STEP 8 — UPDATE CONTENT PLAN
Edit docs/projects/2510-seo-content-strategy/20-29-strategy/20.07-content-plan-icp-e-q2-2026.md:
- Change topic status from 🔲 Planned to ✅ Published
- Add commit SHA
- Update changelog

STEP 9 — COMMIT
Stage: the post directory + cover HTML + content plan update
Commit message format:
  feat(content): add <short topic> post
  
  <1-2 sentences>. SEO: title N chars, description N chars, N internal links,
  N external citations. Primary keyword in first 100 words.
```

## Pipeline phases (reference)

| Phase | What | Gate |
|---|---|---|
| 1. Pick topic | Content plan → next 🔲 Planned | Topic confirmed, no duplication |
| 2. Read context | ICP + brief + design spec | All 3 read |
| 3. Research | 5+ sources, verify stats | Zero fabricated claims |
| 4. Draft | index.md with frontmatter | Voice guide followed |
| 5. Review loop | 3 parallel critics → fix → iterate | Founder ≥8, SEO ≥8, Editor "publish" |
| 6. Cover image | 6-slot HTML → render → PNG | 2400×1260 cover.png exists |
| 7. Validate | Hugo build + Chrome DevTools | Zero errors |
| 8. Update plan | Content plan status → ✅ | Plan file updated |
| 9. Commit | Stage + commit + push | Clean commit |

## Review loop detail

The review loop (step 5) is the quality gate. It runs AFTER the draft and BEFORE the cover image.

```
Draft → spawn 3 critics in parallel → synthesize → fix → re-check
         ↑                                                    ↓
         └────────────── iterate if scores < 8/10 ───────────┘
```

**3 critic personas:**

| Critic | Persona | Focus | Pass threshold |
|---|---|---|---|
| Founder | Alex, burned non-technical CEO | Does this resonate? Would I call? | ≥8/10 |
| SEO/Slop | AI content detector + SEO auditor | Paragraph-by-paragraph AI probability, SEO compliance | ≥8/10 humanization |
| Editor | Senior copy editor (YC/Indie Hackers quality) | Voice, sentence-level rewrites, structure, CTA | "Publish" or "minor edits" |

**What each critic checks:**

| Check | Founder | SEO/Slop | Editor |
|---|---|---|---|
| Hook grabs attention | ✓ | | ✓ |
| No jargon | ✓ | | |
| Action items concrete | ✓ | | |
| No AI-sounding sentences | | ✓ | ✓ |
| No parallel template structure | | ✓ | |
| Primary keyword in first 100 words | | ✓ | |
| Internal/external links | | ✓ | |
| Voice consistency | | | ✓ |
| Weakest sentences rewritten | | | ✓ |
| CTA positioned well | ✓ | | ✓ |
| Emotional resonance | ✓ | | ✓ |
| Real story / "been there" energy | ✓ | | ✓ |

## Key files

| File | Purpose |
|---|---|
| `docs/.../20.07-content-plan-icp-e-q2-2026.md` | What to write next + topic briefs |
| `docs/.../90.10-icp-primary-website-target.md` | Who we write for |
| `.stitch/design.md` | Cover image spec |
| `.stitch/designs/*-cover.html` | Cover templates to duplicate |
| `CLAUDE.md` | Behavioral constraints |
