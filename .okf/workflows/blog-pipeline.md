---
type: Playbook
title: Blog Post Pipeline (Idea to Published)
description: Canonical end-to-end workflow for drafting, reviewing, and publishing a JetThoughts blog post — mandatory for any write/draft/schedule/publish request.
resource: docs/workflows/blog-pipeline.md
tags: [content, blog, workflow]
timestamp: 2026-07-12T00:00:00Z
---

# Overview

`docs/workflows/blog-pipeline.md` is the canonical, mandatory workflow
whenever asked to write, draft, schedule, or publish a blog post — it
must be executed end-to-end, even for `draft: true` posts (so the post
is publish-ready when flipped to `false`).

# Steps

1. **Pick topic** — from the active content plan
   (`docs/projects/2510-seo-content-strategy/20-29-strategy/20.07-content-plan-icp-e-q2-2026.md`),
   next 🔲 Planned topic.
2. **Read context (mandatory)** — [icp](/content-strategy/icp-primary-website-target.md),
   [voice-guide](/content-strategy/voice-guide.md), the topic's content-plan
   brief, and `.stitch/design.md` for the cover image.
3. **Research** — 5+ authoritative sources; check `content/blog/` for
   duplication; every statistic needs a citable source.
4. **Find internal posts to reference (mandatory)** — 4+ verified
   internal links via claude-context MCP search, cross-checked against
   `docs/blog-post-index.md` (584 posts, 135 tags). Never guess slugs —
   verify with `ls content/blog/<slug>/index.md`.
5. **Draft** — `content/blog/<slug>/index.md`, frontmatter constraints
   (title ≤45 chars, description 150-160 chars, `cover_image: cover.png`),
   structure: hook → primary keyword in first 100 words → numbered H2s →
   vibe-coding angle → "when NOT to" → JetThoughts proof point → CTA →
   related reading → 5+ external citations.
6. Cover image generation, SEO validation, `bin/hugo-build`, and the
   [visual-scroll-gate](/workflows/visual-scroll-gate.md) all run before
   the post is considered done — the pipeline does not stop after the
   draft step.

# Zero-tolerance AI patterns

Rejected on sight: rule of three, signposting, bold inline-header
lists, negative parallelism, triple rhetorical questions, slogany
closings, therapist voice, staccato fragment stacking, noun stacking
without a human subject, telling instead of showing, apologetic
caveats, fabricated timelines/stats. Full list + fixes in the
[voice-guide](/content-strategy/voice-guide.md).

# Cross-post repetition gates (blocking for cluster posts)

Before finalizing a post in a topic cluster: (1) **anecdote scan** — no
sibling post may reuse the same named client/incident/dollar figure;
(2) **proof-signal scan** — each post's primary diagnostic signal
(staging URL, test coverage, commit size, secrets storage, rollback
drill, user-impact verification, contract clauses) must be distinct
from its siblings'.

# Citations

[1] `docs/workflows/blog-pipeline.md`
[2] `docs/blog-post-index.md`
