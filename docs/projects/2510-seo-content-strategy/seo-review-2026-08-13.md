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

### What is explicitly *not* recommended
- New content for SEO reasons. At ~5 clicks/day and declining positions, publishing volume is not the constraint.
- Technical SEO work. Sitemap is clean (1,147 URLs, 0 errors), key pages return `PASS` on inspection, schema validates. This is not a crawlability problem.
- Chasing the position 13 → 20 decay with on-page fixes until #2 is done. Without trustworthy numbers there is no way to tell a fix from noise.

---

## 7. One-line summary for the OS weekly

> Organic is ~5 clicks/day and positions slid 13 → 20 since April; the "5k sessions"
> baseline is ~90% bot traffic and conversions are untracked. Fix measurement (2h),
> then leave SEO alone until outreach is unblocked.
