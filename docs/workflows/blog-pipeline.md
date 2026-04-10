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

STEP 5 — AI QUALITY CHECK
Run /slop-detector on the draft. If flagged, run /humanizer. Re-check until clean.
No generic AI language. No unsupported claims. Every number has a citation.

STEP 6 — SEO REVIEW
- Title tag ≤45 chars (theme appends " | JetThoughts Blog")
- Description 150-160 chars with primary keyword
- Primary keyword in first 100 words of body
- 4+ contextual internal links (in prose, not footer lists)
- 5+ external citations in "Further reading"
- H1 is single, matches title
- Slug is explicit, hyphenated, no dots

STEP 7 — COVER IMAGE
Read .stitch/design.md for the canonical 6-slot layout.
Duplicate an existing HTML from .stitch/designs/ (e.g., rails-8-1-active-job-continuations-cover.html).
Change ONLY: title, category, pill, 3 headline lines, 3 chip labels+values, status text.
Render: chrome-devtools new_page → emulate viewport=2400x1260x2 → wait 2s → take_screenshot
Downsample: magick {screenshot} -filter Lanczos -resize 2400x1260 -sampling-factor 4:4:4 -strip -quality 95 content/blog/<slug>/cover.png

STEP 8 — VALIDATE
- bin/hugo-build must pass (zero errors)
- Chrome DevTools: open the post page, verify:
  - Zero console errors
  - Zero 404s in Network tab
  - Title not truncated
  - og:image resolves
  - Cover image renders correctly
  - All internal links work

STEP 9 — UPDATE CONTENT PLAN
Edit docs/projects/2510-seo-content-strategy/20-29-strategy/20.07-content-plan-icp-e-q2-2026.md:
- Change topic status from 🔲 Planned to ✅ Published
- Add commit SHA
- Update changelog

STEP 10 — COMMIT
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
| 5. AI quality | /slop-detector → /humanizer | Clean pass |
| 6. SEO review | Title, desc, keywords, links | All checks pass |
| 7. Cover image | 6-slot HTML → render → PNG | 2400×1260 cover.png exists |
| 8. Validate | Hugo build + Chrome DevTools | Zero errors |
| 9. Update plan | Content plan status → ✅ | Plan file updated |
| 10. Commit | Stage + commit + push | Clean commit |

## Key files

| File | Purpose |
|---|---|
| `docs/.../20.07-content-plan-icp-e-q2-2026.md` | What to write next + topic briefs |
| `docs/.../90.10-icp-primary-website-target.md` | Who we write for |
| `.stitch/design.md` | Cover image spec |
| `.stitch/designs/*-cover.html` | Cover templates to duplicate |
| `CLAUDE.md` | Behavioral constraints |
