# Money in Motion — JetThoughts service signals, August 2026

Research lane: follow budget that is *already* being spent, then ask what service sits behind it.
Filter applied throughout: **(1) a third party forces the spend, (2) the pain lands on the person
holding the chequebook.** Candidates failing either test are marked.

**Read the evidence-quality note at the bottom before acting on any number here.** Roughly half the
sources in this space are vendor content-marketing pages recycling each other's statistics. I have
separated primary sources (Rails core, Upwork IR, Gartner, freelancermap survey) from repeated
marketing claims.

---

## 1. Where the money is moving

| Signal | Source & date | What it implies about buyable services |
| --- | --- | --- |
| **Rails 7.0 and 7.1 lost all security patching**; 7.2 patched only to **2026-08-09**; 8.0 only to **2026-11-07**; 8.1 to 2027-10-10 | [rubyonrails.org, 2025-10-29](https://rubyonrails.org/2025/10/29/new-rails-releases-and-end-of-support-announcement) — **primary** | As of today (2026-08-21) **only Rails 8.0 and 8.1 receive security fixes, and 8.0 dies in 77 days.** Every Rails app not on 8.1 is unsupported or about to be. Deterministic, dated, unavoidable. This is the single hardest forcing function found in this lane. |
| Rails 5/6 already cut off from security updates; upgrade framed by vendors as "not optional — a security and compliance requirement" | [rubyroidlabs, 2026-03](https://rubyroidlabs.com/blog/2026/03/upgrade-rails-5-6-to-rails-8/), [RailsFever](https://railsfever.com/blog/ruby-on-rails-upgrade-services/) — vendor marketing, but consistent | The market has already priced this as compliance work, not discretionary refactoring. Vendors sell it; buyers buy it. |
| A **paid Rails upgrade/maintenance market visibly exists**: FastRuby.io (OmbuLabs) sells fixed-cost monthly "Bonsai" maintenance; Planet Argon, Saeloun, BoTree, RailsFever all sell upgrade engagements; commercial Rails LTS vendors sell patched forks of dead versions | [fastruby.io/our-services](https://www.fastruby.io/our-services), [saeloun.com](https://www.saeloun.com/ruby-on-rails-upgrade-services), [planetargon.com/services](https://www.planetargon.com/services), [railsfever.com](https://railsfever.com/blog/rails-7-lts-technical-guide-for-developers/) | Outside firms are **already being paid** for this — not merely "job ads exist". Several are subscription-priced, which is the retention shape JT already achieves (95%). |
| Senior Rails contractors bill **$150–225/h US**, $100–180/h US general, **$30–75/h Eastern Europe** | [arc.dev](https://arc.dev/freelance-developer-rates/ruby-on-rails), [lemon.io](https://lemon.io/rate-calculator/ruby-on-rails-developers/) — aggregator data, directionally reliable | The **arbitrage is the business**. A European senior Rails contractor is cheap in Europe and expensive in the US. Sell westward, not into DACH. |
| DACH freelance rates **stopped rising for the first time** since the survey began; median €95–103/h; monthly income *fell* while hours *rose* | [Freelancer-Kompass 2026, freelancermap](https://www.freelancermap.de/freelancer-kompass), [Gründerküche summary](https://www.gruenderkueche.de/news/gruender-news/freelancer-kompass-2026-stundensaetze-sinken-arbeitsbelastung-steigt/) — **primary survey** | The DACH freelance market is a **declining-price market**. Do not build a motion that sells hours into it. |
| Within DACH, **SAP/ERP €120 median, Data & Analytics €100, software/web dev €90** | [freelancermap IT rate study 2026](https://www.freelancermap.de/blog/stundensatz-it-freelancer/) — **primary survey** | JT's core skill sits at the **bottom** of the DACH rate stack. Confirms: DACH is the wrong geography to sell Rails capacity into. |
| Upwork: top AI-applied skills **+109% YoY**; AI integration +178%; freelancers doing AI work earn **+34%/h** | [Upwork In-Demand Skills 2026 (IR release)](https://investors.upwork.com/news-releases/news-release-details/upworks-demand-skills-2026-demand-top-ai-skills-more-doubles-ai), [Future Workforce Index 2026](https://www.upwork.com/research/research-future-workforce-index-2026) — **primary** | Real premium, but Upwork explicitly adds the caveat below. Not a clean buy signal. |
| Upwork: **low-complexity AI execution work is growing while its earnings decline**; complex AI-augmented professional work is rising in value | [Upwork Future Workforce Index 2026, 2026-07-14](https://www.globenewswire.com/news-release/2026/07/14/3326964/0/en/Upwork-s-Future-Workforce-Index-2026-How-AI-is-Redefining-the-Value-of-Work-as-Skilled-Freelancing-Accelerates.html) — **primary** | The AI premium accrues to *seniority applied to a hard problem*, not to "we do AI". Selling an AI-labelled service commoditises fast. |
| Gartner: AI agent **software** spend $206.5bn in 2026 → $376.3bn 2027; total AI spend $2.59tn, +47% | [Gartner press release, 2026-05-19](https://www.gartner.com/en/newsroom/press-releases/2026-05-19-gartner-forecasts-worldwide-ai-spending-2-59-trillion-2026/) — **primary** | Enormous, but this is **licence and infrastructure** spend, not services JT can staff. AI *consulting services* is a much smaller $14.1bn. Do not read the headline number as addressable. |
| EAA enforcement live since 2025-06-28; first French lawsuits Nov 2025; Swedish market surveillance from Oct 2025; fines €60k (IE) to ~€900k (SE) | [levelaccess.com](https://www.levelaccess.com/compliance-overview/european-accessibility-act-eaa/), [plaintest.dev](https://www.plaintest.dev/blog/eu-accessibility-act-enforcement-2026/) — vendor-sourced, corroborated across several | Genuine dated forcing party with a real fine. **But the work is frontend/WCAG** — precisely the bench JT does not have. |
| 62.8% of EU enterprises trying to hire ICT specialists found roles hard to fill (Eurostat-derived) | quoted in [agileengine](https://agileengine.com/nearshore-staff-augmentation-in-2025-2026-benefits-and-best-practices/) — secondary, original is Eurostat | Confirms scarcity, but scarcity of *employees*. Does not by itself prove outside firms get paid. |
| Deloitte: cost reduction as the primary reason to outsource fell **70% (2020) → 34%** | quoted in [vettedoutsource](https://vettedoutsource.com/blog/development-outsourcing-services/), [hausadvisors](https://www.hausadvisors.com/blog/software-development-agency-statistics) — secondary | Buyers now outsource for **scarce expertise**, not cheapness. A "cheap European capacity" pitch is selling against the trend; "the only people who still know this stack" is selling with it. |
| Deloitte 2026 Tech Leadership Study: technical debt = **21–40% of total IT spend** | quoted in [focustapps, 2026-05-21](https://focustapps.com/2026/05/21/technical-debt-private-equity-portfolio-company/) — secondary | Maintenance is where the money already lives; the 2026 benchmark split is cited as ~55–60% maintenance vs 40–45% innovation. |

---

## 2. Candidate services

### A. Rails security-EOL upgrade, sold as a dated obligation — **strongest**

- **Who pays:** the CTO or technical founder of a company running a Rails app below 8.1 — most often a Series A–C SaaS or an established product built 2016–2022.
- **Forcing party and date:** the Rails core team. 2025-10-29 killed 7.0/7.1 outright; **2026-08-09 killed 7.2 (twelve days ago)**; **2026-11-07 kills 8.0**. These are published, verifiable, and not negotiable by the buyer.
- **Evidence outside firms get paid:** FastRuby.io/OmbuLabs, Planet Argon, Saeloun, BoTree and RailsFever all run this as a named commercial service line, several on fixed monthly pricing. A competitive vendor set is proof of a market, not a reason to stay out — it is the difference between "many job ads exist" and "budget is moving".
- **JT fit:** exact. Senior Rails contractors are the entire bench. English-speaking buyers, so the B1-German constraint never binds. Deterministic scope with a defined end state, which suits a 15-minute-a-day sales cadence far better than open-ended consulting.
- **Kill risk — read carefully:** this sits uncomfortably close to **paid audit-then-remediate, which is already killed.** The distinction that has to hold is that this is *not* an assessment. There is no diagnostic phase to sell; the version number is public, the deadline is published, and the deliverable is "you are on 8.1 and patched". If it drifts back into "let us assess your codebase first", it has become the killed service and should be dropped. Second risk: 8.1 support runs to 2027-10-10, so the buyer gets ~14 months of quiet — this is repeatable roughly annually, not monthly recurring, unless sold as ongoing maintenance in the Bonsai shape.

### B. Subcontracted senior Rails capacity to firms that own the client — **best channel fit** (detail in §3)

- **Who pays:** another firm — a Rails consultancy at capacity, a generalist agency that inherited a Rails client, or a US product company's delivery partner.
- **Forcing party:** none dated. This is a capacity constraint, not a compliance event. **Flagged as failing filter (1).** It survives because it is JT's only *proven* motion: both current clients are placed senior people.
- **Evidence:** the Rails senior pool is repeatedly described as structurally thin, with Eastern European seniors ($30–60/h) named as where most new Rails hiring now happens, specifically for *maintained codebases at YC-era startups whose original team has moved on* ([arc.dev](https://arc.dev/freelance-developer-rates/ruby-on-rails)). That is a precise description of JT's ideal engagement. Source quality is aggregator-marketing — treat as a hypothesis to test, not a fact.
- **JT fit:** perfect against the bench; the constraint is entirely on the demand side.

### C. Rails maintenance retainer for orphaned codebases

- **Who pays:** a company whose founding engineers have left and whose Rails app now has no owner.
- **Forcing party:** none dated — **fails filter (1)**, and is therefore a slower sale. It is listed because it is the natural renewal of (A) and matches the 95% retention JT already demonstrates. Best sold *after* an upgrade lands, never cold.

### D. European Accessibility Act remediation — **real money, wrong bench**

- **Who pays:** the business owner of any EU-facing consumer digital product.
- **Forcing party and date:** national market-surveillance authorities; enforcement live 2025-06-28, French litigation from Nov 2025, Swedish surveillance from Oct 2025. Fines €60k–€900k. This passes both filters cleanly — arguably the cleanest pass in the whole lane.
- **Why it is still a no for JT:** WCAG remediation is frontend work. JT has **no JavaScript specialists**. Buying that capacity through the supplier group turns JT into a broker on someone else's core skill, in a market where accessibility specialists already own the category. Recommend **not pursuing directly**; note it only as something a partner might route JT the *backend* half of.

### E. Public tenders (DACH/EU) — **kill**

TED framework agreements for ICT maintenance and development do recur and some lots are boutique-sized. But: bids are German- or national-language, cycles run months, and the process is exactly the bureaucratic overhead a founder with 15 minutes a day cannot carry. The founder's B1 German is disqualifying for German-language tendering. **Do not pursue.** No further research spent here.

### F. AI-labelled service lines — **do not build**

The +109% demand and +34% rate premium are real and primary-sourced. But Upwork's own 2026 index says low-complexity AI execution work is growing *while its earnings fall*, and the Gartner $206bn figure is software licences, not services. The premium attaches to senior judgement on hard problems, which JT can charge for **without** an AI label. Combined with the already-killed AI-code-rescue product, there is nothing left here to productise.

---

## 3. The partner channel — subcontracted capacity

This is JT's only proven motion, so it gets the sharpest treatment. The scarce asset is the client
relationship; the partner already has it.

**The core arbitrage, stated plainly:** senior Rails bills **$150–225/h in the US** and **€90/h median in
DACH** — where software/web development is the *lowest-paid* IT freelance category, below SAP (€120) and
Data & Analytics (€100). Selling JT's Rails bench into DACH means selling a scarce skill into the
market that values it least, in a language the founder does not sell in. **Sell west, in English.**
This single reframe removes the German-language constraint rather than working around it.

**Who to approach, ranked by how well the buyer's pain matches JT's bench:**

1. **Rails consultancies with a productised upgrade or maintenance line, at capacity.** FastRuby.io/OmbuLabs, Planet Argon, Saeloun, BoTree, RailsFever. They have published fixed-price products, which means demand arrives lumpy and overflow is structural. They buy *senior Rails hands who need no supervision* — exactly what JT places. The pitch is not "we do Rails too"; it is "your Bonsai queue has a spike and we can absorb two seniors next week." Highest-fit, and the buyer is technical so the sale is short.
2. **Non-Rails shops holding a Rails client.** JS, Python and .NET shops that won an account and inherited a Rails service they cannot staff. They will not turn the client away, so they subcontract. Harder to find (no directory), but the margin tolerance is high because the alternative is losing the account.
3. **White-label development partners serving marketing agencies.** A visibly established pattern — capacity under the reseller's brand, reseller keeps the relationship and margin ([codercops](https://blog.codercops.com/blog/white-label-agency-partnerships-2026), [whitelabeliq Ruby line](https://www.whitelabeliq.com/custom-development/ruby/)). Caveat: this segment is price-led and crowded, and the same sources note 60% of outsourced projects slip on poor coordination. Lower quality of revenue than (1).
4. **PE operating partners and technical-due-diligence firms.** The named volume player is **Crosslake** — which JT has already approached, and which cut a JT developer in favour of Claude-generated code. **Treat this channel as tested and failed**, not untried. Alvarez & Marsal and similar frame findings as EBITDA impact rather than engineering tasks, so the remediation work does get bought, but the same substitution risk applies. Do not spend the 15 daily minutes here.

**What not to sell through partners:** MSP subcontracting. The MSP shortage is loud (52% of MSPs name
hiring as their top internal problem) but the work they push out is **Tier-1 helpdesk and managed
support** — offshore ticket capacity, not senior product engineering. Wrong buyer, wrong margin, and
JT would compete on price against dedicated offshore helpdesk providers.

---

## 4. Where budgets are shrinking — what not to build

- **Commodity hourly development.** DACH freelance rates flat-to-down for the first time on record, monthly income falling while hours rise. Selling undifferentiated hours into this market is selling into a price decline.
- **Software and web development as a DACH category.** €90/h median, bottom of the IT freelance stack, below SAP and data. The skill is scarce but the *market* does not pay for it.
- **Template and markup work.** Shopify Templates the fastest-falling skill at −13%, CSS −11.8% (Upwork data). Anything a model does acceptably is repricing downward.
- **Low-complexity AI execution.** Growing in volume, falling in earnings, per Upwork's own index. The busiest-looking corner of the market is the one repricing fastest.
- **"Transformation" and greenfield replatforming.** Named repeatedly as the first line cut when budgets tighten — which is exactly why the maintenance side (55–60% of IT spend) is the durable one.
- **On-prem and legacy infrastructure work.** Budget is migrating to managed cloud; JT has no dedicated DevOps bench anyway.
- **Cheapness as a positioning.** Cost as the primary outsourcing driver fell 70% → 34%. Competing on rate is competing on the one axis buyers have de-prioritised — and against suppliers with lower floors.

---

## 5. Evidence quality — read before acting

**Primary and trustworthy:** the Rails end-of-support announcement (rubyonrails.org, dated, verifiable,
and the strongest single item in this report); Upwork's investor-relations releases and Future
Workforce Index; Gartner's AI spending release; the freelancermap Freelancer-Kompass 2026 survey.

**Secondary, treat as directional:** rate aggregator pages (arc.dev, lemon.io) — plausible and mutually
consistent, but they sell placement and have an interest in the numbers they publish.

**Weak — vendor content marketing, frequently recycled between sites:** the white-label and staff-
augmentation market sizings, the "$5.5 trillion skills crisis", the "42% of MSPs" and "60% of outsourced
projects delayed" figures, and most EAA-enforcement detail. These appear across many pages with no
traceable original study. I have not treated any of them as load-bearing, and neither should the
decision.

**Explicitly not verified:** the mechanism I would most want to confirm before committing to candidate
(A) is *how the Rails EOL deadline actually reaches the chequebook*. The plausible path is a customer
security questionnaire, SOC 2 evidence request, or cyber-insurance renewal flagging an unsupported
framework. I searched for this and **could not confirm it** — the SOC 2 material I found discusses
vendor questionnaires generally and says nothing about framework end-of-life. Until someone confirms
that a real buyer was forced by a real questionnaire, candidate (A)'s forcing function is documented at
the *technical* level (patches genuinely stop) but only assumed at the *commercial* level. That is the
one gap worth closing before building anything, and two conversations with existing Rails clients would
close it.

**Sources:**
[rubyonrails.org EOL announcement](https://rubyonrails.org/2025/10/29/new-rails-releases-and-end-of-support-announcement) ·
[Rails maintenance policy](https://rubyonrails.org/maintenance) ·
[Upwork In-Demand Skills 2026](https://investors.upwork.com/news-releases/news-release-details/upworks-demand-skills-2026-demand-top-ai-skills-more-doubles-ai) ·
[Upwork Future Workforce Index 2026](https://www.upwork.com/research/research-future-workforce-index-2026) ·
[Gartner AI spending 2026](https://www.gartner.com/en/newsroom/press-releases/2026-05-19-gartner-forecasts-worldwide-ai-spending-2-59-trillion-2026/) ·
[Freelancer-Kompass 2026](https://www.freelancermap.de/freelancer-kompass) ·
[freelancermap IT rates 2026](https://www.freelancermap.de/blog/stundensatz-it-freelancer/) ·
[Gründerküche on Freelancer-Kompass 2026](https://www.gruenderkueche.de/news/gruender-news/freelancer-kompass-2026-stundensaetze-sinken-arbeitsbelastung-steigt/) ·
[arc.dev Rails rates](https://arc.dev/freelance-developer-rates/ruby-on-rails) ·
[lemon.io Rails rates](https://lemon.io/rate-calculator/ruby-on-rails-developers/) ·
[FastRuby.io services](https://www.fastruby.io/our-services) ·
[Planet Argon services](https://www.planetargon.com/services) ·
[Saeloun Rails upgrades](https://www.saeloun.com/ruby-on-rails-upgrade-services) ·
[RailsFever Rails 7 LTS guide](https://railsfever.com/blog/rails-7-lts-technical-guide-for-developers/) ·
[Rubyroid Rails 5/6→8 guide](https://rubyroidlabs.com/blog/2026/03/upgrade-rails-5-6-to-rails-8/) ·
[Level Access EAA guide](https://www.levelaccess.com/compliance-overview/european-accessibility-act-eaa/) ·
[Plaintest EAA enforcement 2026](https://www.plaintest.dev/blog/eu-accessibility-act-enforcement-2026/) ·
[CoderCops white-label 2026](https://blog.codercops.com/blog/white-label-agency-partnerships-2026) ·
[WhiteLabelIQ Ruby](https://www.whitelabeliq.com/custom-development/ruby/) ·
[Smarter MSP on subcontracting](https://smartermsp.com/thinking-about-contracting-out-services/) ·
[FocustApps on PE technical debt](https://focustapps.com/2026/05/21/technical-debt-private-equity-portfolio-company/) ·
[Haus Advisors agency statistics](https://www.hausadvisors.com/blog/software-development-agency-statistics) ·
[TED EU tenders](https://ted.europa.eu/en/)
