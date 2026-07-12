---
type: Style Guide
title: Course voice rules (write for Sam)
description: The reader is Sam, an idea-stage non-technical first-time founder; plain-words glossing, dash style, and the banned structural patterns.
tags: [voice, style, course]
timestamp: 2026-07-13T00:00:00Z
---

Full guides: `docs/90-99-content-strategy/strategy-analysis/90.11-voice-guide.md`
and the course-specific rules in `CLAUDE.md`. This concept records the
rules that recur in review sprints.

# Core rules

- **Write for Sam, not Paul.** Sam is an idea-stage non-technical founder.
  Course bodies never use rescue/trauma framing (that ICP is the website's
  "Alex", not the course's Sam); the Going Further rescue chapters are the
  exemption.
- **Gloss at first mention** - every acronym/tool/term gets a plain-words
  parenthetical the first time it appears in the reading order (SOW, MSA,
  SLA, FTE, PLG, ARPU, MAU, RAG-status, 0day...).
- **Dashes**: always "-", never "—" - in prose AND inside SVG/mermaid artwork.
- **Progressive disclosure**: orientation blocks orient; thresholds and
  mechanics belong where the reader acts on them.
- **Callout rhythm**: no two adjacent same-form callouts.

# Banned structural patterns (reject on sight)

Slogany reveal-twist flips ("X wasn't Y - it was Z"), cinematic time-cut
narration, anonymous-founder-vignette openers repeated 3+ chapters in a row,
aphoristic flourish closers, fabricated cohort stats without a source,
`## Why this matters` headings, "Founders who / Most founders / Founders we
worked with", dual-source statistical openers, sustained staccato.

Sentence-level slop scoring is necessary but NOT sufficient - shape-tell
review (essay arc, pivot sentences, cloned scaffolding) runs alongside it.

Regression sweep before any handback:

```bash
grep -rn "## Why this matters\|Founders who\|Most founders\|Founders we worked with" content/course/
```
