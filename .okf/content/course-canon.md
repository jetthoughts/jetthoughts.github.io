---
type: Reference
title: Course canon numbers
description: The single source of truth for every recurring number in the course; any chapter that contradicts these is defective.
tags: [course, canon, consistency]
timestamp: 2026-07-13T00:00:00Z
---

# Canonical values

| Fact | Canon |
|---|---|
| Founding Hypothesis score | ≥14/20 across four lenses |
| Smoke test traffic | 300 cold visitors |
| Interviews | 10 (from a 30-name list, expanded if replies run thin) |
| Build / pivot / kill gate | 7+ strong signals build · 4-6 pivot · under 4 kill |
| Prototype test subjects | 5 interview subjects |
| Sean Ellis must-have test | 40% - directional at ≥10 respondents, useful at 20+, sliceable at 30+ |
| Cold reply bands | 3-8% realistic; <5% stop and diagnose · 5-10% continue · >10% accelerate |
| Paid pilot deposit | $500+ refundable, via Stripe |
| Tracking tool | Google Sheet - never Airtable |
| AI token pass-through | disciplined $80-$120/dev/mo · undisciplined $300-$500; industry range $80-$300 |
| Slopsquatting source | Lasso Security research March 2025; "slopsquatting" coined by Infosecurity Magazine April 2025 |

# Recurring cast (keep consistent across chapters)

- **Mia** - the walkthrough protagonist (TutorMatch).
- **Marcos** (author) and **Priya** (reviewer) - the PR-review example pair.
  Spelling is "Marcos", never "Marcus". PR #847 = the refund-branch review
  story; the weekly-report admin-search example uses PR #843.

Structural home: [course structure](/content/course-structure.md).
Enforcement: [banned-strings ratchet](/content/banned-strings-ratchet.md).

# External sources for cited claims

- Sean Ellis 40% test: [Lenny's Podcast interview](https://www.lennysnewsletter.com/p/the-original-growth-hacker-sean-ellis) (cutoff + wording).
- Slopsquatting: [Lasso Security research](https://www.lasso.security/blog/ai-package-hallucinations) + [Infosecurity Magazine, April 2025](https://www.infosecurity-magazine.com/news/ai-hallucinations-slopsquatting/) (coined the term).
- First-10-customers network finding: [Lenny Rachitsky's B2B first-customers research](https://www.lennysnewsletter.com/p/how-todays-fastest-growing-b2b-businesses).
- Interview method: Teresa Torres, [Customer Interviews](https://www.producttalk.org/customer-interviews/) and [Learning to Interview Continuously](https://www.producttalk.org/learning-to-interview-continuously/) (Product Talk).
- Reply bands, deposit bands, token pass-through ranges: internal editorial
  canon (JT practice numbers) - no external citation; do not invent one.

# Progressive elaboration rule (expand, never restart)

Later lessons MAY deepen an earlier artifact; they MUST NOT re-derive it
from a blank page. Mechanically: any lesson touching an earlier artifact
opens WITH it - "open your [artifact] from Lesson N.N, paste it here" -
and adds a named delta. Every prompt slot names its source artifact.
Good: 2.3's three sentences ("your 1.1 blanks, unpacked - copy the
sentence in"). Bad: a persona prompt asking Sam to describe the customer
fresh when the ICP map already exists. Owner rule 2026-07-17: "it's ok to
expand previous results; but if we start over to do the same it's
confusing."

# Terminology

Numbered core units are **Lessons** ("Lesson N.N", never "Chapter N.N" or
"Ch N.N" - enforced by the lesson-number validator; decided in the 30.03
format spec). "Chapters" remains only for the non-numbered long-form set
(Going Further, continuation, supplementary references).
