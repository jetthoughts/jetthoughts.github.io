---
{}
---

# Blog Post Pipeline — Trigger Prompt
#
# Copy this prompt to write the next blog post from the content plan.
# Full pipeline: docs/workflows/blog-pipeline.md
#
# This is a reusable PROMPT — APM compiles it to slash-commands for
# each AI tool (e.g., /blog-post in Claude, #blog-post in Copilot).

Write the next blog post following the full pipeline.

## STEP 1 — Pick Topic
Read the content plan: docs/projects/2510-seo-content-strategy/20-29-strategy/20.07-content-plan-icp-e-q2-2026.md
Find the next 🔲 Planned topic. Confirm slug, primary keyword, target publish date.

## STEP 2 — Read Context (mandatory, do not skip)
- ICP: docs/90-99-content-strategy/strategy-analysis/90.10-icp-primary-website-target.md
- Voice guide: docs/90-99-content-strategy/strategy-analysis/90.11-voice-guide.md
- Content plan brief: read the topic's brief section
- Design spec: .stitch/design.md

## STEP 3 — Research
- Web search for 5+ authoritative sources
- Check existing posts for duplication: ls content/blog/ | grep -iE "<key-terms>"
- Verify every statistic has a citable source

## STEP 3b — Find Internal Posts to Reference
- Use claude-context MCP search FIRST
- For tag/slug lookups: docs/blog-post-index.md
- Verify each slug: ls content/blog/<slug>/index.md
- Collect at least 4 verified slugs before drafting

## STEP 4 — Draft
Create content/blog/<slug>/index.md with:
- Frontmatter: title ≤45 chars, description 150-160 chars, date, slug, keywords, tags
- Voice: plain English, empathy first, founder-to-founder tone
- Structure: punchy hook → keyword in first 100 words → numbered H2s → "When NOT to" → JT proof → CTA → related reading → further reading
- 4+ internal links in body, 5+ external citations
- Paragraphs ≤3 sentences
- Cut test: "what does the reader DO differently?" — delete if answer is "nothing new"

## STEP 5 — Review Loop
Spawn 3 parallel critic agents:
1. Founder persona (Alex, burned CEO) — ≥8/10
2. SEO/slop detector — ≥8/10 humanization
3. Senior copy editor — "publish as-is" or "minor edits"

## STEP 5c — Cold-Eyes Gate (mandatory)
Spawn fresh-context reviewer with 9 explicit checks:
1. Frontmatter vs body consistency
2. Fluffy AI narration detection
3. Fake authority stamps
4. Timeline fabrication
5. "Not X but Y" patterns
6. Em dashes → hyphens
7. Rule-of-three modifiers
8. Cross-section template repetition
9. Impersonal fragment stacking

## STEP 6 — Cover Image
- Read .stitch/design.md (6-slot layout)
- Duplicate existing HTML from .stitch/designs/
- Render: chrome-devtools → viewport 2400×1260×2 → screenshot
- Downsample: magick → 2400×1260 → content/blog/<slug>/cover.png

## STEP 7 — Validate
- bin/hugo-build must pass (zero errors)
- Chrome DevTools: zero console errors, zero 404s, og:image resolves

## STEP 8 — Update Content Plan
- Change topic status: 🔲 Planned → ✅ Published
- Add commit SHA + changelog

## STEP 9 — Commit
- Stage: post directory + cover HTML + content plan update
- Commit format: feat(content): add <topic> post