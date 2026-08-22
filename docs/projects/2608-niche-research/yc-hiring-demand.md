# YC / Hacker News hiring demand as a signal for JetThoughts

Research date: 2026-08-22. Author: yc-hiring research agent.

**Method.** Every number below marked *(counted)* comes from parsing the raw HN Algolia API
(`hn.algolia.com/api/v1/items/<id>`) for 30 consecutive "Ask HN: Who is hiring?" threads
(2024-03 → 2026-08), 20 "Who wants to be hired?" threads (2025-01 → 2026-08), and 17
"Freelancer? Seeking freelancer?" threads. Live top-level comments only (dead/deleted and
sub-40-character stubs dropped): **9,631 job posts** and **8,386 candidate posts**. Matching is
regex over post text, so it carries known biases — see *Evidence quality* at the end.

---

## 1. The headline: the channel itself is contracting

*(counted)* Live top-level job posts per thread, August-to-August:

| Aug 2024 | Aug 2025 | Aug 2026 |
| --- | --- | --- |
| 324 | 305 | 240 |

That is **-21% year over year and -26% over two years**. Meanwhile the candidate side is going the
other way — "Who wants to be hired?" grew from 366 posts (Jan 2025) to **581 (Aug 2026), +59%**.

Demand down a quarter, supply up sixty percent, in the same forum, over twenty months. Every
niche below has to be read against that scissor.

### Stack frequency, 12-month aggregates *(counted)*

Share of job posts mentioning each stack. Two non-overlapping 12-month windows:

| Stack | Sep 2024 – Aug 2025 | Sep 2025 – Aug 2026 | Change |
| --- | --- | --- | --- |
| TypeScript / JS | 30.59% (1191/3894) | 32.97% (1275/3867) | +2.39pp |
| Python | 23.06% (898) | 24.28% (939) | +1.22pp |
| Go | 8.71% (339) | 8.04% (311) | −0.66pp |
| Rust | 7.09% (276) | 7.96% (308) | +0.88pp |
| **Ruby or Rails** | **4.49% (175)** | **3.93% (152)** | **−0.56pp** |
| Rails (strict) | 3.93% (153) | 3.28% (127) | −0.64pp |
| Java / Kotlin | ~5% | ~4.5% | flat |
| PHP | ~1.2% | ~1.2% | flat |
| Elixir | ~1.1% | ~1.0% | flat |

The one large mover is not a language. **AI/LLM mentions went from 16.44% to 24.44% of all posts,
+8.00pp** — five times the movement of any stack. In the most recent six months, 57.6% of posts
mention AI at all and 15.0% are companies whose *product* is AI.

---

## 2. Where Rails actually stands (the honest answer)

**Verdict: Rails is a small, slowly shrinking, but structurally normal niche. It is not collapsing,
and it is not an asset that differentiates JetThoughts either.**

The case for calm:

- Rails demand is **down 16% relative** (3.93% → 3.28% of posts) over two 12-month windows. That is
  a drift, not a cliff. Elixir and PHP moved less; Go moved about the same amount downward.
- On the metric that actually matters for a supplier — candidates per open role — **Rails is
  slightly tighter than the market.** *(counted, Aug 2026)*: 13 Rails job posts against 55 Rails
  candidates = **4.2 candidates per role**. Python: 65 jobs / 344 candidates = 5.3. TypeScript/JS:
  75 / 359 = 4.8. Rails is not uniquely oversupplied; the whole HN market is roughly 5:1.
- Rails companies that post here are real and durable: Chronograph ($175–215k, remote US, posting
  across 9 months), Scribd ("one of the largest Ruby on Rails sites"), Rail Europe, Clio, Scholarly,
  Relevant Healthcare, Triumph Financial, Apex Dental Partners (Rails 8 + React), Y Combinator's own
  team. Rails is running load-bearing systems at funded companies.

The case for alarm, which is the stronger case:

- **Absolute volume is tiny: 11–13 Rails posts per month** out of 240–330. Across the entire most
  recent six months there were **60 Rails posts total** *(counted)*.
- **Rails candidates are 10.0% of all job seekers (835 of 8,386) while Rails jobs are 3.9% of all
  posts.** The bench JetThoughts owns is 2.5x over-represented in the applicant pool relative to
  demand. Supply of senior Rails contractors is abundant and visible to every buyer.
- Rails appears in **3 contract-shaped posts in six months** *(counted)*. See §3.

The bench is neither an asset nor a liability on its own. It is a **commodity in a shallow pool**.
What it cannot do is generate demand — nobody is going to pick JetThoughts because it has Rails
people, because so does everyone applying.

---

## 3. Contract versus employee — this is the finding that matters most

### 3a. The main thread is an employee-hiring board, near-totally

*(counted, share of job posts)*

| Signal | Sep 2024–Aug 2025 | Sep 2025–Aug 2026 |
| --- | --- | --- |
| Strong contractor markers (contractor / contract role / freelance / fractional / 1099 / C2C / staff aug) | 2.95% (115) | **2.46% (95)** |
| Any occurrence of "contract"-family words (very loose) | 10.17% | 10.16% |
| Full-time markers (salary / equity / benefits / 401k / employee) | ~74% | ~71% |

In the most recent six months: **50 contractor-shaped posts out of 1,793 (2.8%)**, and only **3 of
those also mention Rails (0.2%)**.

JetThoughts' addressable slice of the HN main thread is on the order of **one to two posts per
month**, and the contract share is *falling*, not rising.

### 3b. The freelancer thread — HN's contract channel has effectively died

This is the single hardest fact in the report.

*(counted, verified against thread authorship)* The official `whoishiring` bot **stopped posting
"Ask HN: Freelancer? Seeking freelancer?" after 2025-10-01**. Its last official thread is
[45438502](https://news.ycombinator.com/item?id=45438502). Two separate community posts asked where
it went: [45804464](https://news.ycombinator.com/item?id=45804464) (Nov 2025) and
[46167746](https://news.ycombinator.com/item?id=46167746) (Dec 2025).

A community member (`jon_north`) has hand-posted a replacement monthly since Jan 2026. Volume
collapsed:

| Era | Comments per thread |
| --- | --- |
| Official (`whoishiring`), sampled 2024-08 → 2025-10 | 111–198 |
| Unofficial (`jon_north`), 2026-01 → 2026-08 | **15–33** |

And the demand/supply split inside those threads was catastrophic **even in the good era**
*(counted, by "SEEKING FREELANCER" vs "SEEKING WORK" headers)*:

| Era | Threads | SEEKING FREELANCER (demand) | SEEKING WORK (supply) | Ratio |
| --- | --- | --- | --- | --- |
| Official, 7 sampled threads | 7 | **30** | 881 | 1 : 29 |
| Unofficial, 2026 | 8 | **4** | 169 | 1 : 42 |

Across **all eight months of 2026 there were four companies seeking a freelancer on Hacker News.**
Of the 30 demand posts in the official-era sample, **5 mentioned Rails**.

Spillover into the main thread has not happened either: exactly **1 post in 1,793** (Mar–Aug 2026)
used a "SEEKING FREELANCER" header.

**Conclusion: Hacker News is not a contract-demand channel and never really was.** It is a supply
board for freelancers with almost no buyers on it. Any plan that involves JetThoughts finding
contract work by reading or posting in HN freelancer threads should be killed outright.

---

## 4. Seniority, remote and timezone — the two things that go JT's way

**Seniority** *(counted)*. Senior/staff/principal markers appear in **48.95% of posts (Sep 2025–Aug
2026), up from 45.92%**. Junior/new-grad/intern sits at ~3.8% and is flat. August 2026 breakdown:
Senior 42.9%, Staff/Principal 18.3%, Lead/Manager 11.2%, Mid 2.9%, Junior 2.9%.

The market has moved further toward senior. JetThoughts only sells senior. This is genuine
alignment and it is strengthening.

**Remote and timezone** *(counted, Mar–Aug 2026, n=1,793)*:

| Signal | Share |
| --- | --- |
| Mentions remote | 53.7% |
| US-restricted (US-only / US-based / US work authorisation / citizen) | 10.7% |
| Europe / EU / EMEA / CET mentioned | 13.8% |
| Worldwide remote | 3.6% |
| Names offshore-friendly geos (LATAM, India, Poland, Ukraine, Serbia…) | 3.8% |
| Explicitly no visa sponsorship | 1.5% |

A European team is **not** structurally locked out: only about one post in ten carries a hard US
restriction, and 13.8% name Europe positively. Concrete Rails examples open to Europe in the last
six months: AREO (Remote EU / Bremen), Hellotext (Remote LATAM/EU), Missive (Eastern Americas to
Central Europe), TrakPro (overlap with Ireland 9–5 GMT), Rail Europe (Paris + remote), Mainmatter
(Remote EU). Note that these are *European-rate* employers — TrakPro's senior Rails role pays
**€48–60k/yr**, which is the pay floor the "sell west" thesis exists to avoid.

---

## 5. Reposted roles — the list, and why it is weaker evidence than it looks

*(counted)* Company names extracted from the first pipe-delimited segment of each post (HN
convention), normalised, matched across 30 months. 3,868 distinct company names; 2,373 (61%)
appeared in only one month.

**Month-over-month repeat rate is stable at 33–42%.** For August 2026 specifically, of 226
name-extractable posts: 32.7% had also posted the previous month, 18.6% had posted 3+ consecutive
months, 10.6% 6+, 4.9% 12+. Median consecutive run: **1 month**.

### Longest unbroken runs still live in Aug 2026

| Months consecutive | Company |
| --- | --- |
| 30 | PlantingSpace (Remote, EU timezone) |
| 25 | MONUMENTAL |
| 21 | DuckDuckGo |
| 20 | Coder |
| 19 | Temporal Technologies |
| 16 | Spacelift |
| 15 | Stellar Science · Category Labs |
| 14 | Better Stack |
| 13 | OpenRent (London) |
| 12 | PostHog |
| 11 | MixRank · Baton |
| 9 | Starbridge · Estuary |
| 8 | PermitFlow · LiveKit |
| 7 | ML6 · LAGO · FusionAuth |

### Rails-specific repeat posters (months in which their post mentioned Rails)

| Company | Rails posts | Window |
| --- | --- | --- |
| SerpApi | 23 | 2024-03 → 2026-07 |
| Aha! | 15 | 2024-03 → 2026-04 |
| ChartMogul | 15 | 2024-03 → 2025-08 |
| Prophet Town LLC (agency) | 11 | 2025-01 → 2026-08 |
| Chronograph | 9 | 2024-04 → 2026-08 |
| Scholarly | 9 | 2024-06 → 2026-06 |
| AREO | 8 | 2024-12 → 2026-08 |
| Resemble AI | 8 | 2024-06 → 2025-11 |
| OneSignal · Sitewire · Y Combinator · Costa Security · Archie | 7 each | various |
| Scribd · Great Question | 6 each | 2025-01 → 2026-06 |
| Hellotext · Combinaut | 5 each | 2024-07 → 2026-06 |
| Opendate · Recital · Yardstik · Clio · Found · ID.me · Carebit | 4 each | various |
| Relevant Healthcare · Apex Dental Partners · Rootly · Triumph Financial · FetLife · Opendate | 3 each | mostly 2025-11 → 2026-08 |

Two that are genuinely worth a look, because a technical buyer signs the post and the role has
visibly failed to close:

- **AREO** (goareo.com, Bremen + Remote EU, grocery-retail SaaS). CTO Marius posts personally.
  Has been advertising *Engineering Manager (Ruby on Rails)* and *Lead Product Engineer (Ruby on
  Rails)* across 8 separate months from 2024-12 to 2026-08. A leadership Rails role open for 20
  months is a real, unclosed gap.
- **Relevant Healthcare** (~25 people, Remote US/Canada, safety-net clinic data platform). Posted
  "Software Engineers (multiple levels)" through mid-2026, then **escalated to "Lead Software
  Engineer" in Aug 2026** — the shape of a team that failed to hire down-stack and is now trying
  to buy seniority instead.

Also durable and Rails-carrying: **Chronograph** (private-capital analytics, Platform Engineer,
$175–215k, remote US, 9 months), **Sitewire** (construction finance, head of engineering posts
personally, profitable, 7 months, $130–200k remote US), **Opendate** (live-music ticketing, Senior
Full Stack Rails, remote US).

### The caveat that guts this section

*(counted, Mar–Aug 2026)*: posts containing explicit "still looking / reposting / as mentioned last
month" language: **8 of 1,793 (0.4%)**. Urgency language ("urgent", "ASAP", "tight deadline"):
**8 (0.4%)**. Capacity-gap language ("more hands", "can't find", "struggling to hire"): **3 (0.2%)**.

So: companies repost, but they almost never *say* they are stuck. Reposting on HN is largely a
recruiting-marketing habit — DuckDuckGo and PostHog have posted for 21 and 12 straight months and
are obviously not desperate. **A long run is a signal of a standing recruiting budget, not of pain.**
Treat the repost list as a lead list to qualify, never as evidence of distress.

---

## 6. What problems recur in the descriptions *(counted, Aug 2026 vs Aug 2025)*

| Theme | Aug 2025 | Aug 2026 |
| --- | --- | --- |
| Scaling / high traffic | 25.6% | 24.6% |
| AI/LLM being built into the product | 22.3% | 21.2% (12-mo trend +8pp, see §1) |
| Migration / legacy / monolith / tech debt / rewrite | 3.6% | 6.2% |
| "More hands", growing team, first eng hire | 3.3% | 2.5% |
| Deadline / urgent | 0.3% | 0.8% |

Migration and legacy work nearly doubled off a small base. It is the only *problem* theme trending
up, and it is the one shape that a senior Rails extension team is straightforwardly good at
(ResortPass rewriting 75% of its site; Scribd running one of the largest Rails codebases in
existence; Treasure AI on Fluentd/Embulk roots; Apex Dental on Rails 8).

---

## 7. Candidate niches the data supports

### Niche A — Rails-carrying agencies and consultancies, as a supplier to them

**Buyer:** the founder or head of delivery at a boutique agency who already owns the client
relationship and is short of senior hands.

**What they would buy:** senior Rails contractors billed into their existing client engagements —
exactly JetThoughts' proven motion (Crosslake), where supply is the product and demand is someone
else's problem.

**Evidence** *(counted, Mar–Aug 2026)*: **95 posts (5.3%) use agency/consultancy/client-work
language; 62 distinct agency-shaped posters in six months.** Named, with their own words:

- **Prophet Town LLC** — "a people-first, boutique tech agency creating **on-demand teams** and
  software solutions for long-standing clients"; stack explicitly includes Ruby on Rails; posted in
  16 of 30 months, 11 with Rails; clients include Anduril and Voltage Park.
- **Blackbird** — "Dev Shop | Remote (US) | **Contract**".
- **Substantial** — "technology consulting company … **Contract** (potential for full-time)".
- **Viteus** — "**Contract** Engineer Opportunities — AI Production Support … REMOTE | Contract".
- **Yidi's Consulting** — "4-person boutique consulting shop … **Contract-to-hire | $40/hr** |
  LATAM/EU time zones welcome".
- Plus Level 12, Fusionbox, Pelotech, Solution Street, Innolitics, thelab, In The Loop, LightSight,
  Fractional AI, Quantum Rise, We The Flywheel, Common Prefix, Aptira, Mainmatter (Remote EU),
  Virtasant (self-described "staffing" company).

**JT fit:** very high on motion — this is the one shape JetThoughts has actually been paid for
repeatedly. The buyer is technical, already sold the work, and feels the pain on the P&L when a
project is understaffed. It satisfies the "pain lands on the chequebook holder" test.

**Kill risk — and it is serious.** Three problems, in order of severity:

1. **The rate.** Yidi's Consulting is advertising **$40/hr** for a senior full-stack contract-to-hire
   with EU timezones welcome. That is the agency-subcontract clearing price visible in this data,
   and it is a fifth of the $150–225/h US senior Rails client rate. Selling *to* agencies means
   accepting bench margin, not client margin. This directly contradicts the "sell west at
   $150–225/h" thesis — that rate belongs to the party that owns the client, and in this niche that
   party is not JetThoughts.
2. **They are hiring employees, not buying capacity.** Prophet Town advertises "$150K–$260K annual
   total comp", full-time. Most of the 62 are recruiting staff, not shopping for a subcontractor.
   The post is evidence they need capacity; it is not evidence they will buy it from a firm.
3. **They are not short of applicants.** Prophet Town's own May 2026 update: *"203 total responses —
   thank you. We made one hire."* An agency drowning in 203 applicants does not have a supply
   problem that JetThoughts solves. It has a *filtering* problem. If JetThoughts sells anything
   here, the product is pre-vetted senior capacity that skips the 203-CV pile — a different pitch
   from "we have Rails developers", and one that has to survive contact with a buyer who thinks
   hiring is free.

**Verdict:** the right *buyer shape*, the wrong *price*. Worth testing only if the pitch is framed
as de-risked, immediately-billable capacity at a defensible day rate — not as bodies.

### Niche B — Small Rails product teams with a senior role that has failed to close for 6+ months

**Buyer:** a CTO, head of engineering, or founder at a 5–30-person funded product company whose
Rails codebase is load-bearing and whose senior role has been open for two or more quarters. They
sign the HN post themselves — AREO's post is literally "My name is Marius and I am the CTO".

**What they would buy:** a senior Rails engineer (or a pair) embedded into the existing team on a
monthly retainer, covering delivery while the search continues or replacing the search entirely.

**Evidence** *(counted)*: named companies with repeated Rails posts and a technical signatory —
AREO (8 months, EM + Lead Product Engineer, both Rails, 2024-12 → 2026-08), Relevant Healthcare
(escalating multiple-levels → Lead in Aug 2026), Chronograph (9 months, $175–215k), Sitewire
(7 months, head of engineering posting), Scholarly (9 months, $160–200k on-site Seattle), Opendate,
Apex Dental Partners, Hellotext, Triumph Financial. Supporting trend: senior share of the market
rose to 48.95%, and migration/legacy problem language nearly doubled to 6.2%.

**JT fit:** high on capability — this is senior Rails extending an existing team, which is exactly
the stated product, and the buyer is technical, which matches every client JetThoughts has ever had.
The AI-on-Rails variant is the growth edge: Opendate ("pushing the boundaries of AI-assisted
software development"), Hellotext (Rails + AI automation over WhatsApp/SMS), Apex Dental ("Rails 8 +
React, pushing hard on automation and AI"), Rootly (AI-native, Rails). This is API-wiring work on a
Rails codebase, **not** ML engineering — it needs no data or ML specialists, so it is inside the
bench's actual capability.

**Kill risk:**
1. **Volume.** 11–13 Rails posts per month, of which maybe two or three fit this profile. The
   entire monthly top-of-funnel from this channel is single digits. It cannot be the only channel.
2. **No forcing function.** JetThoughts' own rule is that money moves when a third party forces it.
   A role open for 20 months is, by definition, a company that has tolerated the gap for 20 months.
   Nobody is forcing AREO to close it. Absent a board, a customer contract, or a funding milestone
   creating a deadline, these convert slowly or not at all.
3. **They want an employee with equity.** Scholarly offers "$160k–$200k + equity + health benefits".
   Converting that budget line into an agency retainer requires the buyer to first admit the hire
   has failed — a concession people resist for exactly the 20 months the data shows.
4. **Several are European-rate.** AREO (Bremen), TrakPro (€48–60k), Rail Europe, Mainmatter. Selling
   into these is the opposite of the "sell west" thesis.

**Verdict:** the strongest *capability* match in the data, and the only one where the pain sits with
a technical buyer who can approve spend. But it is low-volume and lacks a forcing function, so it
should be run as targeted outbound against a named list — not as a channel to wait on.

### Niches the data does not support (recorded so they are not re-proposed)

- **Freelance marketplaces / HN freelancer threads.** Four buyers in eight months (§3b). Dead.
- **JavaScript, DevOps, data or ML specialisation.** TS/JS is the largest and growing category
  (33.0%) and AI is the fastest mover (+8pp), but the bench has none of these people. Chasing this
  demand means building a bench JetThoughts does not have, against the deepest supply pool there is.
- **Junior or mid-level capacity.** 3.8% of the market and flat.

---

## 8. Evidence quality

**What I counted myself, from primary data:** all stack frequencies, contract/full-time shares,
seniority shares, remote/geo shares, problem-theme shares, thread-volume trends, repeat-poster runs,
the candidate-supply figures, and the freelancer-thread demand/supply split. Source is the HN
Algolia API, thread IDs listed in the analysis scripts. Anyone can re-run it.

**Known biases in my counting, stated plainly:**

- Matching is **regex over post text, not comprehension**. "Rails" counts a post that merely lists
  Rails among six stacks the same as one hiring a dedicated Rails engineer. This *inflates* the
  Rails share, meaning the true picture is likely a little worse than 3.28%, not better.
- The `Go` pattern is case-sensitive to avoid matching the English verb; it will still catch a
  capitalised sentence-initial "Go". Go figures carry more noise than the others.
- One HN comment often advertises several roles. Everything is measured **per post, not per role**,
  so absolute role counts are undercounted throughout. Ratios between stacks are unaffected.
- Company-name extraction takes the first pipe-delimited segment. Companies that deviate from HN
  convention (several ResortPass posts start with the job title) are missed, so repeat-poster runs
  are a **floor**, not a ceiling.
- Candidate-thread and job-thread counts use different denominators and are not perfectly
  comparable; the 4.2:1 and 5.3:1 ratios are indicative, not precise.

**What I inferred rather than counted:** every reading of *intent* — that reposting mostly reflects
recruiting habit rather than distress (supported by the 0.4% urgency figure, but still an
inference); that agencies represent JetThoughts' best buyer shape (supported by prior client
history, not by this dataset); that AI-on-Rails work is inside the bench's capability; and all four
kill-risk arguments. Treat these as arguments, not measurements.

**What I could not obtain.** `workatastartup.com/jobs` returns 406/302 to scripted requests and
serves no listing data without a logged-in YC account; the YC company Algolia index rejected public
credentials. `hnhiring.com`, which independently indexes these same threads by technology and would
have made a good cross-check on my Rails counts, returns 403. **So there is no YC Work at a Startup
data in this report**, and the Rails figures have not been validated against a second source — only
against my own counts across 30 threads and two independent 12-month windows, which agree with each
other. The one external Rails data point encountered in passing was a thoughtbot article,
"[48 companies you didn't know were using Rails in 2026](https://thoughtbot.com/blog/48-companies-you-didn-t-know-were-using-rails-in-2026)",
which I did not read or rely on.

**Confidence.** High on the three structural claims: the channel is shrinking, HN's contract demand
is effectively zero, and Rails is a small niche drifting slowly downward. Medium on the repost list
being a usable lead list. Low on anything about what these buyers would actually pay — the only
hard rate evidence in the entire dataset is a single $40/hr agency-subcontract ad, and it points the
wrong way.
