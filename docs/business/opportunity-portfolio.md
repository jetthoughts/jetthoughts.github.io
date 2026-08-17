# JetThoughts - Opportunity Portfolio

**Owner**: Paul Keen (CEO) | **Scope**: company-level | **Updated**: 2026-07-22
> **Owned by the vault** (2026-08-14). JT's bets are Projects under the `opp-jt-service-revenue`
> Opportunity in `~/Documents/pkm`; this table reflects that spine rather than defining a second one. Maintaining
> two portfolios is how the vault's recommended sequence and this repo's dated bet drifted apart.
> Canonical: `jt-business-os`. The state machine below stays here — it is JT's convention, and the repo uses it.

**What this is**: the bets JetThoughts is making to grow, which one is active, and how we decide to validate, kill, or scale each. Every bet becomes a project under [`docs/projects/`](../projects/) and is run by the [operating system](operating-system.md).

---

## How a bet moves through the portfolio

Each opportunity is a **falsifiable hypothesis**, not a plan we commit to. It moves through four states, and it can be killed at any gate on evidence.

| State | Meaning | Exit gate |
|---|---|---|
| **Candidate** | An idea worth a look; not yet resourced. | A one-page thesis + a market signal worth testing. |
| **Validating** | The active bet. We run a real go-to-market and measure. | The pre-validation tests pass (real buyers pay / book), OR a kill-criteria fires. |
| **Scaling** | Validated - now build the repeatable machine. | Predictable pipeline + unit economics that hold. |
| **Killed / Parked** | Evidence said no, or it's on hold. | Documented reason so we don't re-litigate it. |

Discipline: **one bet is Validating at a time.** Spreading the company across several unvalidated bets is how a small firm dies. The assumptions and kill-criteria for the active bet live in that project's assumptions register.

---

## The portfolio

| # | Opportunity | State | Project | Thesis (one line) | Kill-criteria (short) |
|---|---|---|---|---|---|
| 1 | **Vibe Code Rescue** | 🔵 **Validating** | [`2607-vibe-code-rescue`](../projects/2607-vibe-code-rescue/) | Funded non-technical founders will pay a fixed price to rescue a broken AI/dev-shop MVP and get ownership back. | If 2 weeks of **active outreach across live lanes** (LinkedIn posts and/or verified sends) yields 0 booked calls → **pause and re-open A + C** (ICP *and* channel), per the [assumptions register](../projects/2607-vibe-code-rescue/rescue-sprint/assumptions-register.md) C1 addendum (2026-08-08 — re-based after the warm lane was demoted). **Status: untestable — the clock starts at the first post or first send**, neither of which has happened (see [OS §1](operating-system.md)). |

**Parking lot (candidates, not resourced)**: none yet. Add a row here when a new wedge earns a one-page thesis; do NOT start validating it while bet #1 is still open.

---

## Why Vibe Code Rescue is the active bet

- **Timing**: the AI-app-builder wave (Lovable, Cursor, Bolt, Replit) manufactured a large, founder-heavy pool of broken, funded MVPs - measured, not guessed ([market analysis](../projects/2607-vibe-code-rescue/10-19-research/market-analysis-2026.md)). *Counter-evidence (2026-08-07, held honestly)*: the category is no longer early - page 1 for "vibe code rescue" is fully occupied and a competitor uses the exact name; and our $2.5-10K pricing deliberately undercuts the $25-50K market band, in tension with our own "cheap is expensive" thesis. Both are open decisions on Paul's desk (OS §5).
- **Fit**: Rails rebuild is JT's home turf; the ownership/trust wedge is JT's durable positioning made concrete.
- **Provability**: a single signed client proves the whole motion (demand → call → audit → signing) and produces the first case study - a clean validation gate.
- **Reversibility**: delivered by JT's own senior Rails engineers and a white-label partner (both routes, CEO 2026-08-09), so the bet is testable without over-committing the firm or depending on a single delivery channel.

Full plan: [executive summary](../projects/2607-vibe-code-rescue/executive-summary.md) · [strategy](../projects/2607-vibe-code-rescue/strategy.md) · run it via the [operating system](operating-system.md).
