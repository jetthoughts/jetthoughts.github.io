---
type: Validator
title: Fabricated-claim ratchet
description: A structural gate over blog source that counts invented-client-work shapes (case-study headings, "in our experience", tagged-but-unremoved figures) and fails when the count rises.
resource: test/unit/marketing_copy_test.rb
tags: [validation, blog, claims, regression]
generated:
  by: claude/opus-5
  at: 2026-08-22T12:20:00Z
timestamp: 2026-08-22T12:20:00Z
---

The [banned-phrase guard](/content/banned-strings-ratchet.md) catches a defect
made of specific WORDS. It cannot catch the class
[claims-canon](/content/claims-canon.md) names "invented client work", because a
fabricated case study is written in ordinary words. What that class does have is
a SHAPE, and a shape is greppable.

`test_blog_does_not_regress_on_fabricated_claim_markers` counts those shapes in
`content/blog/**/*.md` and fails when the count exceeds its baseline.

# Why a gate rather than another sweep

Three hand-sweeps on 2026-08-22 each missed carriers the previous one missed,
because each keyed on a different surface:

| Sweep | Keyed on | Missed |
|---|---|---|
| 1 | `N clients/companies/times` | everything phrased as a case study |
| 2 | case-study headings | everything phrased as "in our experience" |
| 3 | body prose | frontmatter `description` / `twitter_description` |

Sweep 2 found the two largest carriers by impressions, both absent from sweep
1's list. That is claims-canon's own finding reproducing itself inside a single
session: **manual sweeps under-count badly.** A ratchet does not need to
recognise a fabrication - it only has to notice the count going up.

# Rules

- **Markers are shape, not judgement.** A case-study heading, the
  recurrence-generalisation hatch ("in our experience", "the pattern we see"),
  and `(figures unverified)` - a number tagged instead of removed, where the tag
  is the part a reader skips.
- **Prose markers match the whitespace-collapsed document, not line by line.**
  `/\bin our experience\b/` returns false against `"in our\nexperience"`, so a
  line-based scan has a hole that ordinary Markdown wrapping opens. Heading
  markers stay line-based, because Markdown ends a heading at the newline, and
  a line number is what you want when fixing one.
- **A case-study heading is a suspicion, not a verdict.** The shape is identical
  whether the subject is real or invented. `VERIFIED_CASE_STUDIES` allows
  specific headings by path; adding a line there asserts that someone checked.
  The test is whether the write-up names a subject a reader could go verify -
  this repo, a named client, a public postmortem. "A medium-sized content
  platform" is not a subject, and that is the whole difference.
- **Set the baseline to the measured count, then prove it is exact** by dropping
  it one lower and watching it fail. Slack in a ratchet swallows real defects -
  the rendered baseline in the same file sat at 14 against an actual 11, and
  those three spare hits absorbed a planted phrase whole.
- **dev.to imports are excluded**, derived from `source: dev_to` frontmatter, on
  the same basis as the rendered pass: their stats belong to their original
  authors. That is a TEST-scoping call and NOT editorial absolution - those
  posts are still published on our domain.

# Prioritise by impressions, never by indignation

When clearing survivors, rank by live GSC impressions. The first sweep
prioritised a `featured: true` ICP-facing post carrying a "200+ clients" claim;
it had **4 impressions in 90 days**, while the top carrier had 40,025. `featured`
is a site-internal flag, not traffic. Claims-canon states the reasoning: a
fabricated story on a page nobody reads is a liability, on a ranking page it is
the first thing a prospect sees.

# Citations

- `test/unit/marketing_copy_test.rb` - `FABRICATION_HEADING_MARKERS`,
  `FABRICATION_PHRASE_MARKERS`, `VERIFIED_CASE_STUDIES`, `FABRICATION_BASELINE`.
- [claims-canon](/content/claims-canon.md) - the standing purge policy and the
  four fabrication classes.
