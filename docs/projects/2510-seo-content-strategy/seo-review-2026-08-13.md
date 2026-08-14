# SEO Health Status - 2026-08-13

**Window**: 2026-07-14 → 2026-08-10 (28d), compared to Feb/Apr/May baselines
**Sources**: GSC `sc-domain:jetthoughts.com`, GA4 property 328508492 ("Home Page - GA4")
**Prior reviews**: [`seo-review-2026-04-29.md`](seo-review-2026-04-29.md), [`20.08`](20-29-strategy/20.08-content-plan-data-driven-q3-2026.md)

---

## 1. Verdict: 🔴 measurement is broken, traffic is flat-to-declining

The headline finding is not a ranking problem. It is that **the number the strategy
is steered by does not exist**. `GOAL-AT-A-GLANCE.md` sets a "~5k baseline" of
monthly organic sessions. Real search traffic is roughly **255 sessions / 28 days**.

| | GSC (Google-side clicks) | GA4 (browser-side sessions) |
|---|---|---|
| Google organic, same 28d | **~130** | **1,628** |

A 12x gap is not reporting lag. The engagement data identifies which side is wrong:

| Source | Sessions | Engagement rate | Avg session |
|---|---|---|---|
| google / organic | 1,628 | **11.8%** | 34s |
| duckduckgo / organic | 77 | 68.8% | 370s |
| bing / organic | 48 | 66.7% | 425s |
| (direct) / (none) | 4,071 | 31.0% | 21s |

Real humans arriving from search engage at ~67% (Bing, DDG). The "google organic"
and "direct" buckets engage at 12-31% for 21-34 seconds. Corroborating signals:
`first_visit` 5,515 of 5,885 `session_start` (94% brand-new users), and 170 `scroll`
events against 6,392 `page_view`s. **~85-90% of GA4 traffic is bots.**

Every decision made against "5k organic sessions" was made against noise.

---

## 2. Search performance (GSC, real numbers)

| Metric | 28d | vs Feb 2026 |
|---|---|---|
| Clicks (domain property) | 140 | ~9/day → ~5/day |
| Clicks (excl. `elital.` subdomain) | ~122 | -40% |
| Impressions | 104,562 | ~flat, but composition worse |
| CTR | 0.13% | was 0.24% |
| Avg position | 18.5 | **was 14.7 (Feb), 13.0 (Apr)** |

**Position decay is the real trend**: 13 → 20 since April. It is monotonic, not a
single-day blip, and it tracks across the top pages independently. Impressions on
the main site fell from ~4-5k/day (Feb-Jun) to ~2-3k/day since mid-July.

### Impression base is polluted
- `elital.jetthoughts.com/blog/mastering-your-upwork-login...`: **14,438 impressions, 2 clicks** (14% of all domain impressions, 1.4% of clicks). April review flagged this cluster at 1,517 impressions; it is now ~10x worse and has migrated to the subdomain.
- Long-tail quoted-code queries (`"@@defaults = *args" ruby`, `"enable_coverage_for_eval" simplecov`) contribute hundreds of impressions at 0% CTR. Unwinnable and unconvertible.

Site-wide CTR is therefore a meaningless number as currently reported.

---

## 3. What the April / 20.08 recommendations actually produced

| Recommendation | Shipped? | Outcome |
|---|---|---|
| `/services/` + homepage title/meta rewrite | ✅ | Homepage CTR 5.7% → 7.3%. But position 9.1 → **20.9**. Net clicks +7. |
| LangGraph / CrewAI / AutoGen title rewrites | ✅ | **Did not reclaim clicks.** `langgraph-workflows` fell out of the top-15 by impressions entirely; `rails-testing-best-practices` 9,997 → 2,231 impressions (-78%) for +3 clicks; `falcon-web-server` -85% impressions. |
| Upwork junk-query cleanup | ⚠️ partial | Fixed on the main domain; the cluster now lives on `elital.` and grew 10x. |
| P1: wire posts to `/services/vibe-code-rescue/` | ✅ 7 posts | Page is indexed (`PASS`, crawled 2026-07-31) but has **3 impressions / 0 clicks**. All 7 linking posts have near-zero organic traffic, so no equity flows. |

**The title-rewrite experiment has a result: rewrites moved impressions, not clicks.**
The 20.08 projection of "535 clicks from rewrites alone" did not materialise -
Google reduced the impressions instead. Do not run a second wave on this thesis.

---

## 4. Commercial pages are invisible

`/services/*`, last 90 days: **1,879 impressions, 1 click.**

| Page | Impressions | Clicks | Position |
|---|---|---|---|
| `/services/fractional-cto/` | 641 | 1 | 26.1 |
| `/services/technical-leadership-consulting/` | 241 | 0 | 21.2 |
| `/services/fractional-cto-cost/` | 237 | 0 | 48.2 |
| `/services/vibe-code-rescue/` | 3 | 0 | 5.7 |

ICP-E rescue cluster (`dev shop` queries), 90 days: **99 impressions, 0 clicks**
(`startup dev shop` pos 16.6, `dev shop for startups` pos 21.1).

This **confirms** 20.09 §7's own call - rankings on the rescue cluster are a
6-12 month horizon and not a lever before Dec 1. The data says: don't reopen it.

---

## 5. There is no conversion tracking

GA4 `keyEvents` = **0**. The complete event inventory for 28 days:

`page_view` 6,392 · `session_start` 5,885 · `first_visit` 5,515 · `user_engagement`
1,432 · `scroll` 170 · `click` **4** · `course_*` 9

No form submission, no contact-CTA click, no booking event. `/contact-us` received
30 sessions and we cannot say what happened on any of them. **The plan's primary
metric - consultation bookings - is not instrumented.**

---

## 6. Next actions (ranked, and deliberately short)

Content is gated behind 2607 outreach (20.09 P0), and this data argues *against*
spending effort on rankings before Dec 1. So the list is measurement-first, then stop.

| # | Action | Effort | Why now |
|---|---|---|---|
| **1** | **Instrument one conversion event**: click on the contact/booking CTA, marked as a GA4 key event. | 30 min | Nothing else can be judged without it. Highest value per minute on this list. |
| **2** | **Fix the traffic numbers**: enable GA4 bot filtering, then re-baseline. Correct the "~5k organic sessions" line in `GOAL-AT-A-GLANCE.md` to the real ~255/28d. | 1-2h | A phantom baseline is worse than no baseline - it makes flat look healthy. |
| **3** | **Stop reviewing on `sc-domain:`**. Switch weekly review to the `https://jetthoughts.com/` prefix property, or `noindex` the elital Upwork post. | 30 min | Removes 14% of impressions that are 1.4% of clicks and distort every CTR figure. |
| **4** | **Investigate the homepage position drop** (9.1 → 20.9 since May). One look at what changed - it is the only page with real brand-intent conversion value. | 1h | Biggest single ranking loss on a page that matters. |
| **5** | **Do NOT run title-rewrite wave 2.** Record the experiment as falsified. | 0 | Wave 1 cost real hours and returned impressions loss, not clicks. |
| **6** | **Do NOT invest in the rescue keyword cluster before Dec 1.** Reaffirm 20.09 §7. | 0 | 99 impressions / 0 clicks over 90 days confirms the existing call. |
| **7** | **Delete `comprehensive-service-schema.html:101-157`** - the fabricated reviews and the 4.9/23 rating. See §8.2. | 20 min | Policy + FTC exposure. A manual action applies domain-wide, so low service-page traffic does not reduce it. |
| **8** | **Confirm `4.8 / 32` against the live Clutch profile**, then either link the rating to it or drop `aggregateRating`. | 20 min | `reviewCount: 32` has no source in the repo. See §8.2. |
| **9** | **Add `[minify.tdewolff.html] keepQuotes = true`** to `config/_default/hugo.toml`. | 5 min | Cosmetic-for-third-party-tools only - see §8.1. **Not an SEO fix**; do not re-raise it as one. |
| **10** | **Verify the four remaining unsourced numbers**: `Client Retention Rate 95%` and `Success Rate 92%` (service-schema `PropertyValue`, live on ~1,147 URLs), "40+ projects rescued", "32 clients served". | 1h | **4 of 8 published figures checked in this cycle were wrong.** At that rate assume ≥2 of these are too. Verification is cheap - the Clutch check took one call. Record in [claims canon](/.okf/content/claims-canon.md). |
| **11** | **Point `marketing_copy_test` at rendered output** (`_dest/public-dev/**/*.html`) as a second pass. | 1h | Every late defect in the 2026-08-14 sweep was invisible to source matching - a partial outside the globs, a phrase wrapped across lines, and a nested `<main>` that only exists after compose. See `docs/20-29-testing-qa/20.10` §3b P0-4. |

### What is explicitly *not* recommended
- New content for SEO reasons. At ~5 clicks/day and declining positions, publishing volume is not the constraint.
- Technical SEO work. Sitemap is clean (1,147 URLs, 0 errors), key pages return `PASS` on inspection, schema validates. This is not a crawlability problem. (Schema validates *structurally*; §8.2 found part of its **content** is fabricated. That is a policy risk, not an SEO one, and actions #7-#8 address it on those grounds.)
- Chasing the position 13 → 20 decay with on-page fixes until #2 is done. Without trustworthy numbers there is no way to tell a fix from noise.

---

## 7. One-line summary for the OS weekly

> Organic is ~5 clicks/day and positions slid 13 → 20 since April; the "5k sessions"
> baseline is ~90% bot traffic and conversions are untracked. Fix measurement (2h),
> then leave SEO alone until outreach is unblocked.

---

## 8. Third-party audit response (2026-08-13)

A third-party AI-SEO tool (`lightsite.agent`) scored jetthoughts.com **60/100, "Multiple Organ
Failure"**, against competitors at 39 and 100 (lower is better on its scale). Every claim was verified
against the live site and against GSC. **Four of its five claims are false.** This section exists so the
same investigation is never run twice.

### 8.1 Claim-by-claim verdict

| Audit claim | Verdict | Evidence |
|---|---|---|
| "There are no canonical tags" | **FALSE** | `rel=canonical` emitted on every page from `layouts/partials/seo/enhanced-meta-tags.html:71` via `themes/beaver/layouts/baseof.html:9`. GSC `inspect_url` returns a matching `user_canonical` on every URL tested. |
| "Zero structured data on any page we crawled" | **FALSE** | Organization, Service, FAQPage, Article and BreadcrumbList all live. GSC rich results **PASS**, detected types `Breadcrumbs` + `Review snippets`. |
| "Meta description is basically a shrug / lazy placeholder" | **FALSE** | Descriptions are specific and page-tailored throughout. |
| "No canonical tag - duplicates haunt you" | **FALSE** | `www.jetthoughts.com` → 301 → apex; `http://` → 301 → `https://`. No duplicate-host drift. |
| "Copy uses the exact same phrases as the agencies they claim to replace" | **TRUE** | Substantiated and expanded in `20.09` §11. |

#### Root cause of the false negatives

`config/_default/hugo.toml:65` sets `minifyOutput = true`. Hugo's minifier drops quotes on attribute
values that contain no spaces:

```
rel=canonical                (not rel="canonical")
name=description             (not name="description")
type=application/ld+json     (not type="application/ld+json")
```

Every check the tool failed (M, C, SCHEMA) matches a **quoted attribute**. Every check it passed (T, H1)
reads **element content**. That mapping is exact - its parser is regex-based and requires quotes. The
output is valid HTML5 and Google parses it correctly, which GSC confirms.

**Action #9 (`keepQuotes = true`) is a cosmetic hedge against naive third-party parsers, not an SEO fix.**
The argument for it is commercial, not technical: JT sells technical credibility, and a prospect running
any free audit tool currently sees "invisible to AI assistants". Cost is ~1-2% page weight.
Note `config/test/hugo.toml:11` sets `minifyOutput = false`, so **the test suite cannot verify #9** - it
needs a `hugo --environment production` build and a byte-size comparison (homepage baseline: 124,256 B).

### 8.2 What the audit missed - fabricated review markup

The audit asked only "is schema missing?", never "is the schema that exists honest?". It is not.

`themes/beaver/layouts/partials/seo/comprehensive-service-schema.html:101-157` publishes, on all 12
`/services/` pages:

- `aggregateRating` of **4.9 / 23 reviews**
- Two `Review` objects authored by **"Technology Executive" (CTO)** and **"Startup Founder" (CEO)** -
  non-existent people, with `reviewBody` text generated per service via `printf`, hardcoded
  `datePublished` of `2024-11-15` / `2024-10-22`, and 5/5 ratings.

Separately, `themes/beaver/layouts/partials/seo/enhanced-organization-schema.html:83-88` emits a
hardcoded `aggregateRating` of **4.8 / 32** site-wide across ~1,147 URLs. Service pages therefore
publish **two contradictory ratings at once**.

**Exposure**: Google's structured-data policy prohibits fake and self-serving reviews; a manual action
strips rich results **domain-wide**, so §4's "service pages get 1 click / 90 days" does *not* reduce the
risk. The FTC Rule on Consumer Reviews and Testimonials also covers fabricated testimonials. It further
breaks this repo's own standing rule - *"Zero unsupported claims: all assertions must have citations."*

`grep -rn aggregateRating test/` returns nothing, so action #7 is a pure deletion with no test to update.

**Decision taken 2026-08-13 (Paul):** remove the fabricated block only; keep `4.8 / 32` and the real
named-client reviews from `data/testimonials.yaml`.

**Residual risk, recorded deliberately:** Google disallows self-serving review markup about the
organization on the organization's own site regardless of whether the numbers are true. And
`reviewCount: 32` has no provenance in the repo - the only source is `data/company.yaml:11`,
*"Top-rated on Clutch.co (4.8/5 rating)"*, which carries a rating but **no count**. Action #8 resolves
this; if Clutch shows a different count, JT is publishing a wrong number.

### 8.2b Resolution (2026-08-14) - actions #7-#9 closed

**Action #8 found a real defect.** The live Clutch profile shows **4.8 out of 5
from 9 reviews**. The rating was correct; `reviewCount: 32` was overstated ~3.5x
and was published in structured data on ~1,147 URLs. It is now `9` in
`enhanced-organization-schema.html`, with the source URL and verification date in
a comment. On the marketing pages the count is gone entirely and the rating links
to the Clutch profile - a linked rating beats a bigger unlinked number, which is
20.09 §11's thesis.

Note `data/course_banned_strings.yaml:65` already bans "4.8/5" in course content
as a *"volatile third-party review score"*. The course side had learned this; the
marketing side had not.

**Action #7** - `comprehensive-service-schema.html:101-157` deleted. Verified in a
production build: `/services/fractional-cto/` now carries only the sourced 4.8/9,
no invented authors, and no contradictory 4.9.

**Action #9** - `keepQuotes = true` added. Verified against a production build:
`rel="canonical"`, `name="description"`, `type="application/ld+json"` all quoted.
Homepage 124,256 → 125,988 bytes (+1.4%).

**Gate gap found while doing this**: the default screenshot tolerance is 2%
(`test/application_system_test_case.rb:87`), so a four-word link change (~0.24% of
the frame) passes without re-recording the baseline. A green visual suite means
"no change larger than 2%", not "no change". Recorded in `.okf/build/test-gates.md`.

### 8.3 Also unsourced (out of scope, logged)

Same file, `additionalProperty` block: `Client Retention Rate 95%`, `Success Rate 92%`,
`Years of Experience 13+` are published as schema `PropertyValue` with no cited source.
`content/pages/about-us/index.md:27` claims *"95% client retention rate—highest in the industry for
development agencies"* - a superlative with no source. Fold into action #8 when it runs.
