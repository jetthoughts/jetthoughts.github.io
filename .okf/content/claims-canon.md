---
type: Reference
title: Company claims canon
description: The single source of truth for every factual claim JetThoughts makes about itself - founding date, tenure, ratings, retention. Any surface contradicting these is defective.
tags: [claims, canon, consistency, marketing, trust]
status: stable
generated:
  by: claude/opus-5
  at: 2026-08-20T00:00:00Z
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
| Review count | **State none**, or "9 verified Clutch reviews" | [^clutch] |
| Founder experience | 22+ years (first job 2004) - distinct from company tenure | [^founder] |
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

**A testimonial is a person, not copy - and a data file can silently outrank
your curation.** On 2026-08-20 `data/testimonials.yaml` was found carrying four
synthetic testimonials (Sarah Chen / TechStart Solutions, David Rodriguez /
EcomMega, Maria Gonzalez / HealthTech Innovations, Alex Thompson / EduPlatform)
with placeholder-shaped company names and unsourced round metrics, rendering on
the live homepage, /clients, /about-us and /use-cases. `config/_default/hugo.toml`
had already been curated down to the single real testimonial (Bruno Wozniak /
PubNative) - but `partials/page/testimonials.html` reads the DATA FILE first and
only falls back to site params, so the curation never reached the visible page.
Structured data was clean; the visible copy was not.

Three rules follow:

1. Every testimonial must name a real, attributable person, and every metric
   attached to one must trace to a source. Bruno's own `results` block was
   dropped in the same pass - three round percentages that appear nowhere in his
   quote. A fabricated testimonial is an FTC exposure, not a style problem.
2. When a `data/` file and a config param feed the same surface, check WHICH ONE
   WINS before believing a curation held. Cleaning the config is not cleaning
   the page.
3. Case-study prose needs the same test. `fractional-cto-roi-calculator` ran five
   full-name founders with direct quotes under "Real Founder Stories ... from
   JetThoughts clients", no anonymisation disclaimer, and said "three stories"
   while showing five. Its sibling `infrastructure-spending-evaluation` already
   used the honest form ("names changed, numbers accurate") - copy that form.
   **RESOLVED 2026-08-20 - Paul: "remove she is not real."** "Sarah Chen"
   appeared both in the purged synthetic testimonials and in that live post, and
   is confirmed fabricated. The whole five-founder section was removed, along
   with its two false claims ("Real Founder Stories ... from JetThoughts
   clients" and "these aren't hypothetical scenarios - they're real situations
   from JetThoughts clients in the past 24 months"). The useful patterns were
   kept as an unattributed list that says plainly we have no completed case
   study to publish yet.

   The `infrastructure-spending-evaluation` post was corrected in the same pass.
   Its "real stories from our clients (names changed, numbers accurate)" form
   had looked like the honest convention - but the confirmed fabrication next
   door makes an unverifiable "numbers accurate" assertion the same defect,
   just better dressed. Relabelled as illustrative composites.

   **The rule this leaves:** a disclaimer that asserts MORE than you can verify
   is not a fix. "Names changed, numbers accurate" claims real provenance; if
   nobody can produce the client, say "illustrative composite" instead.

# Verified review counts (2026-08-14 audit)

Every public review platform was checked. **The real total is 11 across three
platforms** - not 32, on any reading.

| Platform | Rating | Reviews |
|---|---|---|
| [Clutch](https://clutch.co/profile/jetthoughts) | 4.8 | **9** |
| [GoodFirms](https://www.goodfirms.co/company/jetthoughts-llc) | 5.0 | 1 |
| Google | 5.0 | 1 |
| [Techreviewer](https://techreviewer.co/companies/jetthoughts) | score 5.0 | aggregates the above |

Clutch is the one worth citing: 9 verified reviews is the deepest single source,
and its sub-scores are public (Quality 4.9 · Schedule 4.9 · Cost 4.7 · Willing to
Refer 5.0). GoodFirms and Google are single reviews - real, but too thin to lead
with.

**Clutch independently lists "Year founded: 2008"**, and its case studies span
2008-2024. The review platform had the founding date right while our own site
said 2011.

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
- The same file runs a SECOND pass over **built HTML** (2026-08-20, closes
  20.10 §3b P0-4). Source globbing cannot see a figure inside an unglobbed
  partial, a phrase wrapped across two template lines, or markup that only
  exists after compose - all three shipped on 2026-08-14. The rendered pass
  walks blog + course + services under the suite's own Hugo build, skips dev.to
  imports (derived from `source: dev_to` frontmatter - their stats belong to
  their original authors) and paginated list views (double-counts). It is a
  REGRESSION ratchet, not a cleanup gate: baseline 40, fails when the count
  rises. It immediately surfaced 25 hits invisible to source - the deferred
  `content/clients` excerpts syndicated onto every services page.
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
[^founder]: Paul Keen's first professional role was in 2004 (stated by Paul,
    2026-08-14). Company tenure (2008) and founder experience (2004) are
    separate claims - do not conflate them.
