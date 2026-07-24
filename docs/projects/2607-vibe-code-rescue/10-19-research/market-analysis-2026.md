# Market Analysis & Estimations - Vibe Code Rescue (2026)

**Created**: 2026-07-22 | **Owner**: agent-built; Paul reviews | **Feeds**: [`../executive-summary.md`](../executive-summary.md) demand section, [`../strategy.md`](../strategy.md)
**Rule on numbers**: hard figures are cited to a source. Anything JT derived (funnel percentages, prospect counts, rescue-market size) is labelled **[ESTIMATE]** with the assumption chain shown, so a reader can challenge the math, not just the conclusion.

> **Excluded on purpose**: Mordor Intelligence's "Vibe Coding Market $7.06B" report describes *haptic/vibration* coding (actuators, feedback ICs) - a different market that happens to share the name. It is NOT AI-app vibe coding and is not used here.

---

## 1. The market context (hard, sourced numbers)

The pool of AI-built software is enormous and growing fast, and it skews to exactly our buyer - the non-technical founder.

| Signal | Number | Source |
|---|---|---|
| Vibe-coding *tools* market (AI app builders, not haptics) | ~$4.7B in 2026, ~38% CAGR, ->$12.3B by 2027 | findskill.ai, secondtalent.com |
| Lovable users | 8M+ global (Q3-Q4 2025); **200,000+ new projects created per day** | shipper.now, findskill.ai |
| **Who builds on Lovable** | **45.7% are founders; ~80% have no technical background; only ~6% are engineers; 80% build solo** | Lovable "Build Economy" report (via subhrajyotimahato.com) |
| Cursor | 360,000 paying users, 7M developers, ~$2B ARR | findskill.ai |
| Replit | 50M people have used it; $240M revenue | findskill.ai |
| Apple App Store | **235,800 new apps submitted Q1 2026, +84% YoY** | findskill.ai |
| YC Winter 2025 cohort | 21% had codebases 91% AI-generated | secondtalent.com |
| AI-generated code that fails security tests | ~45% (OWASP Top 10 vulns) | Veracode 2025 GenAI Code Security Report |
| AI-introduced issues that survive into shipped code | 24.2% overall, 41.1% for security | Liu 2026, arXiv:2603.28592 |
| Startups whose audited AI build had 3+ critical production failures | 43 of 50 | AttributeX audit |

**Read**: millions of apps are being built by non-technical founders (the ICP), a large share ship with real defects, and the volume is compounding (+84% app submissions YoY). The supply of broken, founder-owned code is large and rising.

---

## 2. Rescue-market sizing

The $4.7B is *tool spend*, not rescue spend. The rescue market is the downstream services layer. No analyst tracks "vibe code rescue" yet, so we estimate it two ways and mark every derived number.

### Top-down [ESTIMATE]
- Assume order-of-magnitude **1,000,000 net-new AI-built apps/year reach real users** in the US (conservative: Apple alone took ~940K submissions/year at the Q1-2026 run-rate; most are hobby, so we keep a fraction). **[ASSUMPTION]**
- Apply a **live-and-breaking** filter of ~15% (apps that get real users AND hit production failures worth paying to fix - well below the 45-86% raw defect rates, to exclude hobby/abandoned). **[ASSUMPTION]** -> ~150,000 breaking apps.
- Apply the **funded, non-technical, budget-holding ICP** filter of ~5% (pre-seed to Series A with $25K+ to spend). **[ASSUMPTION]** -> **~7,500 US ICP-fit rescue prospects/year**.
- At a $25-50K engagement (say $30K blended), that is a **~$225M/year serviceable US rescue market [ESTIMATE]** - order of magnitude, not precision.

### Bottom-up [ESTIMATE]
- Lovable alone: 8M users x 45.7% founders = ~3.6M founder-users. Even at a 0.1% "funded + live + breaking + actively seeking help right now" slice, that is **~3,600 in-market prospects** from one platform - before Bolt, Replit (50M users), Cursor, dev-shop builds, or freelancer builds. **[ASSUMPTION on the 0.1%]**

Both methods land in the **thousands of reachable ICP prospects per year** range. The two independent estimates agreeing on order of magnitude is the useful part; the exact figure is not.

### SOM - what JetThoughts actually needs
- The Autumn goal is **1 signed client** from ~8-12 discovery calls from ~30 sourced prospects.
- Against a pool of thousands, JT needs to reach **well under 1%** of the in-market prospects to hit the goal.
- **Conclusion: market size is not the constraint.** Sourcing, trust, and conversion are. This reframes the whole operation - we are not fighting for scarce demand; we are competing to be the trusted choice for a buyer who has options.

---

## 3. Pricing benchmarks (what the market pays)

| Anchor | Number | Source |
|---|---|---|
| Rescue / remediation engagement | $25-50K, 4-8 weeks, keep 30-50% of code | strategy.md market scan (reptile.haus, foundra.ai, etc.) |
| Rails competitor public floor | $100/hr, **$25,600 engagement minimum** | JetRockets |
| Fractional CTO retainer (solo) | $5,000-$15,000/mo | JetRockets FAQ (Groovy Web 2026 comparison) |
| Proof point | YC SaaS broken MVP rebuilt in 6 weeks for fixed $40K vs a $150K agency quote | strategy.md |

Our band ($25-50K) sits at the market floor-to-mid, consistent with published competitor minimums. We do not need to discount to be credible.

---

## 4. Competitive density (demand proof, and the wedge pressure)

Six-plus players already run the "free audit -> fixed-price rescue" motion: Modall (named "vibe code cleanup and recovery"), HeyDev, AttributeX, Autonoma, solo specialists, and Rails shops (JetRockets). A formed competitor market is the strongest demand proof - businesses do not organize around a job nobody pays for. It also means a generic "free audit" opener is saturated; our wedge has to be **ownership + trust + Paul as the named fractional CTO**, not the audit mechanic (see `../rescue-sprint/customer-profile-four-forces.md`).

---

## 5. Assumptions & confidence

| Claim | Confidence | Why |
|---|---|---|
| The AI-built-app pool is huge and founder-heavy | **High** | multiple independent sourced figures (Lovable, Cursor, Replit, Apple, Lovable Build Economy) |
| A large share ships broken | **High** | Veracode 45%, Liu 24.2/41.1%, AttributeX 43/50, Columbia DAPLab "70% wall" |
| Thousands of ICP-fit rescue prospects/year exist | **Medium** | order-of-magnitude; two methods agree, but the filter percentages are JT assumptions |
| ~$225M/year US serviceable rescue market | **Low-Medium** | derived from stacked assumptions; treat as scale, not a figure to quote externally |
| Market size is not JT's constraint | **High** | even the most conservative funnel leaves >>30 reachable prospects; JT needs 1 client |

---

## 6. LIGHT cold-eyes gate (self-refute)

**Refute**: "Are these estimations honest, or motivated numbers?"
- The one genuinely misleading citation (Mordor's $7.06B) was caught and excluded - it is a different market. That is the tell of a real audit, not a pitch.
- The rescue-market size is a stack of assumptions and is labelled Low-Medium confidence; it should not be quoted externally as fact. Flagged in the table.
- **The honest headline is not the $225M** (soft) - it is that **JT needs <1% of a demonstrably large, founder-heavy, actively-in-pain pool**, so the bet rides on execution and trust, not on market existence. That claim is High confidence and is what the strategy leans on.
**Verdict**: PASS as an order-of-magnitude sizing with confidence labels. Do not present the derived dollar figures as precise; do present the "market is not the constraint" conclusion.

---

## Sources
- findskill.ai/blog/vibe-coding-by-the-numbers; secondtalent.com/resources/vibe-coding-statistics; shipper.now/lovable-stats; subhrajyotimahato.com/blog/vibe-coding-statistics (Lovable Build Economy); techcrunch.com (Lovable mobile launch); masteringai.io/state-of-vibe-coding-2026
- Veracode 2025 GenAI Code Security Report (via rootsanalysis.com); Liu 2026 arXiv:2603.28592
- Pricing: JetRockets (jetrockets.com/blog/fractional-cto-and-ai-agents); strategy.md market scan
- **Excluded**: mordorintelligence.com/industry-reports/vibe-coding-market (haptic/vibration coding - different market)
