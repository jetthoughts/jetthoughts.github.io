---
type: Reference
title: Company claims canon
description: The single source of truth for every factual claim JetThoughts makes about itself - founding date, tenure, ratings, retention. Any surface contradicting these is defective.
tags: [claims, canon, consistency, marketing, trust]
status: stable
generated:
  by: claude/opus-5
  at: 2026-08-20T00:00:00Z
timestamp: 2026-08-20T00:00:00Z
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

**No fractional-CTO and no tech-lead title claims (Paul, 2026-08-21).** Do not
write, on any NEW or v2 surface, that JetThoughts supplies a fractional CTO, a
CTO, a tech lead, an engineering manager, or any other titled leader. The basis
is factual: Paul was the lead tech at Crosslake, a PM opened the engagement, and
leadership was promoted from inside the team - so a title claim misstates what
happened. Treat it as the same class as a fabricated testimonial, not as a style
preference.

**AMENDED (Paul, 2026-08-28).** The ban above is about MISDESCRIBING PAST
ENGAGEMENTS, not about what we are able to deliver.

The accurate position, in Paul's words: we do not lead with fractional CTO and
we do not claim it as a flagship, but we can provide it if a client turns up.
It has not found clients and it is not the main service. So it is available
rather than advertised - do not put it at the front of new positioning work,
and do not delete it either.

So: **do not flag existing posts or service pages for offering fCTO/EM
advising, and do not "repair" them.** The `/services/fractional-cto`,
`/services/emergency-cto-leadership` and related pages stay, and blog CTAs
pointing at them are fine. What still applies is the original factual point -
do not claim we supplied a titled leader on an engagement where we did not,
which is what the Crosslake basis below is about.

The main offer, and what new marketing copy should lead with: **an embedded team of
senior self-managed full-stack developers who drive the development while the
client runs the rest of the business.** Chosen over migration assurance, CRA,
SOC 2 and umbrella positioning because it is the only offer that has ever
converted, and because every canon proof point below (tenure, retention, the
five-year average relationship) is evidence for exactly this claim. Migration
assurance stays off the site until the r/msp test converts; `/vibe-code-rescue`
remains an SEO lander only.

SCOPE, and the reason it is not yet absolute: the LEGACY live site still sells
fractional CTO on `/services/fractional-cto/`, the homepage, footers and blog
cross-links. Those pages carry the banned claim today. Removing them is Paul's
call and needs a GSC check first - `/services/fractional-cto/` has ranking
history - so the ratchet for this rule must scope to v2 surfaces until that is
decided. A repo-wide ban fails instantly on legacy pages, which is why one has
not been added yet. Full working paper, including the repositioned copy this
rule produced: `docs/projects/2608-site-design-system/20-29-strategy/20.09-repositioned-pilot-copy.md`.

**Derive tenure, never hardcode it.** Use `since {{ site.Params.foundingYear }}`
or `{{ sub now.Year (int site.Params.foundingYear) }}+ years`. The 2026-08-14
correction found the year wrong in eight places precisely because each had
hardcoded its own copy instead of reading the param.

**A number with no in-repo source is a defect, not a detail.** `reviewCount: 32`
shipped in structured data on ~1,147 URLs for years with nothing backing it; the
real figure was 9. Before publishing a number, name where it comes from.

**A MECHANISM is a claim too, and it is the more dangerous kind.** A number
announces itself as something to check. An explanation of how a thing works
reads as reasoning, so it gets waved through - which makes a wrong mechanism
outlive a wrong number. Verify it against the primary source (the README, the
release notes, the code) exactly as you would a figure, and prefer linking that
source over asserting the mechanism unlinked.

**A REPLACEMENT IS A NEW CLAIM (2026-08-22).** When you delete an unsourced
claim, whatever you write in its place is not a fix - it is a fresh assertion,
and it needs the same source you just demanded of the thing you removed. This is
the failure mode de-fabrication has all of its own: the hole gets filled with
less scrutiny than the claim that was in it, because the edit feels like
cleanup rather than authorship.

Demonstrated the same day, by the same author, on the same sentence. An agent
removed an unsourced Propshaft timing figure and wrote that precompilation
"stops being a build step that scales with your asset count" - false; every
asset is still walked, fingerprinted and copied. Hours later the same claim went
into a blog post, and *that* time the Propshaft README was fetched first and the
sentence came out right. Same fact, same author, same day: sourced when it was
framed as writing, unsourced when it was framed as fixing.

**Use an instrument, and point it at the rebuttal.** `context7` for how a
library behaves; `WebSearch` then `WebFetch` the PRIMARY source for a study
(press coverage of a study is not the study, and the caveats travel with the
number); NotebookLM for a body of sources. Then query for the criticism and the
failed replications rather than the supporting case - searching for support
returns support. Doing that on 2026-08-22 surfaced a randomised trial that
complicated the claim being written and improved it: METR measured experienced
developers 19% SLOWER with AI while they estimated themselves 20% faster, a
~40-point gap between measurement and belief among experts working on their own
code.

**Correctness is not greppable, and no ratchet here claims otherwise.** Two
candidate markers for wrong-mechanism claims were measured and rejected on
2026-08-22 - an anonymous-company pattern (10 hits, mostly legitimate: "we
measured a mid-size Rails API app") and an absolute-claim pattern (185 hits,
almost entirely ordinary prose: "remote work is no longer a perk"). A gate
noisier than the defect it guards is worse than no gate. What catches a wrong
mechanism is a reader with domain knowledge and a brief that makes disagreement
their job - see [fabrication-ratchet](/content/fabrication-ratchet.md) for what
the mechanical gate does and does not cover.

**Prefer a linked claim over a bigger unlinked one.** "4.8/5 on Clutch" with the
profile linked beats "4.8/5 by 32 clients" unlinked. The link is the proof, and
it cannot go stale the way a transcribed count does.

**Prefer the BEST source, not just the first one that verifies the claim
(Paul, 2026-08-24).** A blog post's `## Sources` block exists for two distinct
reasons, and they pull in opposite directions:

1. **Anti-fabrication tripwire** — the uncited ratchet is a cheap, machine-checkable
   proxy for "this claim rests on something external, not something hallucinated."
   A link to the official docs satisfies this job. It is necessary but not
   sufficient for reader value.
2. **Reader value** — the reader came for your synthesis *above* the source, not
   a restatement of it. A citation to the Rails guides for "Rails 8 ships with
   Solid Queue" earns nothing — the reader already knows the gem exists or can
   Google it in five seconds. What earns its place: primary research, a
   benchmark with its denominator, the original GitHub issue thread, a
   practitioner's production measurement, a study fetched at the publisher's own
   page, or our own measured number with its methodology.

The test: **could the reader have found this source in five seconds of
Googling?** If yes, it is verification, not value — keep it if the ratchet
requires it, but do not mistake it for the job being done. The real bar is
"this is the BEST source for this claim, and the best source is one the reader
would not have found on their own."

A mechanical gate can only measure the first job (external links exist). The
second job is a judgment call for the cold-eyes review panel — see
`docs/workflows/blog-pipeline.md` STEP 5c Check 10.

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

# Ranking legacy posts are a live reservoir of fabricated claims (2026-08-20)

The fabricated-claims purge (PRs #475 / #477 / #481) swept landing and course
surfaces. It did not reach the blog archive, and the blog archive is where the
traffic is. `ruby-3-4-yjit-performance-guide` - **6,310 impressions at position
9.5**, one of the site's better-ranking pages - carried four classes of
invention at once:

| Fabrication | What it claimed |
|---|---|
| Invented third-party internals | Shopify saving "$2.4M" from YJIT |
| Invented third-party results | GitHub deployment outcomes |
| Invented client work | two JetThoughts case studies with no client behind them |
| Invented future | a Ruby 3.5 / 3.6 / 4.0 roadmap |

Rewritten in place 2026-08-20 as the Ruby 4.0 YJIT-vs-ZJIT guide with every
claim sourced. Two rules follow:

- **Extend the purge to ranking legacy posts, highest-impression first.** A
  fabricated client story on a page nobody reads is a liability; on a page at
  position 9.5 it is the first thing a prospect sees. SEO-era posts predate the
  sourced-numbers policy and were never audited against it.
- **Audit the premise before refreshing.** The content plan's *named* refresh
  candidate had decayed to 4 impressions while this unnamed post was the real
  asset. Pull live GSC at decision time; see
  [content-plan](/content-strategy/content-plan.md).

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
