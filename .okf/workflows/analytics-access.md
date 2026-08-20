---
type: Playbook
title: Analytics access (GA4 + Search Console MCP)
description: How an agent session queries live GA4 and Search Console data for jetthoughts.com - the two local MCP servers, which property IDs are correct, why the two servers cannot share credentials, and the data-lag/duplicate-property traps.
tags: [analytics, ga4, search-console, mcp, seo, tooling]
generated:
  by: claude/opus-5
  at: 2026-08-13T00:00:00Z
verified:
  - by: claude/opus-5
    at: 2026-08-13T00:00:00Z
  - by: claude/opus-5
    at: 2026-08-13T09:56:20Z
  - by: claude/fable-5
    at: 2026-08-17T14:30:00Z
  - by: claude/opus-5
    at: 2026-08-20T00:00:00Z
status: stable
sources:
  - resource: "/content-strategy/content-plan.md"
    title: "content-plan"
---

Until 2026-08-13 all GSC analysis ran off hand-downloaded CSV exports (see the
`jetthoughts.com-Performance-on-Search-2026-07-19/` citation in
[content-plan](/content-strategy/content-plan.md)). Two local MCP servers now
serve the same data live, so re-pulling a date range is a query, not an export.

# The two servers

Registered at Claude Code **user scope** (`~/.claude.json`), so they load in
every repo and every worktree - not just the one they were added from. Both run
through `uvx`; there is nothing vendored in this repo and nothing to install.

| Server | Command | Credential |
|---|---|---|
| `google-analytics` | `uvx analytics-mcp` | gcloud ADC at `~/.config/gcloud/application_default_credentials.json` |
| `gsc` | `uvx mcp-search-console` | own OAuth client at `~/.config/google-mcp/client_secrets.json`; token cached at `~/Library/Application Support/mcp-gsc/token.json` |

GCP project `snippets-454308` has `analyticsdata`, `analyticsadmin`, and
`searchconsole` enabled. Credential files live outside the repo by design and
must never be committed - this repo is public.

# Which property to query

**TL;DR: GA4 property `328508492`. Do not enumerate properties first - query
this one directly.**

Both accounts carry several overlapping properties. Picking the wrong one
silently returns real-looking but wrong numbers.

* **GA4** - account `10749382` (JetThoughts). The site is property
  **`328508492`** ("Home Page - GA4"). `315618854` ("Blog - GA4") and
  `332322607` ("jetthoughts-blog") are separate and are NOT the site total.
  Re-confirmed 2026-08-17: LinkedIn/course-page sessions appear ONLY on
  `328508492`; the same query against `315618854` returns zero rows.
* **LinkedIn attribution trap (2026-08-17):** clicks from LinkedIn land as
  `linkedin.com / (referral)` with an empty campaign even when the staged
  first-comment link carries UTM - either the live comment was posted with a
  bare link or readers arrive via the profile. Before concluding "no campaign
  traffic", query by `sessionSource CONTAINS linkedin`, not by
  `sessionCampaignName`; and verify the live comment's link actually kept its
  UTM.
* **Search Console** - use **`sc-domain:jetthoughts.com`**. The URL-prefix
  properties (`https://jetthoughts.com/`, `https://www.jetthoughts.com/`) each
  cover only part of the traffic. `jtway.co`, `elital.jetthoughts.com`, and
  `execshub.jtway.co` are different sites.

# Traps

* **The two servers cannot share one credential.** gcloud's built-in ADC OAuth
  client may request `analytics.readonly` (a normal scope) but Google blocks it
  for `webmasters*` (a sensitive scope) - `gcloud auth application-default
  login --scopes=...webmasters...` fails with "This app is blocked". GSC
  therefore needs a self-owned **Desktop** OAuth client with the Google account
  added under Audience -> Test users; Testing mode grants sensitive scopes with
  no app-verification review. The "Google hasn't verified this app" interstitial
  is expected (Advanced -> Go to (unsafe)).
* **`GSC_CREDENTIALS_PATH` takes service-account files only.** It loads via
  `from_service_account_file`; an authorized-user ADC file will not load there.
* **Never set `GSC_OAUTH_CLIENT_SECRETS_FILE` to a path that does not exist** -
  the server fail-fasts on it before ever reading its cached token, so a
  speculative value breaks an otherwise-working token.
* **GSC data lags ~2-3 days.** Query windows must end ~3 days back or the tail
  reads as zero-traffic days that are really just unreported.
* **ADC with no `quota_project_id`** only produces a gcloud warning; GA calls
  still succeed on per-user quota. Silence it with `gcloud auth
  application-default set-quota-project snippets-454308` - safe here only
  because that project already has the three APIs enabled. Pointing a quota
  project at a project where the API is disabled turns working calls into
  `SERVICE_DISABLED` 403s.
* **Servers registered mid-session are not usable in that session** - Claude
  Code must restart before their tools load.

# Reading the numbers (added 2026-08-13 after the first full review)

Both servers return data that is *technically* correct and *analytically*
misleading unless these two corrections are applied first.

## GA4 sessions are ~85-90% bots - always reconcile against GSC

Property `328508492` reported **1,628 `google / organic` sessions** for
2026-07-14..08-10. GSC reported **~130 Google clicks** for the same window.
A 12x gap is not reporting lag; the GA4 number is bot traffic.

The tell is engagement, not volume:

| Source | Sessions | Engagement rate | Avg session |
|---|---|---|---|
| google / organic | 1,628 | **11.8%** | 34s |
| duckduckgo / organic | 77 | 68.8% | 370s |
| bing / organic | 48 | 66.7% | 425s |
| (direct) / (none) | 4,071 | 31.0% | 21s |

Humans arriving from search engage at ~67% (Bing, DDG - too small to be worth
faking). Anything at 12-31% for 21-34 seconds is automated. Corroborating:
`first_visit` 5,515 of 5,885 `session_start` (94% brand-new users) and 170
`scroll` events against 6,392 `page_view`s.

**Rule: never quote a GA4 organic-sessions figure without diffing it against
GSC clicks for the same window.** Real search traffic is GSC clicks plus
Bing/DDG sessions - about **255 sessions / 28d**, not the ~5k the GA4 number
implies. The "1,445 sessions / last 7 days" figure recorded in this file at
setup is that inflated number; treat it as a bot-volume datapoint, not traffic.

## `sc-domain:` impressions are polluted - review on the prefix property

One page on a different site under the same domain property -
`elital.jetthoughts.com/blog/mastering-your-upwork-login...` - contributed
**14,438 impressions and 2 clicks** in 28 days: 14% of all domain impressions
against 1.4% of clicks. Site-wide CTR computed from `sc-domain:` is therefore
not a usable metric, and the "six-figure impressions at 0.14%" shape is mostly
that one post plus long-tail quoted-code queries (`"@@defaults = *args" ruby`)
that can never convert.

Use `sc-domain:jetthoughts.com` for *coverage* questions (what exists, what is
indexed); use the `https://jetthoughts.com/` prefix property, or a
`page notContains elital` filter, for any *performance* question.

## There is no conversion tracking

GA4 `keyEvents` = **0**. The full 28-day event inventory is `page_view`,
`session_start`, `first_visit`, `user_engagement`, `scroll`, `click` (4 total),
and 9 `course_*` events. No form submit, no contact-CTA click, no booking. Any
question of the form "did traffic convert" is currently unanswerable from GA4.

**Update 2026-08-20 — `keyEvents` is now non-zero and still means nothing.**
A 56-day pull returns 4,063 key events: `page_view` has been marked a **key
event** in the GA4 admin since the 2026-08-13 audit. The underlying inventory is
unchanged — still no form submit, no `generate_lead`, no booking; `click` is 9
in 56 days. This is worse than the zero it replaced, because a non-zero
conversion count that counts page views reads as conversions to anyone who does
not check the event behind it. **Never quote `keyEvents` or "conversions" from
this property without listing the events behind the number.** Fix queued as
2608 Phase 0.1 (un-mark `page_view`, add `generate_lead` on form submit).

**Update 2026-08-20 (later) — `contact_cta_click` is now marked a key event.**
Done through the GA4 UI in Chrome. `page_view` is **still marked**, so the
caveat above stands in full: until it is un-marked, any real contact-CTA
conversion is buried under thousands of page-view "conversions". Un-marking
`page_view` was deliberately **not** done here - it changes how a headline
metric reads and belongs to 2608 Phase 0.1, not to this request.

### Which browser channel you have decides whether it's doable *this session*

Follow-up to the above, 2026-08-20: the UI path is right, but it needs an
**authenticated** browser. Two channels exist and they are not equivalent:

| Channel | GA session |
|---|---|
| `claude-in-chrome` extension | drives Paul's real Chrome - **signed in**, this is the one that worked for #495 |
| `chrome-devtools` MCP | a separate Chrome-for-Testing profile - **signed out**; `analytics.google.com` redirects to `accounts.google.com` |

If the extension reports "Browser extension is not connected", the GA UI is
genuinely out of reach for that session and the honest report names *that*
(with the fix: connect the extension / restart Chrome), not "console-only,
Paul's". Never sign in to reach it - entering credentials is prohibited, and
the block is the channel, not the task.

### Marking a key event is an agent-doable UI task, not an Admin-API task

Recorded because the opposite was asserted twice in one session. The read-only
Data API cannot mark key events, and it is tempting to conclude the job needs
Paul. It does not:

**Admin → Data display → Events → Create event → "Create with code"** takes an
event name plus a **Mark as key event** toggle, and needs **no already-received
data**. The star on the Events list is the path that requires data - which is
why this looked blocked: `contact_cta_click` had fired zero times, having
shipped the same day.

Two traps in that dialog:

- It **pre-selects a $1 default key-event value.** Accept it and every click
  books phantom revenue. Choose "Don't set a default key event value" unless
  the event genuinely carries money.
- Counting method defaults to **"Once per event"** (GA4's recommendation). Keep
  it for intent metrics: per-event preserves the raw signal and reporting can
  dedupe to sessions later, but it cannot un-dedupe.

**Do not fire a synthetic event to unblock the star.** For a conversion whose
true count is zero, a QA-origin first data point is undeletable and reads as a
real conversion forever. Wait for real traffic, or use the create-with-code
path above, which needs no data at all.

## No A/B test can reach power here — do not design one

Falls directly out of the bot correction above. Measured 2026-08-20 on the
prefix property, 28 days: **145 Google clicks (5.2/day)** — desktop 103 /
mobile 41 / tablet 1. Plus Bing+DDG (~4.5/day) that is **~9.7 human
sessions/day**, against the ~300/day the raw GA4 number implies.

Sample size per arm at α=0.05, power 0.80, n ≈ 16·p(1−p)/δ²:

| Metric | Baseline | Effect | Sessions | Days at ~9.7/day |
|---|---|---|---|---|
| Blog index → post CTR | 30% | +20% rel. | 1,866 | **192** |
| Scroll-to-CTA reach | 25% | +20% rel. | 2,400 | **247** |
| Lead conversion | 1% | +50% rel. | 12,672 | **~3.6 years** |

**Device split is the other finding worth carrying:** desktop is 94% of
impressions (94,364) but 0.11% CTR; mobile is 6% (6,262) at 0.65% CTR and a
better average position (16.6 vs 20.5). Desktop impressions are long-tail
queries that never convert; the humans who actually arrive skew mobile. Weight
mobile at least as heavily as desktop in any design or content review.

Even the cheapest engagement metric needs five months. **A/B testing is not
available on this site** — the trap is sizing a test on the raw GA4 figure,
which makes an 8-day run look feasible and would in fact be measuring bots.
Revisit only above ~200 human sessions/day sustained. Full reasoning and the
replacement gates: `docs/adr/0004-static-site-experimentation.md`.

# Baseline at setup

Recorded 2026-08-13 so later pulls have something to diff against. Read it with
the corrections above.

| Source | Window | Numbers |
|---|---|---|
| GA4 `328508492` | last 7 days | 1,445 sessions (**bot-inflated - not traffic**) |
| GSC `sc-domain:jetthoughts.com` | 2026-07-14 .. 2026-08-10 | 142 clicks, 104,754 impressions, 0.14% CTR, avg position 18.1 |
| GSC, excluding `elital.` | 2026-07-14 .. 2026-08-10 | ~122 clicks - the real site number |

Top queries in that window: `jetthoughts` (10 clicks / 23 impressions),
`rails install dependencies` (10/55), `langchain tutorial` (2/137),
`datadog laravel` (1/12), `falcon ruby` (1/27).

**Trend worth tracking**: average position decayed 14.7 (Feb) -> 13.0 (Apr) ->
18.5 (Aug), monotonic and independent across top pages. That decay, not CTR, is
the live signal - site-wide CTR is unreliable for the reason above. Full
analysis: `docs/projects/2510-seo-content-strategy/seo-review-2026-08-13.md`.
