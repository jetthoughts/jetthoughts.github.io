---
type: Reference
title: Company claims canon
description: The single source of truth for every factual claim JetThoughts makes about itself - founding date, tenure, ratings, retention. Any surface contradicting these is defective.
tags: [claims, canon, consistency, marketing, trust]
status: stable
generated:
  by: claude/opus-5
  at: 2026-08-14T00:00:00Z
sources:
  - id: hugo-config
    resource: config/_default/hugo.toml
    title: Site params - foundingYear / foundingDate
  - id: clutch
    resource: https://clutch.co/profile/jetthoughts
    title: JetThoughts Clutch profile
  - id: product-md
    resource: PRODUCT.md
    title: Product canon - Evidence on Hand
---

# Canonical values

| Fact | Canon | Source |
|---|---|---|
| Founding date | **2008-09-01** | [^hugo-config] |
| Tenure phrasing | "since 2008" - **derive**, never hardcode | [^hugo-config] |
| Years of experience | `now.Year - foundingYear` (18 in 2026) | [^hugo-config] |
| Rating | **4.8/5 on Clutch**, with the profile linked | [^clutch] |
| Review count | **State none.** Clutch shows 9 | [^clutch] |
| Client retention | ~95% | [^product-md] |
| Average client relationship | 5 years | [^product-md] |
| Developer experience | 8+ years average | [^product-md] |

# Rules

**Derive tenure, never hardcode it.** Use `since {{ site.Params.foundingYear }}`
or `{{ sub now.Year (int site.Params.foundingYear) }}+ years`. The 2026-08-14
correction found the year wrong in eight places precisely because each had
hardcoded its own copy instead of reading the param.

**A number with no in-repo source is a defect, not a detail.** `reviewCount: 32`
shipped in structured data on ~1,147 URLs for years with nothing backing it; the
real figure was 9. Before publishing a number, name where it comes from.

**Prefer a linked claim over a bigger unlinked one.** "4.8/5 on Clutch" with the
profile linked beats "4.8/5 by 32 clients" unlinked. The link is the proof, and
it cannot go stale the way a transcribed count does.

**"32 clients" is ambiguous - do not treat the two meanings as one.** As a
*review* count it is false. As *total clients served* it appears in the 2607
referral and assumptions docs and is plausible for an 18-year-old firm, though it
has no in-repo source either. The old site copy "4.8/5 by 32 clients" conflated
them, which is how an unsourced number passed as sourced.

**Never claim "20 years."** Founded 2008; the honest figure is 18 and rising.

# Enforcement

These are ratcheted mechanically, not by review — manual sweeps under-count
badly (the 2026-08-14 pass found ~18 more violations by test than by careful
grep):

- [Banned-strings ratchet](/content/banned-strings-ratchet.md) covers
  `content/course/**` and bans "since 2011", "founded in 2011", "since 2005".
- `test/unit/marketing_copy_test.rb` covers the marketing surfaces (config menu
  names, `content/services`, `content/use-cases`, `content/pages`, the home and
  page templates, the shared testimonials partial) and bans the stale tenure and
  false-count spellings.
- Deliberately **not** banned: "15+ years". It cannot distinguish company tenure
  from staff experience ("our fractional CTOs average 15+ years") and
  false-positives immediately. A ban that cannot tell those apart is noise.

# Where this canon is repeated

Correcting a published fact means sweeping the **instruction layer**, not just
the output. In 2026-08-14 the wrong founding year and review count were baked
into docs that tell future writers what to claim:
`PRODUCT.md`, `docs/business/vision-mission.md`,
`docs/projects/2607-vibe-code-rescue/rescue-sprint/` (offer-one-pager,
warm-intro-referral-kit, customer-profile-four-forces, objection-followup-bank),
and `docs/projects/2605-.../50.02-pilot-outreach-campaign-kit.md`. Anyone
following them would have re-introduced both.

[^hugo-config]: `config/_default/hugo.toml` - `foundingYear = 2008`,
    `foundingDate = "2008-09-01"`. The commented single-source-of-truth param.
[^clutch]: <https://clutch.co/profile/jetthoughts> - 4.8/5 from 9 reviews,
    verified 2026-08-14.
[^product-md]: `PRODUCT.md` §Evidence on Hand - the sourced-numbers-only policy.
