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

# What this gate does NOT catch

It counts INVENTED shapes. It cannot tell you whether a claim is TRUE.

A wrong mechanism has no shape - it is a well-formed sentence using the right
vocabulary, and it usually points in roughly the right direction while getting
the reason wrong. Two candidate markers were measured and rejected on
2026-08-22: an anonymous-company pattern returned 10 hits mostly legitimate
("we measured a mid-size Rails API app (60 controllers...)"), and an
absolute-claim pattern returned 185 hits that were almost entirely ordinary
prose ("remote work is no longer a perk", "eliminates Rails boot time"). Either
one would cry wolf until people stopped reading the output.

So a green run means "no invented-client shapes", not "the post is accurate".
Correctness is caught by a reader with domain knowledge and a brief that makes
disagreement their job - and by the sourcing rules in
[claims-canon](/content/claims-canon.md), especially **a replacement is a new
claim**, which is the rule this gate's own creation violated.

## Two true quotes can compose into a false claim (2026-08-23)

The hardest defect a claim pass has found here was built entirely from
verbatim quotes. `dev-shop-ai-code-review-what-to-ask` set Uber's "only 51% of
human-written comments are considered as bugs by the author" against uReview
getting "over 65% of its posted comments addressed", and concluded the machine
reviewer beats the humans. Both quotes exact. Both figures real. **They are
different instruments** - the 65% is Uber re-running uReview five times on the
final commit and checking whether the comment still fires, with no person
involved, while the 51% is a human author's verdict.

Nothing in the sentence is fabricated and no ratchet can see it, because the
defect lives in the JOIN, not in either half. So the check is not "is this
quote real" but **"were these two numbers produced by the same instrument?"** -
ask it every time a sentence puts two figures in a comparison, especially when
one of them flatters the argument.

**The prose fix is not the whole fix.** That comparison was also rendered as a
bar chart. Deleting the sentence left `reviewers.svg` asserting it in a form
nobody re-reads, still shipped in the page bundle and still reachable at its
own URL. When a claim is corrected, grep the bundle for a diagram carrying it.

Related instrument errors from the same pass, all invisible to shape-counting:
a figure scoped "on the OWASP Benchmark positives" quoted as if it spanned the
real-world dataset too; a paper measuring SAST-alert triage cited as if it
measured AI-reviewer comment filtering; and `+15%` attached to "vs 2022 levels"
when that clause governed the OTHER half of the source sentence and the chart
was indexed to 2023.

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

## The comparison itself can be the defect (2026-08-28)

A post set out to argue that Rails' ecosystem is more stable than JavaScript's.
Every quote in the draft was verbatim and verified at primary. The argument
still inverted under checking, twice, for reasons no quote-level gate can see.

**1. Comparing unlike things.** The draft used Express's release cadence (one
breaking major in ten years) against Rails' five asset-pipeline defaults. Both
figures were correct. Express is a routing library and Rails is a full-stack
framework that also decides your ORM, view layer, jobs and file uploads, so
release cadence across that gap measures nothing. Paul flagged it as
"apple with orange". The reviewer independently found the consequence: the
draft declared Express "the equivalent framework", then silently used Node.js's
48.7% rather than Express's 19.9% for a hiring ratio, turning 3.4:1 into 8:1.
**An unstable premise produces a numerator nobody can defend.**

**2. Trimming a quote at the clause that contradicts it.** Rails' policy reads
"Only bug fixes, no API changes, no new features. *Except as necessary for
security fixes.*" The draft quoted through "no new features", dropped the
exception with no ellipsis, and concluded there was a lane "not allowed to
break your app" - when the dropped clause carves out exactly the urgent case.
The contradiction was one click away through a link in the same paragraph.

**3. The flattering citation you must not use.** A 2019 follow-up
(arxiv.org/abs/1911.11894) finds Ruby has a NEGATIVE association with defects.
Its authors also say the result "has no clear interpretation" and that such
findings are "no more useful than observing that it often rains on Tuesdays",
and they counted 26 citations implying causality where they found association.
Using it would have made us the 27th.

**Checks that would have caught these:**
- Before comparing two things, state what each one's SCOPE is. If the scopes
  differ, the comparison is decoration.
- Read one sentence PAST the end of every quote before trimming it.
- When a citation flatters you unusually, read the authors' own caveats first.
- Re-derive any ratio from the same table both numerator and denominator
  come from.

## Three verdicts on three sets of numbers, same sweep (2026-08-28)

A credibility sweep hit three benchmark tables in one day and reached three
different answers. The differences are the useful part, because "delete numbers
that look suspicious" is as wrong as inventing them.

**1. ARITHMETICALLY IMPOSSIBLE - delete.** A table claimed "real production data
from a Rails app processing 1.2 million jobs daily" with a before-throughput of
12 jobs/second. 1.2M/86,400 = 13.89/sec sustained, so at 12/sec the queue falls
163,200 jobs behind every day and never drains. Two figures in the same
paragraph refuting each other needs no external source. **Check the internal
arithmetic before going looking for a citation - it is faster and it is
conclusive.**

**2. THE SAME FIGURES ACROSS UNRELATED STACKS - delete.** `450ms -> 120ms -> 73%`
appeared three times: once for Rails background-job latency, twice for Django
async views. One post used the identical triple for two DIFFERENT scenarios of
its own ("sequential operations" and "heavy I/O"). Different measurements do not
land on the same three numbers. **Grep a suspicious figure across the whole
corpus; a template shows up as repetition, not as a bad single value.**

**3. COHERENT BUT UNREPRODUCIBLE - keep and qualify.** Falcon's benchmark tables
survived. Falcon at 102ms against a forced 100ms I/O delay is exactly right, the
Puma row degrades in proportion to its worker slots, and the hello-world table
shows a COMPETITOR (Agoo) beating our recommendation on every column. Nobody
fabricates a rival beating their own pick. What was actually wrong: no load
generator named, no date, no app described - unreproducible rather than false.
Fixed by saying so and pointing at the sibling post that does record its method.

**The discriminator, in order of cost:** does it contradict itself; does the same
figure appear elsewhere; does a competitor row run against the author; can a
reader re-run it. Only the last one was missing on Falcon, and that is a
disclosure problem, not a fabrication.

**Corollary on gates.** The uncited-posts ratchet counts a post as cited if it
carries ANY external link. Falcon has 17 links and 24 unattributed benchmark
tables, so it sat green. Link presence is not attribution.
