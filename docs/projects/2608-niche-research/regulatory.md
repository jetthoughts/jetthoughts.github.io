# Regulatory and statutory forcing functions — JetThoughts service candidates

Research date: 2026-08-21. Lane: EU/DACH + English-speaking markets. Every candidate below
names a forcing party and a date; anything without one is in the discard list.

## The cross-cutting finding, before the candidates

The regulations with the hardest dates and the biggest fines (CRA, Battery Passport, EUDR) point
at buyers JetThoughts has no route to — embedded/hardware firms, battery manufacturers, commodity
traders. The regulations JetThoughts can actually reach a buyer for (e-invoicing, NIS2 supplier
pass-down, accessibility) all reach that buyer *through an intermediary who already owns the
relationship*: a Peppol access point, a security auditor, a web agency. That is the same motion
they already know works. Rank accordingly — reachability, not fine size, is the binding constraint.

---

## 1. E-invoicing last-mile: making a product's own billing code emit legally valid invoices

**Service.** Take a company's existing billing/invoicing code — bespoke Rails app, in-house
platform, or SaaS product that issues invoices on behalf of its customers — and make it produce and
transmit country-valid structured e-invoices (EN 16931 → XRechnung/ZUGFeRD, Factur-X, KSeF FA(3),
Peppol BIS 3.0), including validation, error handling, and archiving.

**Forcing party and date.** National tax authorities, four separate live deadlines:

| Country | Authority | Date | What |
|---|---|---|---|
| Poland | Ministry of Finance (KSeF) | 1 Feb 2026 → 1 Apr 2026 → 1 Jan 2027 | Invoice is **not legally valid** unless issued through KSeF in FA(3) |
| Belgium | FPS Finance | 1 Jan 2026 | Paper and PDF no longer legally accepted B2B; Peppol mandatory |
| France | DGFiP | 1 Sep 2026 receive (all sizes) + issue (large/medium); 1 Sep 2027 small/micro | Certified PDP required; Factur-X/UBL/CII |
| Germany | Finanzamt (§14 UStG, Wachstumschancengesetz) | 1 Jan 2027 (>€800k turnover) → 1 Jan 2028 (all) | Issue structured EN 16931 |

Sources: [Poland KSeF Feb 2026 phase](https://www.dynatos.com/blog/poland-ksef-update-for-february-2026/) ·
[France Sept 2026 receiving obligation, all sizes](https://www.avalara.com/blog/en/europe/2026/07/french-e-invoicing-mandate-readiness.html) ·
[Germany 2027/2028](https://edicomgroup.com/blog/germany-b2b-electronic-invoice) ·
[Belgium live Jan 2026](https://www.storecove.com/blog/en/choosing-a-peppol-provider-access-points-resellers-and-compliance-explained/)

**Who pays.** The founder/CFO of the software vendor or platform whose product issues the invoices.
The pain lands on them directly and unambiguously: in Poland an invoice outside KSeF is void, so
the company cannot bill. In France from 1 Sep 2026 they cannot receive supplier invoices. This is
not a fine you can absorb — it is revenue collection breaking.

**Evidence money is already moving.** A whole vendor category exists and is priced: certified PDPs
in France, Peppol access points selling four distinct commercial models (Access Point as a Service,
Co-Labelled Platform, API as a Service, Reseller Partnership), explicitly targeting "ERPs,
accounting software or invoicing services" as the integrating party
([Storecove](https://www.storecove.com/blog/en/choosing-a-peppol-provider-access-points-resellers-and-compliance-explained/),
[Quyntess](https://www.quyntess.com/en/resources/articles/peppol-acces-point)). Poland ran open API
testing from 30 Sep 2025 and a DEMO environment from 15 Oct 2025 specifically so software providers
could integrate — a government building a sandbox for integrators is direct evidence of the work
existing.

**Why underserved.** The vendors sell the *network*, not the *integration*. An access point gives
you an API; somebody still has to map a bespoke invoice schema onto EN 16931 semantics, handle the
per-country flavour differences (all national formats claim EN 16931 alignment and "all of them
express it differently" — [Dodo Payments](https://dodopayments.com/blogs/e-invoicing-compliance-global-saas)),
wire schematron validation failures into something a support team can act on, and solve archiving.
That last mile is unglamorous backend work no SaaS vendor wants to do per-customer.

**JT fit.** Best on the list. Pure Rails/XML/API backend — no JavaScript, no DevOps, no data
engineering. Sellable in English through a Peppol access point or French PDP that wants a delivery
arm for customers who need code written rather than a subscription sold. Repeatable: each new
country mandate is another mapping against the same core.

**Kill risk.** Access-point SDKs get good enough that the client's own developer does it in two
days, and the engagement is too small to be a service line. Mitigation is to sell the *multi-country*
version to platforms, not the single-country version to end-merchants.

---

## 2. NIS2 / UK CSRB supplier remediation — fixing the product so it passes the customer's security review

**Service.** A software vendor is being contractually forced by a regulated customer to meet
security requirements. JT does the engineering remediation on the vendor's own stack (logging,
MFA/SSO, patch cadence, backup-and-restore that has actually been tested, secure SDLC evidence)
so the contract survives. Audit and sign-off are done by someone else.

**Forcing party and date.** Not the regulator directly — the *customer*, forced by the regulator.
Germany's NIS2UmsuCG took effect **6 December 2025 with no transition period**, pulling roughly
29,500 entities across 18 sectors into scope, each of which "must contractually require
cybersecurity standards from their suppliers"
([YPOG](https://www.ypog.law/en/insight/germanys-nis2-implementation-act),
[Docusnap](https://www.docusnap.com/en/it-documentation/nis-2-directive-implementation-by-germany)).
UK Cyber Security and Resilience Bill: passed all Commons stages, Lords Committee Stage 1 Sep 2026,
Royal Assent expected late 2026, duties pushed down to suppliers by Relevant Managed Service
Providers ([Cloudswitched](https://www.cloudswitched.com/news/cyber-security-resilience-bill-lords-july-2026-uk-sme-msp-10-step-compliance-plan)).

**Who pays.** The supplier's founder or CTO — and what is at stake is **revenue, not a fine**. A
failed supplier security review loses the contract. That is a strictly stronger chequebook signal
than any penalty, because the loss is certain rather than probabilistic.

**Evidence money is already moving.** This is the same mechanism that makes SOC 2 readiness sell
per-deal, which JT has already identified as real. The German pass-down is documented across
multiple independent legal commentaries, and the cohort size (29,500 entities, a seven-fold
increase) sets the number of companies now obliged to send questionnaires downstream.

**Why underserved.** The market sells GRC platforms and questionnaire automation. Nobody fixes the
findings. A vendor who fails on "no evidence of tested restore" or "no centralised audit log" needs
code and infrastructure changed, and their own team is already at capacity shipping features.

**JT fit.** Good, with one caveat. The work is remediation on a web/Rails stack — squarely in
their wheelhouse. English-speakable. Reachable through the partner running the security review.
The caveat: this sits uncomfortably close to the already-killed "paid audit-then-remediate". It
only survives the kill if JT never sells the audit — the audit is the partner's product, JT is the
hands. Sold that way, the buyer is paying to fix, which is exactly what JT learned buyers do pay for.

**Kill risk.** It collapses back into the killed audit-then-remediate motion the moment JT is
tempted to do the assessment, because the assessment is easier to sell and impossible to charge for.

---

## 3. Accessibility remediation (BFSG / EAA) delivered white-label through agencies

**Service.** Agencies sell the audit; JT does the remediation engineering on server-rendered web
apps — semantic HTML, ARIA, keyboard operability, form labelling, contrast, accessibility statement.

**Forcing party and date.** Multiple, and unusually aggressive because enforcement is *private*:
- Germany (BFSG, live 28 Jun 2025): competitors via UWG, §4 UKlaG qualified bodies, and Länder
  market surveillance authorities. First Abmahnungen landed ~6 weeks after the law took effect;
  first Bußgelder in early 2026. Abmahnung cost €3,500–20,000; fines to €100,000
  ([7aufeinenstreich](https://www.7aufeinenstreich.com/blog/bfsg-bussgeld-abmahnung),
  [DOSIGNY](https://www.dosigny.com/blog/bfsg-2026-abmahnwellen-website-barrierefreiheit)).
- Netherlands: ACM sent information requests to e-commerce operators including non-EU-headquartered
  ones; audits spring 2026, active enforcement H2 2026.
- France: first EAA lawsuits filed November 2025.
- Ireland: the only member state with criminal liability — €60,000 and/or 18 months.
- **Hard backstop 28 June 2030**: every in-scope product and service must comply regardless of when
  it was released ([Accessible.org](https://accessible.org/does-eaa-apply-existing-services/)).

**Who pays.** The shop or service owner who received the letter. The pain is transactional and
immediate — a named sum on a named date.

**Evidence money is already moving.** A functioning white-label market exists with named 2025–2026
agency engagements (Anblik, Bay Area Web Solutions, a QA firm) buying audit and remediation under
their own banner ([Half Accessible](https://halfaccessible.com/case_study/white-label-accessibility-audits/),
[Accessible Pixels](https://www.accessiblepixels.com/agency-partners)). Published remediation
pricing: $2,000–8,000 for a small business site, $5,000–15,000+ for web applications
([adacompliant.io](https://adacompliant.io/blog/how-much-does-ada-compliance-cost-2026)).
Sweden's PTS has logged 124 public complaints — consumers are actively filing.

**Why underserved.** Auditing is commoditised and increasingly automated; overlay widgets are
discredited. The bottleneck is fixing, and agencies that sell audits have no engineering capacity
to follow through. Providers advertise that partners "can handle remediation directly if your team
doesn't have capacity" — that sentence is the market gap written out.

**JT fit.** Good and often misjudged. Accessibility remediation on server-rendered Rails is HTML,
ARIA and CSS, not a JavaScript specialism — JT's missing JS bench is not the blocker people assume.
English sales through an agency partner who owns the German client relationship neatly sidesteps
the B1 German problem. This is the "capacity through a partner" motion almost exactly.

**Kill risk.** The strongest one on this list. An Abmahnung lands on a *legal* budget line, and the
cheapest correct response is a lawyer's reply plus alt-text and contrast fixes — an afternoon, not a
project. The third-party force is genuine but the forced spend may be an order of magnitude below
what a remediation engagement costs. Validate by finding someone who paid for remediation rather
than paid a lawyer, before committing.

---

## 4. EU Data Act access-by-design — building the Article 3 data access API

**Service.** Build the user-facing data access path a connected product must have: authenticated
API or portal, machine-readable export (JSON), consent handling for third-party recipients, access
logging.

**Forcing party and date.** National competent authorities, with implementing legislation adopted
or advanced in Germany, Finland, the Netherlands and Poland. Three dates:
- 12 Sep 2025 — any EU user can demand their connected-product data, and require it be shared with
  a third party (live now).
- **12 Sep 2026** — connected products placed on the market after this date must be *designed* so
  data is directly accessible by default ("access by design").
- **12 Jan 2027** — all cloud switching charges and egress fees banned outright, with a functional
  equivalence duty on providers.

Sources: [Wilson Sonsini](https://www.wsgr.com/en/insights/eu-data-act-september-2026-deadline-what-businesses-need-to-know.html) ·
[Alston & Bird on switching](https://www.alston.com/en/insights/publications/2025/09/eu-data-act-switching-requirements-cloud-services) ·
[Sixteen Pillars, 12 Jan 2027](https://sixteenpillars.com/the-data-act-switching-deadline-egress-fees-disappear-on-12-january-2027-re/)

**Who pays.** Product owner at a connected-product manufacturer, or the platform lead at a cloud
or SaaS provider facing the January 2027 switching duty.

**Evidence money is already moving.** The DIHK — the German chambers of commerce — is publishing
"Data Act: next level as of 12 September 2026" directly to its member businesses
([DIHK](https://www.dihk.de/en/service-portal/for-business-owners-and-entrepreneurs/data-act-next-level-as-of-12-september-2026-174716)).
A trade body pushing a deadline at Mittelstand members is a reliable precursor to spend. Law firms
across the EU are running countdown alerts. Practitioner guidance is already technical rather than
legal, naming HTTP APIs, JSON, consent management, third-party onboarding and access logging as the
required measures.

**Why underserved.** It is still being handled as a legal question. The legal profession has
saturated the advisory side; nobody is selling "we will build the Article 3(1) access endpoint".

**JT fit.** Good for the API half — Rails API, auth, consent, logging is exactly the bench. Not for
the firmware/embedded half. Needs a partner who owns the device side.

**Kill risk.** Manufacturers already on an IoT platform (Azure IoT, ThingWorx, Bosch) get this
bundled by their platform vendor. And the obligation is qualified by "where relevant and technically
feasible", which is a soft escape hatch a reluctant buyer can sit behind indefinitely.

---

## 5. CRA vulnerability-handling and SBOM plumbing — real demand, weak JT fit

Reported because the demand evidence is the strongest of anything found, and the fit problem should
be recorded rather than rediscovered.

**Forcing party and date.** National market surveillance authorities via the ENISA Single Reporting
Platform. **11 September 2026**: 24-hour early warning and 72-hour full notification for actively
exploited vulnerabilities and severe incidents — and this applies to products already on the market
before Dec 2027, so legacy products are in scope now. **11 December 2027**: full requirements —
technical documentation, CE marking, SBOM, secure-by-default, update mechanism. Fines to €15m or
2.5% of worldwide turnover ([Jones Day](https://www.jonesday.com/en/insights/2026/07/eu-cyber-resilience-act-24hour-reporting-duties-start-september-11-2026),
[EC CRA reporting page](https://digital-strategy.ec.europa.eu/en/policies/cra-reporting)).

**Evidence money is already moving — quantified.** The OpenSSF 2026 CRA Awareness and Readiness
Report, 16 months before the full deadline: only **41%** of manufacturers expect full compliance by
December 2027, **39%** are entirely uncertain; only **32%** produce SBOMs for all products, flat
year-over-year; **51%** passively rely on upstream projects for security fixes, *up* from 46%;
unfamiliarity with the CRA *widened* to 66% from 62%
([OpenSSF](https://openssf.org/blog/2026/06/25/the-cra-readiness-reality-what-changed-and-what-didnt-between-2025-and-2026/)).
A gap that is getting worse as the deadline closes is the cleanest demand signal in this report.

**Why JT should probably not take it.** The buyer is an embedded/hardware manufacturer — pure
firmware, endpoint agents, OS, network equipment, IoT are in scope while pure SaaS is largely out
([DLA Piper](https://www.dlapiper.com/en/insights/publications/2026/02/cyber-resilience-act-the-fine-line-between-saas-and-digital-products)).
JT has no route to that buyer and no relationship equity there. The work itself is CI/CD pipeline
and security engineering — SBOM generation wired into builds, a signed update mechanism, a
disclosure-to-reporting pipeline — against a bench with no DevOps and no security specialists. And
the buyer will expect security credentials JT cannot show.

**Kill risk.** Cannot staff it; cannot reach the buyer; cannot show credentials. Three independent
kills. Record and move on.

---

## 6. EUDR due-diligence statement integration — real, but the date is not trustworthy

**Forcing party and date.** National competent authorities. 30 Dec 2026 for large and medium
companies plus micro/small in timber; 30 Jun 2027 for other micro/small operators. Operators must
submit electronic due diligence statements through the TRACES Information System; the Commission has
published updated API specifications ([EC green forum](https://green-forum.ec.europa.eu/nature-and-biodiversity/deforestation-regulation-implementation/information-system-deforestation-regulation_en),
[Access2Markets](https://trade.ec.europa.eu/access-to-markets/en/news/delay-until-december-2026-and-other-developments-implementation-eudr-regulation)).

**Who pays.** Supply chain or operations director at an operator or trader placing goods on the EU
market.

**Evidence.** A live vendor category — IntegrityNext, Bluugo Tracking Cloud, Tracex — all selling
EUDR compliance software today.

**Why it ranks last.** The SaaS field is already dense; the remaining gap is only ERP/WMS-to-TRACES
plumbing. The buyer is an agri/timber/commodity firm with no relationship to JT and likely
non-English procurement. And decisively: **EUDR has already been delayed twice**, and the Omnibus
simplification agenda makes a third delay plausible. A date that has moved twice is not a forcing
function you can build a service line on.

---

# Ranked shortlist

| # | Service | Forcing party | Hard date | Why this rank |
|---|---|---|---|---|
| 1 | E-invoicing last-mile integration | Tax authorities (PL, BE, FR, DE) | 1 Feb 2026 / 1 Sep 2026 / 1 Jan 2027 | Only candidate where non-compliance breaks *billing*, not just risks a fine. Pure Rails backend. Partner channel already exists and is actively recruiting integrators. Repeats per country. |
| 2 | NIS2 / CSRB supplier remediation | The regulated customer, via contract | DE in force 6 Dec 2025; UK Royal Assent late 2026 | Strongest chequebook — lost revenue, not a fine. Same mechanism as SOC 2, which JT already believes. Must never sell the audit. |
| 3 | Accessibility remediation, white-label | Abmahnung lawyers, §4 UKlaG bodies, ACM, Irish criminal liability | Live since 28 Jun 2025; backstop 28 Jun 2030 | Perfect channel fit and a proven white-label market — but forced spend may be a lawyer's fee, not a project. Validate the spend size first. |
| 4 | Data Act access-by-design API | National authorities + the user's direct right | 12 Sep 2026; 12 Jan 2027 (cloud switching) | Real, imminent, and treated as a legal problem by everyone selling into it. Held back by the "technically feasible" escape hatch and IoT-platform bundling. |
| 5 | CRA vulnerability/SBOM engineering | Market surveillance + ENISA SRP | 11 Sep 2026; 11 Dec 2027 | Best demand evidence found (OpenSSF: 41% ready, gap widening). Unreachable buyer, unstaffable work. |
| 6 | EUDR TRACES integration | National competent authorities | 30 Dec 2026 | Date has slipped twice; crowded SaaS; no route to buyer. |

**If only one is pursued: #1.** It is the single candidate where the forcing party's penalty is not
a fine but the inability to issue a valid invoice, the buyer is a software company (JT's native
buyer), the work is Rails backend, and the partner who owns the client relationship is actively
advertising for exactly this kind of delivery partner.

---

# Discarded, and why — do not re-explore

| Candidate | Why discarded |
|---|---|
| **EU AI Act high-risk obligations** | Deferred from 2 Aug 2026 to **2 Dec 2027** by the Digital/AI Omnibus ([DLA Piper](https://knowledge.dlapiper.com/dlapiperknowledge/globalemploymentlatestdevelopments/2026/The-Digital-AI-Omnibus-Proposed-deferral-of-high-risk-AI-obligations-under-the-AI-Act)). No forcing date inside 12 months. |
| **EU AI Act Art. 50 transparency** (live 2 Aug 2026, in force) | Real date, real enforcement — but the remediation is a disclosure notice and content marking. Days of work, not a service line. No budget owner. |
| **DORA** | Enforcement genuinely began in 2026, but the hardest deliverable is the Register of Information as an xBRL-CSV package — GRC/reporting work, sold by Big Four and regulated advisors to financial entities. JT has no financial-services credentials and no route to that procurement. |
| **eIDAS 2 / EUDI Wallet** | Member States must *offer* a wallet by 6 Dec 2026, but mandatory *acceptance* is **Dec 2027** and binds only regulated relying parties (banks, PSPs, telecoms, VLOPs). No SME chequebook inside the window, and the buyers are procurement-heavy regulated institutions. |
| **New Product Liability Directive (EU) 2024/2853** (transposition 9 Dec 2026) | Genuinely brings software under no-fault liability, but it creates *legal and insurance* work, not a named engineering deliverable. There is no artefact a customer can buy to be compliant. |
| **Digital Battery Passport** (18 Feb 2027) | Hard date, real software, but buyers are EV/industrial battery manufacturers with zero JT access, and the vendor field (Circularise, Scantrust, carbmee) is already dense with dedicated platforms. |
| **PCI DSS 4.0.1 client-side script requirements** (6.4.3 / 11.6.1) | Mandatory since 31 Mar 2025 and enforced by acquirers, but remediation is JavaScript inventory and CSP work — the specialism JT explicitly lacks. |
| **CSRD / ESRS** | Scope and timing gutted by the Omnibus. Date is not trustworthy. |
| **SEPA Instant Payments / PSD3** | Buyers are banks and PSPs only; procurement JT cannot reach. |
| **NIS2 audit sign-off** | Already killed by JT — accredited bodies only. Only the *remediation* variant (#2 above) survives, and only if JT never touches the assessment. |
| **GPSR** (live Dec 2024) | Marketplace listing-content obligations; absorbed by platform vendors, no bespoke engineering demand found. |
