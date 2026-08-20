# Architecture Decision Record: How design changes are validated on a static site

**ADR-0004**
**Date:** 2026-08-20
**Status:** Proposed

## Title

Validation gates for site changes: why A/B testing is not available at current
traffic, what replaces it, and the threshold at which it becomes available.

## Context

The design-system rollout (ADR-0003) asks for an experiment before each big
change. Three constraints decide what that can actually mean, and the first one
is decisive.

### 1. Real traffic is ~9 human sessions/day, not ~300

`.okf/workflows/analytics-access.md` (2026-08-13) establishes that **GA4
property `328508492` is 85–90% bot traffic**, and that the correct reading is
GSC clicks plus Bing/DuckDuckGo sessions — about **255 sessions per 28 days**,
against the ~5,000 the raw GA4 number implies. The tell is engagement, not
volume: `google / organic` engages at 11.8% for 34s, while DDG and Bing — too
small to be worth faking — engage at ~67% for 6–7 minutes.

A raw pull for the 56 days to 2026-08-19 reports 16,617 sessions (≈297/day),
of which 11,482 are Direct. Corrected per that concept, the real figure is on
the order of **9–15 human sessions/day site-wide.**

**Any sample-size table built on the raw number is wrong by a factor of ~20.**

### 2. At that volume, no A/B test can reach power

Sample size per arm at α=0.05, power=0.80, n ≈ 16·p(1−p)/δ², against ~12 real
sessions/day:

| Metric | Baseline | Effect | Sessions needed | Days |
|---|---|---|---|---|
| Blog index → post CTR | 30% | +20% rel. | 1,866 | **155** |
| Scroll-to-CTA reach | 25% | +20% rel. | 2,400 | **200** |
| Lead conversion | 1% | +50% rel. | 12,672 | **~3 years** |

Even the cheapest engagement test — high base rate, generous effect size —
takes five months. The rollout has six big changes. **A/B testing is not
available on this site at this traffic, for any metric, at any phase.** That is
an arithmetic fact, not a preference.

### 3. There is still no conversion event — and the signal got worse

The same concept recorded `keyEvents = 0` on 2026-08-13. As of 2026-08-19 the
inventory is:

| Event | 56-day count | Marked key? |
|---|---|---|
| `page_view` | 17,506 | **4,063 marked key** |
| `session_start` | 16,529 | no |
| `user_engagement` | 3,134 | no |
| `scroll` | 420 | no |
| `click` | **9** | no |
| `course_*` (5 events) | 12 | no |

Still no form-submit, no `generate_lead`, no contact event. But `page_view` has
since been marked a **key event**, so GA4 now reports 4,063 "key events" where
it previously reported zero. That is worse than nothing: a non-zero conversion
count that measures nothing will be read by someone as conversions.

### 4. Static hosting forbids server-side splitting

Hugo on GitHub Pages — no server, no edge worker. A split would have to be
client-side, which costs flicker unless applied pre-paint, and carries SEO risk
for anything varying DOM content on a site whose organic search is the
acquisition channel. Moot given constraint 2, but it is the second reason not to
build split infrastructure now.

## Decision

**No A/B tests are run as part of this rollout.** Validation is qualitative and
guardrailed, with an explicit threshold for revisiting.

### Gate A — Qualitative, before shipping (every change)

Runs first, and is the gate that actually catches problems at this scale:

- **Clarity session recordings** on the changed template, n≥20, watched not
  skimmed; plus the rage-click and dead-click reports. Twenty watched sessions
  arrive in days and beat any test this site can power.
- **Prototype review** against the built previews before code is written.
- The repo's existing **visual scroll gate** and both screenshot legs
  (`bin/test` + `bin/dtest`).

### Gate B — Guardrails with declared rollback thresholds (every big change)

Not a measurement of success — a tripwire for damage:

- 28 days before / 28 days after, same weekday alignment.
- **GSC** impressions and average position for the affected URLs, read on the
  `https://jetthoughts.com/` prefix property or with `page notContains elital`
  — never on `sc-domain:`, per the pollution documented in the OKF concept.
  Average position is the live signal; site-wide CTR is not usable here.
- **Bing + DuckDuckGo sessions** as the human-traffic proxy. Google organic
  sessions are excluded on purpose — that number is bots.
- Core Web Vitals.

Thresholds are written into the PR description **before** merge. This is
correlational and every write-up using it says so.

### Gate C — Reversibility instead of proof

Where a change cannot be validated, it must be cheap to undo. Each phase is one
PR with a stated revert path and a coherent state to revert *to*. This is the
substitute for statistical confidence, and it is why ADR-0003 sequences by
blast radius.

### Prerequisite: instrument conversions anyway

A `generate_lead` event on form submit, `page_view` un-marked as a key event,
and CTA clicks tracked with their location. This does **not** enable A/B testing
— nothing does, at this traffic. It is worth doing because:

- it removes a misleading non-zero "key events" number;
- absolute lead counts are readable even when rates are not testable;
- it is the prerequisite for testing later, and the data has to start
  accumulating at some point.

### Revisit threshold

Reopen this ADR when **human** sessions (GSC clicks + Bing/DDG) exceed
**~200/day sustained for a month**. At that volume a blog-index CTR test reaches
power in ~10 days, which is a real gate. Below it, building split
infrastructure is building a machine that cannot produce an answer.

## Consequences

### Positive

- No months spent waiting on tests that cannot finish, and no false confidence
  from an underpowered result read as a win.
- The traffic-reading correction is applied once, in the ADR, instead of being
  rediscovered per analysis.
- The misleading `page_view`-as-key-event is fixed.

### Negative / accepted risk

- **Changes ship without causal evidence.** Accepted explicitly. The design case
  rests on coherence, maintainability and ICP fit (ADR-0003), not on a measured
  lift, and no claim of a measured lift may be made.
- **Gate B cannot separate the change from seasonality or ranking drift.** It is
  a tripwire, not a verdict.
- **Bot traffic could shift** and silently move the guardrail baselines. Re-read
  the engagement-rate tell before trusting any before/after comparison.

### Neutral

- No experimentation platform, no cookie, no split script, no inline pre-paint
  code. Nothing is built for testing until the revisit threshold is met.

## Alternatives considered

**A/B test every big change, as originally requested.** Rejected on the
arithmetic in constraint 2: 155 days for the cheapest viable metric, ~3 years
for lead conversion, against six changes.

**A/B on raw GA4 numbers (~300 sessions/day), which would make an 8-day test
look feasible.** Rejected: that is the bot-inflated figure the OKF concept warns
against. A test powered on bots measures bots.

**Move to Cloudflare/Netlify for edge splitting.** Solves the mechanism, not the
binding constraint. Revisit alongside the traffic threshold, not before.

**Ship on judgement, measure nothing.** Close to what this ADR concludes, but
leaves the conversion-event defect permanently in place and gives no tripwire.

## References

- `.okf/workflows/analytics-access.md` — **read before any GA4 or GSC pull**;
  the bot correction and the `sc-domain:` pollution both live there
- GA4 property `328508492`; GSC `https://jetthoughts.com/` prefix property
- `themes/beaver/layouts/partials/page/analytics.html` — GA4 + Clarity wiring
- `docs/projects/2510-seo-content-strategy/seo-review-2026-08-13.md`
- ADR-0003 — the design system this validates
- `docs/projects/2608-site-design-system/20-29-strategy/20.01-rollout-plan.md`
