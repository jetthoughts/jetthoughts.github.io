> DRAFT - A0 output. Each foundational assumption brainstormed → scored/voted → picked → given a pre-validation test with kill-criteria. Devil's-advocate applied at the end.

# Assumptions Register - Vibe Code Rescue

**Task**: A0 (new — foundational gate) | **Created**: 2026-07-21 | **Owner**: agent-built; Paul reviews the picks
**Why this exists**: Paul's rule — do not trust your gut; every foundational assumption (who the ICP is, how we find them, how we pre-validate them) must be brainstormed against alternatives, voted, and given a way to be proven wrong BEFORE the campaign leans on it. This is the "spar with other minds" mandate applied to the plan's premises, not just its deliverables.
**How to read**: each assumption lists the options considered, a weighted vote (1-5 per criterion), the pick, the rationale, and a **pre-validation test + kill-criteria** (what evidence would prove the pick wrong, and by when).

---

## A. WHO is the buyer (ICP)

**Options brainstormed**
- **A1** — Non-technical founder, pre-seed to Series A, whose MVP was built by a dev shop / freelancer / AI tool and is now failing on real users (current `90.10` "Alex").
- **A2** — Technical founder scaling past their own build (has a dev, wants senior architecture help).
- **A3** — Seed VCs / accelerators as the *buyer* (they pay to rescue a portfolio company).

**Vote** (criteria weighted for a 1-client-by-Nov-30 goal)

| Option | Reachable (×2) | Feels the pain acutely (×2) | Can decide + pay solo (×2) | Budget fit $25-50K (×1) | Total /35 |
|---|---|---|---|---|---|
| A1 non-tech burned founder | 5 | 5 | 4 | 4 | **32** |
| A2 technical scaling founder | 4 | 3 | 4 | 3 | 25 |
| A3 VC/accelerator as buyer | 2 | 2 | 3 | 4 | 17 |

**Pick: A1** — the non-technical burned founder. **Rationale**: highest pain acuity (they can't self-diagnose, so the free audit has unique value to them), decides alone under $50K, and the trust/ownership wedge lands hardest here. A3 (VCs) is kept as a *channel* (they refer A1), not the buyer.
**Pre-validation test**: of the first 10 discovery calls, ≥6 must be non-technical founders with an outsourced/AI build already live and breaking. **Kill-criteria**: if ≥half of early qualified interest comes from technical founders or from pre-launch (no live app), re-open this vote — the ICP is drifting to A2.

---

## B. WHICH trigger is the sharpest buying moment

**Options brainstormed** (from `icp-trigger-taxonomy.md` — vote picks the LEAD bet, not the only one)
- **B1** — "App broke after launch / at scale."
- **B2** — "Dev shop holds my code / I can't get access" (ownership hostage).
- **B3** — "About to sign a dev contract over $25K and can't evaluate it."

**Vote**

| Option | Volume (×1) | Urgency-to-pay (×2) | Fits our wedge trust+ownership (×2) | Differentiates from 6 competitors (×2) | Total /35 |
|---|---|---|---|---|---|
| B1 broke at scale | 5 | 4 | 3 | 2 | 26 |
| B2 code hostage | 3 | 5 | 5 | 5 | **36 (cap 35→35)** |
| B3 evaluating a $25K contract | 3 | 4 | 4 | 4 | 27 |

**Pick: B2 (ownership hostage) as the LEAD wedge, B1 as the volume top-of-funnel.** **Rationale**: every competitor leads with "your vibe-coded app is breaking" (B1) — it's saturated. B2 (you don't own/can't access your own code) is where JT's differentiator (ownership handed back at each milestone + Paul as trust layer) is unique and un-copied. B1 still fills the funnel by volume; B2 is what the offer/openers LEAD with.
**Pre-validation test**: in openers, an ownership-led message must out-reply an app-broke-led message across the first ~20 cold touches. **Kill-criteria**: if ownership framing gets < half the reply rate of the breaking-app framing, demote B2 to a secondary angle.

---

## C. HOW we find them (primary find-channel)

**Options brainstormed**
- **C1** — Warm intros + past-client referrals (Paul's network / Gmail).
- **C2** — Cold community sourcing (Reddit/IndieHackers/HN/X tool-help venues).
- **C3** — Paid cold funnel (Apollo Professional + Hunter, filtered by stage/stack).
- **C4** — Inbound (SEO cluster + landing).

**Vote** (for the Nov-30 window specifically)

| Option | Speed to first call (×2) | Conversion / trust (×2) | Cost + setup now (×1) | Repeatable later (×1) | Total /30 |
|---|---|---|---|---|---|
| C1 warm + referral | 5 | 5 | 5 | 3 | **28** |
| C2 cold community | 4 | 3 | 5 | 4 | 23 |
| C3 paid cold funnel | 3 | 2 | 2 (needs Paul $79/mo) | 5 | 19 |
| C4 inbound SEO | 1 | 4 | 3 | 5 | 17 |

**Pick: C1 primary (warm + referral), C2 secondary (agent-sourced cold community).** **Rationale**: warm converts fastest and carries the trust the burned ICP demands; C2 is the agent-unattended top-up that doesn't wait on Paul. C3 (paid) is a deliberate *later* upgrade once a channel proves reply interest (runbook rule 3). C4 (SEO) cannot rank by Nov 30 — Q1-2027 compounding only.
**Pre-validation test**: warm channel must produce ≥3 booked calls before we invest setup time in C3. **Kill-criteria**: if 2 weeks of warm outreach yields 0 booked calls, the ICP-to-network fit is wrong — pause and re-open A + C before spending on paid.

---

## D. HOW we pre-validate a prospect BEFORE Paul spends a 45-min call

**Options brainstormed**
- **D1** — Self-reported symptom only (they say it's breaking).
- **D2** — A repo-access gate (can they give read access to the code?).
- **D3** — A short pre-qual checklist scored before booking (symptom + build-origin + funding stage + repo access + live users).
- **D4** — Tech-stack fingerprint (inspect their live site to confirm a Lovable/Bolt/Firebase build).

**Vote**

| Option | Filters time-wasters (×2) | Cheap to run (×2) | Surfaces the buying moment (×1) | Founder-friendly (not interrogating) (×1) | Total /30 |
|---|---|---|---|---|---|
| D1 symptom only | 2 | 5 | 4 | 5 | 23 |
| D2 repo-access gate | 4 | 5 | 4 | 3 | 21 |
| D3 pre-qual checklist | 5 | 4 | 5 | 4 | **27** |
| D4 stack fingerprint | 4 | 3 | 3 | 5 | 22 |

**Pick: D3 (the 5-question pre-qual checklist), with D2's repo-access as one of its questions and D4 as an optional agent-side enrichment.** **Rationale**: the booking intake (S0) already asks the 5 questions — company+site, what it was built with, what's breaking, funding stage, repo access. That IS the pre-validation: it filters non-ICP and confirms the audit is deliverable (need read access) before Paul's 45 minutes. Agents can add D4 (inspect the site's scripts to confirm an AI-built stack) as extra evidence on a cold row.
**Pre-validation test**: track the show-up + qualified rate of booked calls. **Kill-criteria**: if > 40% of booked calls turn out non-ICP or un-auditable (no repo access), tighten the intake (make repo-access a hard gate, not a question).

---

## E. Supporting assumptions (logged, lighter vote)

| # | Assumption | Options → pick | Pre-validation / kill |
|---|---|---|---|
| E1 | **Offer = free 45-min audit → fixed $25-50K rescue** | free vs paid audit; fixed vs T&M → **free audit + fixed price** (removes the burned founder's #1 fear: another open-ended bill) | if free audits don't convert to paid proposals at all after ~5, test a paid ($ nominal) audit to filter tire-kickers |
| E2 | **Distribution = push (outbound/warm), not pull (SEO), for Nov 30** | push vs pull → **push** | SEO stays queued for Q1-2027; kill only if push proves it can't produce calls |
| E3 | **Delivery via white-label partner, Paul as trust layer (G0)** | in-house vs white-label → **white-label + named fallback** | validated by a PAID TRIAL rescue before selling (G0 gate); kill/switch to fallback if trial misses the quality bar |
| E4 | **Wedge vs competitors = ownership handback + named fractional CTO** | audit-quality vs price vs ownership/trust → **ownership + trust** (price is a race to the bottom against 6 shops) | if openers leading with ownership under-reply vs price/speed, re-open (ties to B) |

---

## Devil's-advocate refute (per 4-eyes mandate)

**Prompt**: refute the picks — where is this still gut, not evidence?
- **Holds**: A, B, C, D are all voted on *assumed* criteria weights and *my* scores — no live founder has confirmed them yet. That's unavoidable pre-launch, which is exactly why each pick has a **pre-validation test + kill-criteria** tied to the first ~10 calls / ~20 touches. The register is a set of falsifiable bets, not proven facts. Honest framing kept.
- **Holds**: B2 (ownership-hostage lead) scored highest partly on "differentiates from competitors," which is a marketing bet, not a demand bet — founders in a hostage situation may be rarer than founders whose app merely breaks. Mitigation: run B1 (volume) and B2 (wedge) in parallel and let reply data pick; do not bet the funnel on B2 alone. Wired into B's kill-criteria.
- **Holds**: C1 (warm) assumes Paul's network actually contains ICP-adjacent founders. If it doesn't (his network skews enterprise/agency), C1's speed advantage evaporates. Mitigation: T3 Gmail warm-mine will reveal the real warm-list size early; C's kill-criteria (0 calls in 2 weeks) catches a thin network fast.
- **Does NOT hold / dropped**: no option here is unsupported hand-waving — each traces to the taxonomy research or the market validation in the strategy doc.

**Verdict**: PASS as a *falsifiable* register. Every pick is a bet with a named test and a kill-condition on the first cohort of calls/touches. Paul reviews the picks; the tests run automatically as calls come in (OS-WEEKLY scorecard tracks them).

---

## Sources
- ICP: `docs/90-99-content-strategy/strategy-analysis/90.10-icp-primary-website-target.md`
- Triggers + venues: `icp-trigger-taxonomy.md`, `sourcing-pipeline.md` (T1/T2 + parallel research)
- Market/pricing validation: `strategy.md`
