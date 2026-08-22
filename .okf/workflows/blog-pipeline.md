---
type: Playbook
title: Blog Post Pipeline (Idea to Published)
description: Canonical end-to-end workflow for drafting, reviewing, and publishing a JetThoughts blog post — mandatory for any write/draft/schedule/publish request.
resource: docs/workflows/blog-pipeline.md
tags: [content, blog, workflow]
timestamp: 2026-08-20T00:00:00Z
generated:
  by: process:okf-migrate
  at: 2026-07-19T00:00:00Z
verified:
  - by: claude/opus-5
    at: 2026-08-20T00:00:00Z
---

# Overview

`docs/workflows/blog-pipeline.md` is the canonical, mandatory workflow
whenever asked to write, draft, schedule, or publish a blog post — it
must be executed end-to-end, even for `draft: true` posts (so the post
is publish-ready when flipped to `false`).

# Steps

Steps 1-4 are owned by the `/blog-next` skill (`.claude/skills/blog-next/`),
which adds the premise audit and an outline gate before any prose exists, then
hands off to `blog-post-coordinator` / `blog-batch-orchestrator`. Running them
inline is the fallback, not the default.

1. **Pick topic** — from §13 of
   `docs/projects/2510-seo-content-strategy/20-29-strategy/20.09-content-plan-revision-aug-2026.md`,
   audited against live GSC/GA4 first: plans decay between grooming and
   drafting. (§12's R-queue is retired; 20.08 is superseded as a schedule.)
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
   (title ≤60 chars for Google SERP display, description 150-160 chars, `cover_image: cover.png`),
   structure: hook → primary keyword in first 100 words → numbered H2s →
   vibe-coding angle → "when NOT to" → JetThoughts proof point → CTA →
   related reading → 5+ external citations.
5b. **Self-critique (BLOCKING)** — `reflexion-reflect` on the draft before the
   critic panel (STEP 4e), escalating to `reflexion-critique` after pushback on
   the same draft. Added 2026-08-22: the LinkedIn and course lanes carried this
   gate, the blog lane never did.
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

# Technical claims must be executed, not read (blocking)

A claim about how an external tool behaves is verified by RUNNING the
tool, never by reading its source and inferring. Reading source and
asserting behaviour produced every wrong technical claim we shipped on
2026-08-20.

Worked example, same day, twice on the same page. The Kamal 2 guide
opened by saying a stale `traefik:` key sits in `config/deploy.yml`
doing nothing. One command falsified it:

```bash
kamal config
# ERROR (Kamal::ConfigurationError): unknown key: traefik
```

Kamal validates every top-level key and refuses. The wrong inference
came from reading `Validator::Configuration#allow_extensions? => true`
and concluding unknown keys pass — that flag governs YAML extension
keys, not arbitrary config keys. The same post told readers to run
`kamal config` to find a mistyped secret name; `Configuration#to_h`
emits roles/hosts/image/builder/accessories and neither `env` nor
`proxy`, so the command exits 0 with byte-identical output and cannot
show what was claimed. Its own `desc` string ("including secrets!") is
stale, and the draft inherited that instead of testing it.

Rule: if a claim is executable, execute it before publishing. A
reviewer who runs the command outranks one who reads the file — on
2026-08-20 the runner falsified an article's opening thesis that four
source-reading passes had approved.

# Frontmatter is published copy (blocking)

`description`, `og_description`, `twitter_description` and
`cover_image_alt` ship to readers, so they get the same claims check as
prose. Diff them against the body before merge.

Caught 2026-08-20 (#509, live on the site): a post's body was softened
to "whether the model was being retired or quietly substituted", while
`twitter_description` still asserted "a retired model took out five
features at once". The softening landed in the prose and not in the
metatags, so the page kept making the exact claim the edit existed to
remove.

# Citation lists use `## Sources`

The heading for a post's external-citation list is `## Sources` — a
real heading, not a bare `Further reading:` paragraph and not a bold
`**Further reading:**` line. Plain-text markers get no table-of-contents
entry, no screen-reader landmark, and no visual separation from the body.

Convention count on 2026-08-20 before normalization: 4 posts already
used `## Sources`; 16 had drifted across three other forms and were
converted (#510). Internal JT links do NOT belong in this list — they go
in body prose or the theme's auto-generated `Read next`
(`themes/beaver/layouts/partials/blog/related-posts.html`, opt out with
`related_posts: false`).

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
