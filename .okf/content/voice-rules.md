---
type: Style Guide
title: Course voice rules (write for Sam)
description: The reader is Sam, an idea-stage non-technical first-time founder; plain-words glossing, dash style, and the banned structural patterns.
tags: [voice, style, course]
generated:
  by: process:okf-migrate
  at: 2026-07-13T00:00:00Z
verified:
  by: claude-opus/4.8
  at: 2026-08-17T00:00:00Z
---

Full guides: `docs/90-99-content-strategy/strategy-analysis/90.11-voice-guide.md`
and the course-specific rules in `CLAUDE.md`. This concept records the
rules that recur in review sprints.

**Channel registers (Paul, 2026-08-14).** Each channel gets its own voice; all
channels share the anti-slop core. Website is plain and load-bearing with every
claim showing a mechanic or linking proof; blog teaches with worked examples;
course is patient and second-person with first-mention glossing (this concept);
LinkedIn is first-person and committed - Register B, hammering one idea. What
never varies: the banned words, the banned structural patterns, the
who/show/practitioner tests, and sourced numbers
([claims canon](claims-canon.md)). A shorter register is not a licence to slop.
Full table in 90.11 §1b.

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
- **No text bricks (Paul 2026-08-17)**: no paragraph over ~5 rendered lines.
  Break by content type - a quotable artifact (survey question, Slack
  message, script) becomes a blockquote; an enumeration-in-prose ("pull
  three numbers: X, Y, Z") becomes a list; if-X-then-Y becomes a table; a
  fact the adjacent exhibit already shows visually gets ONE prose sentence,
  not a re-description. Tell: a heading apologizing for the wall ("...in
  one paragraph") marks the brick. First caught on 5.1's 9-line 40%-test
  paragraph and friday-demo's opener pair.

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
