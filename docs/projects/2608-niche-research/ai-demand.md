# AI-driven work someone is actually paying for — August 2026

Lane: AI-adjacent services with a **named third party forcing the spend** and a **date**. Enthusiasm,
conference talks and vendor blog posts are not evidence here. Fee schedules, statutory deadlines,
insurance forms and procurement gates are.

Bottom line: of the eight areas investigated, **three** survive with a real forcing party and a date,
**two** are genuinely funded but need a bench JetThoughts does not have, and **four** are loud and
unfunded. The single largest verified fact in this lane is not an AI fact at all — it is an insurance
form number.

---

## Shortlist

### 1. Article 50 provenance and disclosure build-out (EU AI Act)

**Service.** Implement the machine-readable marking, disclosure surface and evidence log that the EU AI
Act's transparency regime requires of any product that generates text, image, audio or video output —
C2PA Content Credentials signing on the generation path, a first-contact AI disclosure in the UI, and a
retained record showing what was marked and when.

**Forcing party and date.** National market surveillance authorities, live now.
- Article 50 applied from **2 August 2026**; fines up to **€15m or 3% of worldwide turnover**
  ([Commission FAQ](https://digital-strategy.ec.europa.eu/en/faqs/transparency-obligations-under-article-50-ai-act)).
- The Digital Omnibus on AI **entered into force 27 July 2026** and deferred the *high-risk* chapter to
  2 Dec 2027 / 2 Aug 2028 — it did **not** defer Article 50. It left a grace period only for the
  marking obligation on systems already on the market before 2 Aug 2026, which expires **2 December
  2026** ([Freshfields](https://www.freshfields.com/en/our-thinking/blogs/technology-quotient/eu-ai-act-unpacked-34-the-final-digital-omnibus-on-ai-key-amendments-to-the-a-102nber),
  [Commission](https://digital-strategy.ec.europa.eu/en/news/ai-omnibus-enters-force)).
- Watermark-detection interoperability follows on **2 February 2027**.
- In Germany the enforcer has a name and a start date: the **KI-Marktüberwachungsgesetz (KI-MIG)** passed
  the Bundestag **11 June 2026**, making the **Bundesnetzagentur** the central market surveillance
  authority from **2 August 2026**, with powers to request documents, test systems and demand
  remediation ([Bundestag](https://www.bundestag.de/dokumente/textarchiv/2026/kw13-pa-digitales-1155576),
  [datenschutzticker](https://www.datenschutzticker.de/2026/03/ki-marktueberwachungsgesetz-ki-mig-folgen-fuer-unternehmen/)).

This is deliberately **not** the killed "AI Act high-risk readiness" pitch. That one sold a deadline
that moved to 2027/2028. This one sells a deadline **fourteen weeks out** that the Omnibus explicitly
left in place while moving everything around it.

**Who pays.** The company that *ships* a generative feature — Article 50(2) binds the **provider** of
the AI system, and a SaaS that puts a "generate a draft" button in front of users is a provider, not a
bystander. Deployer duties are non-delegable: calling the OpenAI or Anthropic API does not transfer
them to the model vendor
([Tech Times, 31 Jul 2026](https://www.techtimes.com/articles/322563/20260731/eu-ai-act-chatbot-disclosure-reaches-api-builders-sunday-vendors-cannot-comply-you.htm)).
The pain lands on the founder/CTO who signed the EU customer contracts, not on a compliance department.

**Evidence of money already moving.** Weakest link in this candidate, and worth saying plainly. There is
no public fee schedule for Article 50 implementation. What exists:
- **78% of organisations had taken no meaningful compliance step as of April 2026**
  ([Legal Nodes](https://www.legalnodes.com/article/eu-ai-act-2026-updates-compliance-requirements-and-business-risks)) —
  a backlog, not a proven budget.
- Third-party certification of a single AI system is quoted at **$50,000+**, and legal/consulting spend
  is already flowing to law firms and Big-4 on the *advisory* half. Nobody in that chain writes the
  signing pipeline.
- The Commission's draft Transparency Code of Practice names **C2PA Content Credentials** by example as
  the technical mechanism ([Bird & Bird](https://www.twobirds.com/en/insights/2026/taking-the-eu-ai-act-to-practice-the-final-transparency-code-of-practice)),
  and the spec is royalty-free with MIT-licensed tooling — so the work is implementation, not licensing.

**Why underserved.** The advisory market answers *whether* you are in scope; almost nobody ships the
diff. Lawyers produce a memo, compliance SaaS produces a checklist, and the client is left holding an
engineering task on a Rails codebase. The gap between "your gap analysis says you must mark output" and
"output is marked" is exactly one senior contractor for a few weeks.

**JT fit.** Good. Metadata signing, a disclosure component, an audit log and a CI check are ordinary
web engineering — no ML specialists, no JavaScript specialists required for a server-side signing path.
Sellable in English. **Best partner motion in the whole report:** the natural referrer is the AI-Act
advisory firm or law firm that already produced the client's gap analysis and cannot implement it.
That is a partner who already owns the client and has a document naming the work.

**Kill risk.**
- The chatbot-disclosure half is a one-line UI change nobody will pay for. Only the marking/provenance
  half carries hours. Pitch only the half that has work in it.
- Model vendors may ship marking upstream and shrink the job to configuration.
- The 2 Dec 2026 date is itself a moved date (from 2 Aug 2026). Buyers who noticed the Omnibus move
  everything else may reasonably bet this one moves again. That objection is fair and must be answered
  with the Bundesnetzagentur's live powers, not with the date alone.

---

### 2. The evidence record insurers and enterprise buyers now demand for AI-generated code

**Service.** Build the artefact trail a company must hand over when its insurer, its enterprise customer
or an acquirer asks what the AI wrote: an AI system register (models, versions, prompts, change logs),
provenance marking on generated code paths, and dependency validation against hallucinated packages,
wired into CI so the record maintains itself.

**Forcing party and date.** Two, converging.

*Insurance — the hardest-edged fact in this report.* **Verisk/ISO filed three generative-AI exclusion
endorsements for commercial general liability — CG 40 47, CG 40 48 and CG 35 08 — effective 1 January
2026.** CG 40 47 removes bodily injury, property damage and personal & advertising injury arising out of
generative AI; the definition explicitly includes systems that generate **code**. ISO forms underpin
roughly **82% of global P&C policies**
([Independent Agent](https://www.independentagent.com/vu_resource/verisk-to-roll-out-new-general-liability-exclusions-for-generative-ai-exposures/),
[Gridex form breakdown](https://gridex.dev/blog/verisk-ai-exclusions/)).
Berkley and Chubb have been reported cutting AI-related cover across D&O, E&O and fiduciary lines
([Fenwick](https://www.fenwick.com/insights/publications/end-silent-ai-emerging-ai-exclusions-coverage-fragmentation-and-practical-implications)).
The forcing date is each policyholder's **renewal date** — a recurring, non-negotiable calendar event
that lands on the founder or CFO.

*Customers.* Supplier contracts in 2026 increasingly require the supplier to **maintain an AI system
register for the services, including model versions, prompts and change logs**, and to indemnify on the
provenance of what was generated
([ThoughtRiver](https://www.thoughtriver.com/resources/ai-clauses-in-commercial-contracts-a-practical-guide-part-2),
[Bloomberg Law sample clause](https://www.bloomberglaw.com/external/document/X99TEG3G000000/commercial-sample-clause-pro-supplier-artificial-intelligence-us)).
SBOMs have no field for generated code, so the question arrives with no standard answer.

*Live threat backing it.* Slopsquatting is documented, not theoretical: the `unused-imports` npm package
was still live at ~233 weekly downloads in **February 2026**; `huggingface-cli` reached 30,000+ downloads
after Alibaba copied an AI-suggested install command into public docs; `react-codeshift` propagated
through **237 repositories via AI-generated agent skills**, with downloads driven by autonomous agents
rather than humans
([CSA research note, 19 Apr 2026](https://labs.cloudsecurityalliance.org/research/csa-research-note-slopsquatting-ai-supply-chain-20260419-csa/)).

**Who pays.** The company whose renewal or enterprise deal is blocked. Insurance and a stalled contract
both land on the chequebook directly.

**Evidence of money already moving.** Partial and I will not overstate it. The exclusions are filed and
dated — that is verified. The claim that *documented controls* move an underwriter from "decline" to
"terms" comes from risk-advisory marketing, not from carrier underwriting guidelines; I fetched the
[RM Magazine piece (4 Aug 2026)](https://www.rmmagazine.com/articles/article/2026/08/04/protecting-your-organization-from-ai-insurance-exclusions)
directly and it names **no carrier and no date** behind its control requirements. Fixed-fee AI-inventory
diagnostics are being sold today, but the buyers are **insurers themselves** under the NAIC model
bulletin, not ordinary software companies. **Verdict: forcing party proven, budget not yet proven.**

**Why underserved.** The security firms sell testing, the compliance vendors sell a register as SaaS,
and neither wires the record into a client's actual build pipeline where it stays true.

**JT fit.** Good on the bench — CI work, dependency policy, structured logging, all Rails-shop territory.
**But the overlap with already-killed work is the thing to watch.** "Retained AI-code custodian" was
killed on the finding that nobody buys prevention. The only version of this that is not that dead
service is the one where the deliverable is **the evidence a third party demanded**, with the renewal
date or the contract clause named in the first sentence. If the pitch slides back into "we keep your
AI code clean", it is the dead one wearing a new hat. Do not ship it until a broker or a real customer
clause is in hand.

**Kill risk.** High. The chain from "exclusion exists" to "buyer pays a dev shop" is unproven, and
brokers may satisfy underwriters with paperwork alone. Validate with one broker conversation before
building anything.

---

### 3. ISO 42001 evidence plumbing, subcontracted under a certification consultancy

**Service.** Build the logging, model inventory, data-lineage and audit-trail plumbing an AI management
system needs to pass Stage 2 — the engineering half of a certification that consultancies currently
deliver as documents.

**Forcing party and date.** The **enterprise buyer's procurement gate**, at each deal. In 2026 SOC 2
Type II moved from badge to baseline and the differentiator became the AI governance layer on top;
CAIQ, SIG Lite and most internal vendor-risk templates now carry sections on model provenance, training
data rights, hallucination controls, AI subprocessor transparency and alignment to **ISO 42001** and the
NIST AI RMF
([Aetos](https://www.aetos-data.com/answers-insights/enterprise-security-ai-questionnaires),
[soc2auditors.org](https://soc2auditors.org/insights/soc-2-for-ai-companies/)).
ISO 42001 is now **demanded contractually by enterprise and public-sector buyers**.

**Who pays.** The vendor whose deal is gated. This is the cleanest "third party forces it" chain in the
report: no certificate, no contract.

**Evidence of money already moving — the only published fee schedules in this lane.**
- Total certification: **$15k–$200k**; small companies $15k–$40k, mid-size $40k–$90k, large enterprise
  $90k–$200k+ ([Compyl](https://compyl.com/blog/iso-42001-certification-cost/), [Vanta](https://www.vanta.com/collection/iso-42001/iso-42001-certification-cost)).
- Certification-body audit fees: **Schellman $20k–$40k** for year one Stage 1+2; **BSI and DNV
  ~$25k–$50k** ([Truvo](https://truvocyber.com/blog/iso-42001-certification-cost), [Elevate](https://elevateconsult.com/insights/iso-42001-certification-cost-breakdown-what-enterprise-ai-teams-pay-in-2026/)).

Money is unambiguously moving. The open question is what share reaches an engineering supplier rather
than the auditor and the policy writer.

**Why underserved.** Certification consultancies write the AIMS documentation and then hit a wall: the
evidence the auditor wants — actual logs, an actual inventory that reflects the running system — has to
exist in the client's software. They subcontract or the client stalls.

**JT fit.** Good, and it is **the strongest partner motion after candidate 1**: sell capacity to the
certification consultancy, who already owns the client, already has a signed engagement and already has
a Stage 2 date. English-speaking, no ML specialists, no direct sales required — which matches the
15-minutes-a-day constraint better than anything else here.

**Kill risk.** JetThoughts has no compliance credentials, so it can only ever be the subcontractor —
which caps margin and puts the relationship one layer from the client. Compliance-automation SaaS
(Vanta, Drata) is expanding into exactly this evidence-collection layer and may absorb the generic half.

---

## Funded, but the wrong bench

These have real money and real forcing parties. They are listed so nobody re-researches them expecting
a JetThoughts opportunity.

**AI red teaming / prompt-injection testing.** Published fee schedules: one-time audits **$8k–$25k**,
multi-agent engagements **$50k–$150k**, continuous testing from **$5k/month**; **Schellman's floor is
$16k** per engagement; market sized at **$2.26bn in 2026**
([AI Vyuh pricing survey](https://security.aivyuh.com/blog/ai-red-teaming-pricing-2026/),
[Schellman](https://www.schellman.com/services/penetration-testing/ai-red-teaming)).
Forcing party is enterprise procurement and, increasingly, insurers. Real budget, genuinely underserved
in Europe. **Requires offensive-security specialists JetThoughts does not have and cannot credibly
rent** — buyers check credentials in this category specifically.

**LLM inference cost reduction.** The bill is large enough to be a job: **nearly three-quarters of
enterprises went over AI budget last year** and inference is now the **second-largest line item in
enterprise AI budgets, behind only talent**; **98% of FinOps respondents now manage AI spend, up from
63%**; documented savings of **30–60%** via caching, model tiering and routing
([State of FinOps 2026 via DigitalApplied](https://www.digitalapplied.com/blog/ai-inference-cost-optimization-finops-playbook-2026),
[Spheron](https://www.spheron.network/blog/ai-inference-cost-economics-2026/)).
Contract inference-optimisation specialists bill **$110–$200/hour**. Two problems: the forcing party is
an **internal** CFO, not a third party with a date — which fails JetThoughts' own first filter — and the
work needs infrastructure and model-serving depth the bench does not have. A crowded tool market
(nOps, Opslyft and others) is eating the generic layer.

---

## Loud but unfunded

The four AI services with the most noise and the least evidence of anyone writing a cheque. This list
is the point of the exercise as much as the shortlist is.

**1. Evals-as-a-service — the loudest unfunded thing in AI right now.** Every AI engineering blog in
2026 says "you need evals". No third party requires them: no regulator, no auditor, no procurement gate
names evals as a condition. The money that does exist splits into two pools neither of which is a
services business for a European dev shop: **platform subscriptions ($249–$10,000+/month)** and
**human-labelling labour**, where the average US LLM evaluator earns **$65,471/year** — that is data
annotation, not consulting ([ZipRecruiter](https://www.ziprecruiter.com/Jobs/Llm-Evaluation),
[AI Superior](https://aisuperior.com/cost-of-private-llm-evaluation-services/)).
The "$125k–$820k annual custom evaluation projects" figure circulating in 2026 traces to a single
vendor's own pricing page, not to a published contract. Evals are bought by AI labs and by companies
already at scale, both of whom build in-house. **Discard.**

**2. RAG over legacy and internal company data.** Enormous interest, and the money reliably dies at the
pilot. **S&P Global: the average organisation scrapped 46% of AI proofs-of-concept before production**,
and large enterprises abandoned **2.3 AI initiatives each in 2025 at an average sunk cost of $7.2m**.
**IDC: for every 33 PoCs an enterprise starts, four reach production.** **Gartner: 60% of AI projects
without production-ready infrastructure will be abandoned through 2026**, and at least 50% of GenAI
projects were already abandoned after PoC. For agents specifically, **Gartner puts pilot-to-production
failure at 89%**
([S&P/IDC roundup](https://wizr.ai/blog/enterprise-ai-pilots-fail-to-reach-production/),
[Gartner](https://www.gartner.com/en/articles/genai-project-failure)).
This is not "hard to sell" — it is easy to sell and then cancelled, which is worse for a small firm
carrying contractors. The buyer is an innovation budget with no forcing party and no date. **Discard,
or take only at day rate with no pipeline assumption.**

**3. Agent operations as a managed service — "we run your agents".** The demand signal is real but it
points at **employment, not outsourcing**: **90,000 agentic-AI job postings in 2026, up 280% YoY**, at
**$185k–$320k base**, and **88% of companies that deployed agents are increasing budgets**
([KORE1](https://www.kore1.com/agentic-ai-hiring-2026/), [Forbes, Apr 2026](https://www.forbes.com/sites/josipamajic/2026/04/13/enterprise-ai-agents-are-entering-production-and-changing-who-gets-hired/)).
Every euro found in this search is being spent on in-house hires or on platform licences (**$2–$5 per
agent action** on Agentforce/ServiceNow). Managed automation retainers exist at **$500–$2,500/month** —
small-business workflow automation, not enterprise agent operations. **No evidence anyone is paying a
third party to operate their agents.** Companies that trust agents with money and customer data are not
handing the keys to a supplier. **Discard.**

**4. "AI features demanded by an enterprise customer as a condition of renewal."** Investigated as
briefed; **the forcing arrow points the other way.** Vendors are pushing AI into renewals and buyers are
resisting: the dominant 2026 vendor strategy is to bundle AI into existing plans and raise the plan
price rather than price it as an add-on, producing a **20–37% "AI tax" on standard enterprise renewals**
and friction with customers who feel they are paying for features they did not request
([Baytech](https://www.baytechconsulting.com/blog/saas-pricing-shift-negotiate-ai-driven-renewals),
[Zylo](https://zylo.com/blog/saas-pricing-trends)).
Buyers in 2026 are demanding **outcome data to justify** AI spend, not demanding more AI. There is a
real service hiding on the *opposite* side of this trade — helping buyers resist the AI tax — but that
is procurement advisory, not software delivery. **Discard as briefed.**

---

## What I would do with this

One conversation each, in this order, before any positioning work:

1. **An AI-Act advisory or law firm that has issued Article 50 gap analyses.** Ask what happens after
   the memo. If the answer is "the client sits on it", candidate 1 has its partner and its 2 December
   deadline.
2. **A certification consultancy doing ISO 42001 Stage 2 work.** Ask whether they subcontract evidence
   plumbing today, and to whom. Published fees mean the budget question is already answered.
3. **A commercial insurance broker.** Ask directly whether documented AI controls change terms, or
   whether the paperwork alone clears the renewal. This one question kills or confirms candidate 2, and
   costs nothing.

Candidates 1 and 3 both sell **capacity through a partner who already owns the client** — the motion
that already works — and neither needs ML engineers, JavaScript specialists or cold outreach.
