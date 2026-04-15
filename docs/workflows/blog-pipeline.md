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
- Voice guide: docs/90-99-content-strategy/strategy-analysis/90.11-voice-guide.md (tone, banned words, structural patterns, self-test checklist)
- Content plan brief: the topic's brief section in the content plan (required sections, vibe coding angle, internal links, CTA)
- Design spec: .stitch/design.md (for cover image later)

STEP 3 — RESEARCH
- Web search for 5+ authoritative sources on the topic (official docs, industry reports, founder forums)
- Check existing blog posts for duplication: ls content/blog/ | grep -iE "<key-terms>"
- Verify every statistic has a citable source — zero fabricated claims

STEP 3b — FIND INTERNAL POSTS TO REFERENCE (MANDATORY)
Before drafting, find 4+ existing JetThoughts posts to link from the new post.
Use claude-context MCP search FIRST:
  Search the codebase at /Users/pftg/dev/jetthoughts.github.io for: "topic keywords relevant to your post"
For tag/slug lookups, read docs/blog-post-index.md (584 posts, 135 tags, process posts table).
NEVER guess slugs — verify each with: ls content/blog/<slug>/index.md
Collect at least 4 verified slugs before starting the draft.

STEP 4 — DRAFT
Create content/blog/<slug>/index.md following these rules:
- Frontmatter: title ≤45 chars, description 150-160 chars, date, slug, keywords, tags, cover_image: cover.png, metatags.image: cover.png
- Voice: plain English, empathy first, founder-to-founder tone, specific data over vague claims
- Structure: punchy hook → primary keyword in first 100 words → numbered H2 sections → vibe coding angle section → "When NOT to" section → JetThoughts proof point → CTA → related reading (2-3 internal links in prose) → further reading (5+ external citations)
- Internal links: weave 4+ links to existing JetThoughts posts naturally in the body (not just footer). Use the slugs verified in Step 3b.
- Paragraphs ≤3 sentences. Word count 1,200-1,800.
- BANNED words: unlock, harness, leverage, dive in, game-changer, journey, seamless, robust, supercharge, revolutionize, embark, delve, discover

STEP 5a — ANTI-AI WRITING PASS (MANDATORY — run BEFORE review loop)
Run /humanizer on the draft. Scan every paragraph for these AI tells:
- Rule of three (parallel triads) — break or combine
- Signposting ("This post is about...", "Here's what you need to know")
- Bold inline-header lists — rewrite as flowing prose
- Negative parallelism ("Not X — it's Y")
- Triple rhetorical questions
- Slogany parallel closings ("X is A. Y is B.")
- Therapist voice ("That's the hardest part")
- Copula avoidance ("serves as" → use "is")
Voice test: read every sentence aloud. Would a tired founder talk like this at a bar?
Reference: docs/90-99-content-strategy/strategy-analysis/90.11-voice-guide.md (banned words, structural patterns)
Reference: docs/90-99-content-strategy/thoughtbot-style-analysis-2025-10-15.md (thoughtbot patterns)
Then run /slop-detector. If flagged, fix and re-run until clean.
Then run /seo-aeo-audit for SEO + AEO compliance. Fix any issues before proceeding.

STEP 5b — REVIEW LOOP (3 parallel critic agents, iterate until pass)

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

## Skills & agents used per step

Skills are invoked via `/skill-name`. Agents are spawned via the Agent tool.

| Step | Skills | Agents / Tools |
|---|---|---|
| 1. Pick topic | — | Read content plan file |
| 2. Read context | — | Read ICP, brief, design spec |
| 3. Research | `/keyword-research`, `/competitor-intel`, `/social-media-trends-research` | `web-research-workflow` agent, WebSearch |
| 4. Draft | `/blog-post`, `/copywriting-core`, `/content-production`, `/copy-editing` | Write tool |
| 5. Review loop | `/slop-detector` → `/humanizer` (if flagged), `/seo-aeo-audit`, `/seo` | 3 parallel critic agents (founder, SEO/slop, editor) |
| 6. Cover image | `/stitch-design` | chrome-devtools MCP, magick CLI |
| 7. Validate | `/hugo` | `bin/hugo-build`, chrome-devtools MCP |
| 8. Update plan | — | Edit tool |
| 9. Commit | `/git-commit` | git CLI |

### Skill descriptions

| Skill | When to use |
|---|---|
| `/slop-detector` | After drafting — detects AI-generated content markers (banned words, parallel structure, filler transitions) |
| `/humanizer` | If slop-detector flags content — removes AI writing patterns while preserving meaning |
| `/seo-aeo-audit` | SEO compliance + AI answer engine optimization (structured data, featured snippets) |
| `/seo` | On-page SEO: title, meta description, keywords, internal links, schema |
| `/blog-post` | Structures long-form blog posts, creates outlines, applies editorial standards |
| `/copywriting-core` | Ogilvy-style clarity + persuasion for CTAs and hooks |
| `/copy-editing` | Systematic editing passes: clarity, voice consistency, grammar |
| `/content-production` | Full content pipeline from blank page to publish-ready piece |
| `/keyword-research` | Research target keywords, analyze competition, find content gaps |
| `/competitor-intel` | Analyze competitor content for the same topic |
| `/social-media-trends-research` | Research trends across Google Trends, Reddit, Indie Hackers |
| `/stitch-design` | Generate or iterate on cover image designs via Stitch MCP |
| `/hugo` | Hugo static site knowledge for build, templates, frontmatter |
| `/git-commit` | Conventional commit messages with emoji |

## 9-phase autonomous pipeline (full reference)

The quick start prompt above is the practical execution guide. Below is the full autonomous pipeline with all coordinator agents, for reference:

1. **Trend Discovery** — `/social-media-trends-research` + `/keyword-research` → ≥5 viable topics
2. **Strategy** — `/content-strategy` + content plan → shareability ≥7/10
3. **Research** — `/competitor-intel` + WebSearch → ≥5 sources, ≥1 expert quote
4. **Ideation** — `/blog-post` + `/copywriting-core` → 3-5 takeaways, compelling hook
5. **Draft & Edit** — `/content-production` + `/copy-editing` → Zero AI phrases, paragraphs ≤3 sentences
6. **Review Loop** — 3 parallel critics (founder persona + SEO/slop + copy editor) → iterate until pass
7. **Cover Image** — `.stitch/design.md` → 6-slot HTML → chrome-devtools 2× render → Lanczos downsample
8. **Validate** — `bin/hugo-build` + Chrome DevTools (zero console errors, zero 404s, og:image resolves)
9. **Publish** — Update content plan → commit → push

## Key files

| File | Purpose |
|---|---|
| `docs/.../20.07-content-plan-icp-e-q2-2026.md` | What to write next + topic briefs |
| `docs/.../90.10-icp-primary-website-target.md` | Who we write for (ICP-E) |
| `docs/.../90.11-voice-guide.md` | **HOW we write** — tone, banned words, structural patterns, self-test |
| `docs/blog-post-index.md` | **Post discovery** — 584 posts by tag, date, and practice category. Use for finding internal links. |
| `.stitch/design.md` | Cover image spec (6-slot layout) |
| `.stitch/designs/*-cover.html` | Cover templates to duplicate |
| `CLAUDE.md` | Behavioral constraints + critical files table |
| `themes/beaver/layouts/partials/seo/enhanced-meta-tags.html` | SEO/og:image template (title truncation rules) |
| `themes/beaver/layouts/partials/seo/article-schema.html` | Article JSON-LD schema |
| `config/_default/hugo.toml` | Hugo config (permalinks, sitemap, baseURL) |
