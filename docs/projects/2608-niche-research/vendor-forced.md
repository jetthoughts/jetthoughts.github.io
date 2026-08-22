# Vendor-forced migrations and EOL events — JetThoughts service candidates

Research date: 2026-08-21. Lane: work that must happen because a supplier changed licensing,
pricing, or support. Filter applied to every candidate: **a named third party, a named date, and
the pain landing on the person holding the chequebook.**

---

## 1. AWS Extended Support exit — get off the EOL database engine before the meter runs

**Service:** Upgrade a Rails/Django/Node application's managed database engine (RDS MySQL 8.0 →
8.4, RDS/Aurora PostgreSQL 13/14 → 16/17, OpenSearch/Elasticsearch) so the customer stops paying
AWS's per-vCPU-hour Extended Support surcharge — sold as a fixed fee benchmarked against the
surcharge it kills.

**Forcing party and date:** Amazon Web Services. This is a rolling calendar, not one deadline:

| Engine | End of standard support | What happens next |
| --- | --- | --- |
| RDS for MySQL 8.0 | **31 July 2026** | **Auto-enrolled into paid Extended Support 1 Aug 2026** |
| RDS / Aurora PostgreSQL 13 | 28 February 2026 | Extended Support billing live now |
| PostgreSQL 14 (upstream) | 12 November 2026 | RDS/Aurora follows |
| OpenSearch / Elasticsearch (ES 1.5–7.8, OS 1.0–1.2, 2.3–2.9) | 7 November 2026 | Surcharge **equals** instance price — bill doubles |
| ES 6.8 / 7.10, OS 1.3 / 2.19 | announced Aug 2026 | 3 years Extended Support |
| ES 7.9, OS 2.11–2.17 | announced Aug 2026 | 1 year Extended Support |

Sources: [AWS re:Post — RDS PostgreSQL 13 EOS 28 Feb 2026](https://repost.aws/articles/ARRvHxJ_9sTDCGloBavca3kg/announcement-amazon-rds-postgresql-13-x-end-of-standard-support-is-february-28-2026) ·
[RDS MySQL 8.0 auto-enrolment](https://privatedevops.com/news/aws-rds-mysql-8-0-end-of-standard-support) ·
[AWS OpenSearch support dates, Aug 2026](https://aws.amazon.com/about-aws/whats-new/2026/08/amazon-opensearch-service-additional-upgrade-runway-support-dates/) ·
[The Register, 17 Mar 2026](https://www.theregister.com/2026/03/17/aws_ends_support_postgresql_13_rds/)

**Who pays, and does the pain reach them:** Yes — more directly than anything else in this lane.
The penalty is a **line item on the AWS invoice**, not an abstract risk. Auto-enrolment is the
mechanism: the opt-out flag (`open-source-rds-extended-support-disabled`) has to be set at instance
*creation or restore* time, which almost no existing fleet did. So the first the finance owner hears
of it is the bill. That is the "third party forces it" test passing at its strongest: nobody has to
be persuaded that a risk is real when the invoice already went up.

**Evidence of money already moving:**
- Extended Support is **$0.100 per vCPU-hour** (US East Ohio) for years 1–2, **$0.200** in year 3;
  Reserved Instance discounts do **not** apply.
- A 16-vCPU Multi-AZ PostgreSQL instance: **"nearly $30,000 per year in Extended Support fees
  alone"** (The Register, Mar 2026).
- A 4-vCPU RDS MySQL instance: **+$676.80/month in year 3** (Dogsbody Technology).
- OpenSearch: from 7 Nov 2026 the surcharge **equals the instance price** — a straight doubling.
- Aurora MySQL notably stays at year-1 pricing throughout, so the urgency is concentrated on RDS.

The surcharge is the fee schedule. It prices the service for you: an engagement that costs less than
twelve months of surcharge is trivially justified, and the buyer can check the arithmetic on their
own bill.

**Why underserved:** The people who *see* the problem and the people who can *fix* it are different
firms. FinOps tools (Vantage, Usage.ai) and cost-optimisation consultancies surface the charge and
write the blog posts — none of them will touch application code. AWS Premier partners chase
large-scale modernisation programmes, not a six-week engine bump. DBA shops (Mydbops, Percona) do
the database half but not the app half. The actual blocker is almost never the database: it is
whether the *application* survives — the `mysql2`/`pg` gem, ActiveRecord adapter behaviour, removed
server defaults, SCRAM-SHA-256 auth, query-plan regressions on a new optimiser. That is application
engineering with a database deadline attached, and nobody owns it.

The Register story is the clearest proof of the gap: AWS forced PG13 customers onto PG14, whose
default SCRAM-SHA-256 auth **breaks AWS Glue**. Customers are stuck between an unsupported engine
and a broken pipeline, and the workarounds are all application-level.

**JT fit:** Strong, and the best in this lane.
- Senior Rails generalists are exactly right: the work is a test suite, a compatibility matrix,
  a staged cutover and a rollback plan. No DBA specialism, no JS, no dedicated DevOps needed.
- Fixed scope, fixed date, fixed fee — survives a founder with 15 minutes a day for sales.
- Partner-shaped: FinOps consultancies, MSPs and AWS partners already have the client, already
  flagged the charge, and have no bench that can safely edit application code. JT is the remediation
  arm behind someone else's finding. That is precisely JT's proven motion.
- English-language sale throughout; AWS billing is an English-first world.
- Repeatable: the table above is a pipeline of deadlines through 2027, not a one-off.

**Kill risk:** AWS has softened deadlines before (the August 2026 OpenSearch announcement granted
another 12 months of runway), so a buyer can rationally decide to pay the surcharge and wait. The
counter is that the surcharge is real money paid *now*, and year-3 doubling is scheduled. Second
risk: the largest fleets have in-house platform teams and do this themselves — so the buyer is the
50–500-person company with a Rails app, an AWS bill, and no spare senior engineer. Third: JT must
resist letting this become open-ended modernisation. The moment it stops being "the surcharge is
gone, here's the invoice line proving it," it loses the forcing function that sells it.

---

## 2. Heroku exit — Salesforce has stopped selling the platform

**Service:** Move a production Rails application off Heroku (to AWS/GCP/Fly/Kamal-on-bare-metal),
or off the dying Cedar generation and the deprecated Heroku-22 stack, before builds start failing.

**Forcing party and dates:** Salesforce / Heroku.
- **6 February 2026** — Salesforce announced **Heroku Enterprise End of Sale**, moving the product
  to a "sustaining engineering model." Existing customers keep usage rights, no End-of-Life date has
  been published. ([Aquiva Labs](https://aquiva.com/blog/heroku-enterprise-end-of-sale-fy26))
- **1 November 2026** — Heroku-22 builds begin failing: the first build of each app in any 30-day
  window fails with a deprecation error.
- **1 February 2027** — that window tightens to 7 days. **1 April 2027** — to 24 hours.
- **30 April 2027** — Heroku-22 End of Life; apps run on, unpatched and unsupported.
  ([Heroku-22 EOL FAQ](https://help.heroku.com/NQNCQTEJ/heroku-22-end-of-life-faq))
- Heroku-22 is Cedar-only and **cannot** run on the new Fir generation, so the stack upgrade and the
  generation migration collapse into one project.

**Who pays, and does the pain reach them:** Yes, on two channels. End of Sale is a board-level
signal — a platform Salesforce has stopped selling is a platform the CTO must answer for, and it
lands during procurement and diligence, not just in engineering. And the escalating build failures
are the rarest kind of deadline: a vendor that **actively breaks your deploys on a published
schedule**, starting gently and tightening until you cannot ship. There is no "we'll get to it" path
past 1 April 2027.

**Evidence of money already moving:** Weaker on published rates than candidate 1 — Heroku migration
is quoted, not listed. But the buyer population is unusually well qualified: Heroku Enterprise
customers are, by definition, companies already paying a large premium for managed Rails hosting
rather than running their own infrastructure. They have budget and no platform team — that is the
whole reason they were on Heroku. AppExchange ISVs running managed-package backends on Heroku are
named as particularly exposed, and Heroku Connect users (Salesforce CRM sync) face the hardest
rebuild.

**Why underserved:** Salesforce partners know Salesforce, not Rails runtime internals. Cloud
migration shops know Terraform, not `Procfile`, buildpacks, dyno concurrency and Heroku Postgres
semantics. The population is overwhelmingly Rails — which means the natural supplier is a Rails
consultancy, and there are few with senior European capacity.

**JT fit:** Very strong. Rails-native, the work is application-shaped (buildpack → Dockerfile,
config vars → secrets, dyno model → process supervision, Heroku Postgres → RDS), scoped by a
published date, and sellable through Salesforce/AppExchange partners who own the client relationship
and cannot do the work.

**Kill risk:** No End-of-Life date has been announced for Heroku Enterprise, so the urgency is
inferred rather than scheduled — "sustaining engineering" could drift for years, and a CFO can
defer. The Heroku-22 build-failure calendar is the harder hook and should be the one JT sells on;
End of Sale is the argument for why the migration should be a real exit rather than a stack bump.
Second risk: some of this population will simply move to Heroku Fir and stay, which is a much
smaller engagement.

---

## 3. The Ruby + Rails dual EOL — as of 9 August 2026, only Rails 8.x is supported

**Service:** Take a Rails application from an out-of-support Ruby/Rails combination onto a supported
one, on a fixed timeline, with the security-questionnaire evidence pack as the deliverable.

**Forcing party and dates:** The Rails core team and Ruby core team. The situation crossed a line
twelve days ago:

| Version | Security support ended / ends |
| --- | --- |
| Rails 7.0 | 1 April 2025 |
| Rails 7.1 | 1 October 2025 |
| **Rails 7.2** | **9 August 2026 — passed** |
| Rails 8.0 | 7 November 2026 |
| Rails 8.1 | 10 October 2027 |
| Ruby 3.1 | 31 March 2025 |
| Ruby 3.2 | 31 March 2026 |

Sources: [endoflife.date/rails](https://endoflife.date/rails) ·
[Rails maintenance policy](https://rubyonrails.org/maintenance) ·
[Ruby branches](https://www.ruby-lang.org/en/downloads/branches)

Two facts worth stating plainly. **Today, Rails 8.0 and 8.1 are the only maintained releases** —
everything on 7.x is receiving no security patches at all. And **on 7 November 2026, Rails 8.0 drops
out too**, leaving 8.1 alone. HeroDevs calls this the "dual EOL problem": when both the runtime and
the framework are unsupported, vulnerabilities go unpatched at two layers at once.

**Who pays, and does the pain reach them:** This is the candidate's weak joint, and it must be named
honestly. Rails EOL by itself does **not** reach the chequebook — it reaches the CTO, who has lived
with it for years. What converts it is a *fourth* party arriving with a deadline: a failed
penetration test, a cyber-insurance renewal questionnaire, an enterprise customer's security review,
or a SOC 2 / ISO 27001 audit finding. FastRuby, who have run 100+ of these projects, list
**compliance first** among purchase triggers — ahead of end-of-life itself. The sales implication is
sharp: JT should not sell "you are on an old Rails." It should sell to companies who have *just
been told* they cannot stay there, which means the referral partner is an auditor, a pentest firm,
or an insurance broker — not a CTO.

**Evidence of money already moving:** The best-documented fee schedule in this entire lane.
- [FastRuby.io](https://www.fastruby.io/blog/is-it-expensive-to-upgrade-rails.html), from 100+
  projects: Rails 5.2→6.1 **$40,000–$120,000**; 6.1→7.0 **$60,000–$135,000**; 4.2→5.2
  **$55,000–$175,000**. An entire consultancy exists on this single service.
- Other published rates: audit-plus-upgrade **from $7,500**, 2–12 weeks; **$80–$150/hour**;
  patch-level maintenance retainers **$2K–$5K/month**.
- **HeroDevs sells paid never-ending support for EOL Rails** and raised a **$20M** fund for EOL
  maintenance. That is the strongest possible proof of budget: companies paying real money *not to
  upgrade*. Every one of those customers is a qualified lead who has already admitted the problem
  has a price.

**Why underserved:** It isn't, particularly — FastRuby, Bacancy, JetRockets, RailsFever, RailsUp and
others all sell it, and it is the most contested space here. JT's only differentiators are senior
European capacity and price, neither of which is a moat.

**JT fit:** Perfect on delivery — this is literally what the bench does — and poor on distinction.
Recommended as the **attach service** for candidates 1 and 2 rather than a standalone pitch: a
customer forced to upgrade their database engine or leave Heroku is already opening the application
up, and the Rails version is the same surgery. Sold that way it needs no separate demand generation.

**Kill risk:** Crowded, undifferentiated, and the forcing event is soft without a compliance trigger.
Sold on its own it becomes exactly the discretionary "modernisation" spend JT has already learned
does not convert.

---

## 4. VMware / Broadcom — verdict on JetThoughts' existing hypothesis

### Is the window still open? **Yes — wider than in 2025.**

The disruption has not settled; it escalated, and it escalated *in Europe specifically*.

- **26 January 2026** — Broadcom **did not renew any VMware Cloud Service Provider partner
  contracts** under the Advantage Partner Program. Sources report **hundreds of European CSPs**
  affected. ([The Register, 31 Jan 2026](https://www.theregister.com/2026/01/31/broadcom_vmware_cloud_partners/))
- The EMEA partner-programme overhaul invites only resellers billing **$500K–$1M+**, cutting loose
  most SMB-focused partners. ([SDxCentral](https://www.sdxcentral.com/news/broadcoms-vmware-partner-program-overhaul-targets-emea/))
- Pricing: Gartner puts typical increases at **300–400%**; AT&T documented **1,050%**; European cloud
  providers report up to **1,500%**. Perpetual licences are gone, 8,000 SKUs became 4, and the
  minimum purchase went from 16 to **72 cores**.
- Gartner forecasts **~70% of enterprise VMware customers will migrate at least half their virtual
  workloads by 2028**; 50–75% are currently evaluating alternatives.
- **2 October 2025** — vSphere 7.x / vSAN 7.x End of General Support (already passed). vSphere 8
  follows on **11 October 2027**.
- Proxmox at **€120–€1,100 per socket/year** against VMware bundles produces documented savings of
  70–95%; one Austrian SME saved 83%.

Sources: [Cloudmagazin, Mar 2026](https://www.cloudmagazin.com/en/2026/03/18/vmware-cost-trap-2026-it-teams-examine-alternatives/) ·
[PRO-ZETA](https://www.prozeta.eu/vmware-price-increase) ·
[Broadcom KB — vSphere 7 EoGS](https://knowledge.broadcom.com/external/article/415405/end-of-general-support-for-vsphere-70.html)

So: the forcing party is named, the dates are named, the money is enormous, the pain is unambiguously
the chequebook's, and the affected population is concentrated in exactly JT's geography. The window
is not closing — the January 2026 CSP cull *opened a second one*.

### Is JetThoughts' specific hypothesis still live? **No. Kill it.**

The hypothesis was: sell MSPs independent verification that a completed migration lost nothing.
Three findings sink it, and none of them are about timing.

1. **Verification is bundled, never bought.** Searching the migration-services market for
   independent validation, "migration assurance" or third-party proof returns only MSPs describing
   validation *inside their own* migration service — pre-migration test runs, data-integrity checks,
   functional sign-off before decommissioning (Acronis, Cloud Tech Services, XBASE, Veeam). There is
   no market for a separate verification line item because every migration provider already claims
   it as part of the deliverable. JT would be selling a component that comes free with the thing the
   buyer already bought.
2. **It asks the MSP to fund evidence against itself.** The chequebook holder for verification is
   the MSP who just performed the migration, and paying a third party to audit your own delivery is
   an admission of doubt to your own client. The party who genuinely wants the assurance is the *end
   customer* — who has no relationship with JT, was sold a turnkey migration precisely to avoid
   managing suppliers, and would have to be reached through the MSP that the audit threatens.
3. **JT cannot deliver the core work, so it cannot land the follow-on.** The reason to accept a thin
   wedge is that it opens a thick one. Here the thick engagement is the hypervisor migration itself,
   which needs virtualization and storage engineers JT does not have and is not hiring. The wedge
   leads nowhere.

**Recommendation:** do not test it. JT has never run this experiment, and the correct outcome of the
research is that it should not spend one of its scarce sales cycles doing so. The demand is real; JT
is the wrong supplier for it. If JT wants a European Broadcom-refugee play at all, the only version
that fits the bench is **application-layer**: customers leaving VMware also leave the managed
services bolted to it, and the software that assumed vSphere-specific behaviour has to be fixed. That
is a thin and speculative slice, and it is a worse bet than candidates 1 and 2 — which reach the same
buyers through the same partners with work JT is unambiguously qualified to do.

---

## Ranked shortlist

1. **AWS Extended Support exit (RDS MySQL 8.0 / PostgreSQL / OpenSearch)** — the forcing party bills
   the customer automatically, the penalty prices the engagement, the work is application-shaped, and
   the deadlines recur through 2027. MySQL 8.0 auto-enrolment began **1 August 2026**: this is live
   this month, and every affected customer is about to open an unexpectedly larger invoice. Start
   here.
2. **Heroku exit** — Rails-native, a published schedule of escalating build failures from **1 Nov
   2026**, and a buyer population that has already demonstrated it will pay a premium not to run its
   own infrastructure. Weaker published pricing than candidate 1; harder deadline than candidate 3.
3. **Ruby + Rails dual EOL** — best-documented fee schedule ($40K–$175K per project) and JT's exact
   competence, but crowded and only truly forced when a compliance event supplies the deadline. Sell
   it **attached** to 1 and 2, not alone.
4. **VMware / Broadcom** — window wide open, demand real, European, and enormous. JT cannot supply
   it. Recorded here so the finding is not lost, not proposed as a service.

The first two share a buyer, a channel and a sales motion: a partner who already owns the client has
found a vendor deadline they cannot themselves remediate, and hands JT a scoped piece of application
work with a date on it. That is one service with two entry points, and it is the shape JT already
knows how to sell.

## Discarded, and why

| Candidate | Forcing party / date | Why it fails |
| --- | --- | --- |
| **TLS certificate lifetime cuts** | CA/Browser Forum; 200 days from 15 Mar 2026, 100 days from 15 Mar 2027, 47 days from 15 Mar 2029 | Genuine hard dates and genuine panic, but the remediation is PKI and ACME automation — dedicated DevOps work JT does not have. The app-layer slice (pinned certs, internal mTLS) is too thin to sell. |
| **Atlassian Data Center** | Atlassian; end of sale 30 Mar 2026, ~15% price rise 17 Feb 2026 (18–40% on legacy Advantage), read-only 28 Mar 2029 | Real forcing event and real money, but delivery is an Atlassian-partner specialism, and the app-layer piece — rewriting Server plugins for Cloud — is Forge/TypeScript. JT has no JS specialists. |
| **Terraform → OpenTofu / HashiCorp under IBM** | IBM/HashiCorp; HCP free tier ended 31 Mar 2026, per-resource pricing published 19 Feb 2026 | **No deadline forces anyone off Terraform** — existing licences keep working. Only ~12% of IaC practitioners have switched. Elective, and it is DevOps work regardless. |
| **Redis / Elastic / MongoDB licence changes** | — | The forcing has *reversed*: Elastic returned to AGPL (2024) and Redis 8 re-added AGPL. The panic that drove the Valkey fork has no live deadline behind it in 2026. |
| **SaaS repricing (Auth0/Okta, Twilio/SendGrid)** | — | Prices creep at renewal, but no vendor has announced a dated cutover. This is grumbling, not a deadline — it fails the filter's first rule outright. |
| **Oracle Java per-employee licensing / Java LTS transitions** | Oracle | Enormous money and a genuine price shock, but JT has no Java bench. Excluded on supply, not demand. |
| **PHP 8.1/8.2, Node 18/20, .NET 8 EOLs** | Respective upstreams | All real, all dated. None are JT's stack, and Node work would need the JavaScript specialists JT explicitly does not have. |
| **Windows Server / Exchange / SQL Server on-prem EOLs** | Microsoft | Infrastructure and Systemhaus break-fix territory — already killed by JT, and correctly. |
