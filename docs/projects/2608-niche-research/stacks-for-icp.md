# Stacks beyond Rails that fit JetThoughts' ICP

Research lane: which tech stacks suit a startup that cannot afford more than one or two
developers and whose founder cannot manage engineering — and whether anyone pays outside firms
for them.

All job-market figures below were pulled live from IT Jobs Watch on **22 August 2026**, every
one covering the identical **6 months to 22 Aug 2026** window. That makes them internally
comparable, which is the point — a single consistent instrument beats a pile of numbers from
different platforms and years. Limitations are in the last section; read them before acting.

---

## 1. Ranked table

Ranked by all three questions together: ICP fit, demand from buyers who pay outsiders, and
whether JetThoughts can actually staff it.

| # | Stack | ICP fit | Demand evidence (UK, 6mo to 22 Aug 2026) | Who pays | JT staffing route | Verdict |
|---|---|---|---|---|---|---|
| 1 | **Ruby on Rails** | **Best in class.** Rails 8 ships auth, Solid Queue/Cache/Cable (no Redis) and Kamal 2 (no PaaS). One deployable, one database. Officially marketed as "The One Person Framework" | 28 contract @ **£513/day** (+7.95% YoY); 184 perm @ **£72,500**; SO 2025: 6.2% | Funded startups and scale-ups buying senior contract capacity; 28.6% public sector | **Own bench** + BigBinary (Rails-only shop) | **Keep as core** |
| 2 | **TypeScript / Next.js** | Mediocre *as a framework* — no default ORM, admin, jobs or auth; you assemble 4-5 vendors. Good *as a product* once paired with a managed backend (Supabase/Neon) that collapses ops | **187 contract @ £525/day** (+5% YoY); 285 perm @ £75,000 (+127 YoY); only **11% public sector**, 46% full-stack; HN 30.6%→33.0% rising | Commercial product teams — retail, finance, SaaS. The broadest, least gated contract market of the set | MLSDev (Node.js, Angular/Vue); **plus own Rails devs already write the React/TS front end** | **Adopt as declared second stack** |
| 3 | **AI inside an existing app** | Not a stack — a capability. A senior generalist can carry LLM features in a Rails or Next app; they cannot carry RAG infra or MLOps | Gen AI: **1,306 contract (2.43% of all UK contract jobs)**, up from 348 (1.06%); LangChain 151 @ £575 | **Finance and banking enterprises**, buying Python/Azure/ML specialists — *not* the ICP | Own bench, as a feature inside Rails/TS work | **Sell as capability, never as a practice** |
| 4 | **Laravel / PHP** | **Excellent — genuinely Rails-equivalent.** Forge, Cloud, Nova/Filament admin, Horizon queues, Cashier billing, starter kits. $57M Accel Series A | Perm 212 @ £52,500 (*more* posts than Rails). But contract **collapsed 125 (2024) → 11 (2026)**, £425/day — lowest rate of the set | SMBs and agencies — and they keep it **in-house** or use the **official Partner Program** (55+ vetted agencies, founded 2017) | **Brokering only** — no supplier in the group does PHP | **Reject** (see §4) |
| 5 | **Django / Python** | Good. Best admin in the business, batteries-included by slogan. Weaker than Rails on jobs and deploy (Celery + Redis; no Kamal equivalent) | 204 contract @ **£625/day** — highest rate of the set. But **33.8% security-cleared, 33.8% public sector**, 26% FastAPI, Azure/AWS heavy | **UK government programmes**, not founders. Closed to JT: clearance and residency required | Brokering only — no Python supplier in the group | **Reject** (see §4) |
| 6 | **Phoenix / Elixir** | **Excellent in theory.** LiveView, OTP, one deployable, no Redis. The purest "one person framework" argument after Rails | **4 permanent jobs in six months — 0.004% of the UK market.** SO 2.5%; HN ~1.1% flat | Almost nobody | None | **Reject** — the textbook "fits tiny teams, nobody pays" |
| 7 | **Go** | Poor. No ORM, admin, auth or jobs defaults. A 1-2 person team builds its own framework first | 477 perm @ £80,000, **down from 981 and -11% salary YoY**; HN 8.7%→8.0% | Infrastructure teams at larger companies | None | **Reject** |
| 8 | **.NET / ASP.NET Core** | Decent, honestly — Identity, EF Core, one deployable, strong defaults | 613 perm @ £55,000, salary **-15.4% YoY** (count jump 60→613 is a taxonomy artefact, see §5) | Enterprise Microsoft shops via procurement | None | **Reject** — right framework, wrong buyer |
| 9 | **Low-code / no-code adjacent** | The ICP *is* the low-code buyer | **Not researched** — no demand data gathered | — | — | **Reject on business model**: incompatible with selling senior developers |

---

## 2. The stacks worth acting on

### TypeScript / Next.js — the one genuine addition

**The buyer:** a commercial product team, most often retail, SaaS or finance, hiring contract
full-stack capacity. Not government. Only 11.23% of Next.js contract postings are public sector,
against 28.57% for Rails and 33.82% for Django — this is the least gated market of the set.

**The evidence:** 187 UK contract vacancies at a £525 median day rate, up 5% year on year, and
285 permanent at £75,000 — up by 127 posts against the same window last year. Set that beside
Rails' 28 contract vacancies. Next.js has **6.7 times Rails' contract volume at a 2% higher day
rate**. On Hacker News hiring, TypeScript/JavaScript is the largest and still-rising share
(30.6% → 33.0%).

**Why it survives the ICP filter despite a mediocre framework score.** Next.js on its own is not
a one-person framework: there is no default ORM, admin, background-job runner or auth, so a
solo developer assembles Prisma or Drizzle, NextAuth, Inngest or Trigger, and a database vendor.
That is more moving parts than Rails, and a two-person team with no engineering manager wiring
five vendors together is precisely the failure this ICP is defined by. Paired with Supabase or
a similar managed backend, the ops burden collapses and the defaults arrive from the platform
rather than the framework. The fit is real but it is *conditional on the managed backend*, and
that condition should be part of how JetThoughts sells it.

**Why JetThoughts can staff it honestly.** This is the crucial asymmetry. Laravel and Django
would mean brokering someone else's core skill. TypeScript would not: MLSDev already names
Node.js and Angular/Vue, and — more importantly — JetThoughts' own senior Rails developers
already write the React and TypeScript front end of most Rails engagements. Declaring TypeScript
is naming a capability the bench already has, not acquiring one.

### AI inside the app — a capability, not a third practice

**The honest answer to the AI question in the brief: no small-team-friendly AI application
stack has yet produced an ICP-shaped buyer.**

The demand is genuinely enormous and it is the fastest-moving thing measured here. Generative AI
appears in **1,306 UK contract vacancies, 2.43% of the entire contract market**, up from 348
(1.06%) a year ago. That is 47 times Rails' contract volume. LangChain alone carries 151
vacancies at £575/day, up 77.6% year on year.

But look at who is buying. The co-occurring skills on Gen AI contracts are Python (30.6%), Azure
(25.9%), machine learning (28.7%) and AWS (21.5%); on LangChain they are Python (88.1%), LLMs
(86.1%), Azure (60.9%) and RAG (58.9%). The named sectors are finance and banking. This is an
enterprise buying a Python/Azure specialist, not a founder who cannot supervise a developer.
And there is no rate premium to chase: Gen AI's £550 median sits barely above Next.js at £525
and Rails at £513. It is a volume story in a segment JetThoughts does not sell to.

What *has* changed, and what JetThoughts can act on, is that the batteries-included frameworks
are absorbing AI as a feature. Laravel has retitled its own homepage "the clean stack for
Artisans **and agents**." Adding an LLM feature to an existing Rails or Next application is work
a senior generalist carries without a specialist — and it lands on the ICP's chequebook because
the founder's customers are asking for it. That is the sellable version: **AI feature delivery
inside the stacks JetThoughts already ships, priced as senior engineering, never as an
"AI practice" competing with Python/Azure specialists.**

---

## 3. What Rails should be to JetThoughts now

**Keep it as core, and stop treating its shrinking share as a problem to solve by switching.**

Three findings support this, and one qualifies it.

Rails is the only stack in this study where JetThoughts sells **its own people rather than
brokering someone else's**. That is not a minor operational detail: it is the difference between
a margin and a referral fee, and between owning a delivery reputation and renting one.

Rails is priced as senior work, and rising. Its £513 contract median is up 7.95% year on year
and its £72,500 permanent median is 38% above Laravel's £52,500 — the closest structural
analogue. Whatever is happening to Rails' *share*, its buyers are paying more per head each
year, and they are paying for exactly the seniority JetThoughts sells.

Rails' ICP fit is not a marketing claim but a shipped architecture. Rails 8 removed Redis (Solid
Queue, Cache, Cable) and removed the PaaS (Kamal 2) and added first-party auth. The framework's
maintainers are actively engineering *toward* the one-person case while JetThoughts' ICP is
defined by it. No other framework has that alignment between roadmap and buyer.

**The qualification:** Rails' problem is volume, not price. 28 contract vacancies in six months
is a thin market — 0.052% of UK contract hiring — and the Hacker News trend (4.5% → 3.9%, Rails
strict 3.9% → 3.3%) points the same way. A single-stack Rails business is betting on a premium
niche that is not growing.

So the shape is **one core plus one declared second stack, not a portfolio**: Rails as the
practice JetThoughts owns and staffs itself, TypeScript/Next.js as the second stack it can staff
honestly and which carries nearly 7 times the contract volume, and AI as a capability sold
inside both. Three stacks would exceed what a company of JetThoughts' size can hold a reputation
in; two plus a capability is defensible.

---

## 4. Stacks explicitly rejected, with the reason, so they are not re-proposed

**Laravel — rejected despite the best ICP fit of any alternative.** This is the closest call and
the most counter-intuitive result, so the reasoning matters. Laravel genuinely is Rails' equal
as a one-person framework, is better funded ($57M from Accel), and has *more* UK permanent
postings than Rails (212 vs 184). Three things kill it anyway. First, its contract market has
collapsed — 125 vacancies in 2024 to **11** in 2026 — so the people paying outside firms for
Laravel have largely stopped. Second, it is the lowest-priced stack measured, £425/day contract
and £52,500 permanent, a 38% discount to Rails; Laravel's buyer is an SMB that keeps work
in-house at SMB rates. Third, where that buyer *does* go outside, there is already an official,
vetted, nine-year-old channel: the Laravel Partner Program, 55+ agencies across Premier and
Community tiers, with a "Match with a Partner" funnel run by Laravel itself. JetThoughts would
enter as an unknown, brokering PHP it does not staff, against 55 vetted incumbents, at the
lowest rate in the set. **The popularity is real; the outside-firm spend is not.**

**Django — rejected because the demand is real but the buyer is a government.** Django posts the
highest day rate measured (£625) and 204 contract vacancies, which looks like the actionable
finding the brief was hoping for. It is not. 33.82% of those postings require **security
clearance** and 33.82% are public sector; the co-occurring skills are Azure, AWS, CI/CD and
FastAPI, and the geography is London at £656/day. This is UK government and defence Python
platform contracting. It is structurally closed to JetThoughts — clearance requires UK residency
and vetting no distributed supplier network can supply — and the buyer is a programme manager
with a procurement framework, not a founder who cannot manage engineers. **This is the number
most likely to be misread by a later reader; it is in the report precisely so it is not.**

**Phoenix/Elixir — rejected on demand.** Four permanent UK vacancies in six months, 0.004% of
the market. The ICP argument is excellent and irrelevant.

**Go — rejected on ICP fit and direction.** No batteries; a two-person team builds its own
framework before it builds its product. Demand is also falling: 477 permanent, down from 981,
with salaries off 11%.

**.NET/ASP.NET Core — rejected on buyer, not on merit.** The framework scores respectably on ICP
fit. But the buyer is an enterprise Microsoft shop reached through procurement, salaries are
falling 15% year on year, and JetThoughts has neither bench nor supplier.

**Low-code/no-code — rejected on business model.** The ICP overlaps the low-code buyer almost
perfectly, but the engagement is not "a senior developer who extends your team", so it cannot be
sold through JetThoughts' existing product. Flagged honestly: **no demand data was gathered**,
so this rejection rests on business-model logic alone and would need research if ever revisited.

---

## 5. Evidence quality

**Primary, fetched directly and quotable.** IT Jobs Watch pages for Laravel, Rails, Django,
Next.js, Elixir, Go, ASP.NET Core, Generative AI and LangChain — permanent and contract, all on
22 Aug 2026, all covering the same 6-month window, so cross-stack comparisons are like-for-like.
`laravel.com/partners` (partner tiers, vetting, programme founded 2017). `bigbinary.com` (Rails
only) and `mlsdev.com` (RoR, Node.js, Angular, Vue) for the supplier-group staffing claims.
Laravel's $57M Accel Series A, confirmed on laravel.com's own blog and Fortune. DHH's "The One
Person Framework" post and the Rails World 2024 keynote contents for Rails 8's Solid trifecta,
Kamal 2 and built-in auth.

**Primary with a caveat.** Stack Overflow Developer Survey 2025 technology page — figures (Node
49.1%, React 46.9%, Next.js 21.5%, ASP.NET Core 21.3%, Vue 18.4%, Spring Boot 15.6%, FastAPI
15.1%, Flask 13.2%, Django 11.7%, Laravel 9.3%, Svelte 6.9%, Rails 6.2%, Phoenix 2.5%) came
through a page summariser rather than my reading the raw table. Directionally sound, but do not
quote a decimal place in client-facing material without re-checking the source.

**Secondary, used only as colour, not relied on for any verdict.** A dev.to analysis of 216
Elixir job listings. Vendor blogs claiming "over 75% of AI postings seek focused experts" and
Lemon.io's "$60-95/hr" RAG rates — these are marketing pages from firms selling the placement,
exactly the class of figure the brief warned about. **Not verified, not load-bearing anywhere
above.**

**One arithmetic error caught and corrected.** A fetch reported Laravel's 11 contract vacancies
as 0.020% "out of approximately 550,000 total contract positions". Cross-checking against
Next.js (187 = 0.35%) and Rails (28 = 0.052%) puts the real UK contract-market total at roughly
**53,000-55,000**, and the Next.js page states 53,400 directly. The 550,000 figure was generated
during summarisation and does not appear on the source page. All shares above use the
percentages, which are internally consistent.

**One figure flagged as unreliable and excluded from reasoning.** ASP.NET Core permanent postings
jumping from 60 to 613 in a year is not credible organic growth; it is almost certainly a change
in how IT Jobs Watch classifies the skill. The .NET rejection rests on buyer type and JT's
absent bench, not on that count.

**The main limitation, stated plainly: every job-market figure here is UK.** The brief says sell
west into English-speaking markets, and the UK qualifies — but the US contract market is larger
and may be shaped differently, particularly for Rails (a stronger US startup presence) and for
Django (US federal Python work has a different clearance regime). **I could not find a US
equivalent to IT Jobs Watch that publishes verifiable contract counts and day rates from a
primary source.** Before committing budget to the TypeScript recommendation, that gap is the
first thing to close. The relative ranking is likely to hold — Next.js versus Rails contract
volume is a 6.7x gap, too wide for geography alone to reverse — but the absolute numbers should
not be quoted as global.

**Not researched.** Low-code/no-code demand. US and Canadian rate data. Upwork and other
freelance-platform counts for stacks other than Rails (a sibling lane covers Upwork; I
deliberately did not duplicate it, so the freelance-platform picture here is incomplete by
design).
