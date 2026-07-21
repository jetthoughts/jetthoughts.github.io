# Executive Summary - Vibe Code Rescue (a Shape Up pitch)

**Owner**: Paul Keen | **Written**: 2026-07-21 | **Format**: Basecamp Shape Up pitch (Problem / Appetite / Solution / Rabbit holes / No-gos)
**Full plan**: [`strategy.md`](strategy.md) · **Run it**: [`operation-runbook.md`](operation-runbook.md) (▶ START HERE)

---

## Problem

JetThoughts needs to restart client acquisition, and the 2026 market handed us a specific opening. A wave of funded, non-technical founders paid a dev shop, a freelancer, or an AI tool (Lovable, Cursor, Bolt, Replit) to build their product. The demo looked finished. Then real users arrived and it started breaking - checkout fails, data corrupts, the login is one bad deploy from locking everyone out. Worse, the founder can't tell whether the developers are being straight, and often can't even get access to the code they paid for.

These founders are actively looking for help right now, in public. But every rescue shop entering this space (Modall, HeyDev, AttributeX, and others) leads with the same "free audit" and competes on price. Nobody is selling the thing the burned founder actually wants most: to own and understand their product again.

## Why we believe the demand is real

Four independent signals, not one hopeful reading:

**1. The supply of broken code is exploding and now measured.** Liu et al. 2026 (arXiv:2603.28592) catalogued 484,606 AI-introduced issues across 3,841 repos: 24.2% survive into shipped code, and security issues survive at 41.1%; teams using AI coding tools carry 30-41% more technical debt. Columbia's DAPLab found vibe coding gets a founder roughly 70% of the way to a working app, then breaks as real users arrive. Even Cursor's own CEO warned publicly that these tools build "shaky foundations." The gap between "looks finished" and "survives production" is now documented, not anecdotal.

**2. Founders are asking for help, publicly, at volume.** r/vibecoding grew from ~89K to ~317K members in about a year, with sister communities (r/VibeCodeDevs ~59K, r/cursor, r/nocode) alongside it. The "70% wall" and "why I left Lovable" threads recur weekly. Hacker News carries the exact struggling moment on the record: "Ask HN: Client took over development by vibe coding. What to do?" and "Vibe-coded prototypes: what happens when they go into production?" One rescue shop (HeyDev) reports talking to "over a dozen founders in the last three months"; another (AttributeX) audited 50 vibe-coded apps and found 43 with three or more critical production failures.

**3. A competitor market already formed around this exact offer - the strongest demand proof there is.** When one company runs a "free audit → fixed-price rescue" motion, it might be a guess. When six do - Modall (a named "vibe code cleanup and recovery" service), HeyDev, AttributeX, Autonoma, solo specialists, and Rails shops like JetRockets - founders are paying enough that multiple businesses have organized around serving them. We are not creating a market; we are entering a validated one with a sharper wedge (ownership and trust, not price).

**4. Willingness to pay is proven at our price band.** JetRockets publishes a $100/hr rate and a $25,600 engagement minimum for this work. A Rails-8 fractional CTO rebuilt a YC-backed SaaS's broken Vercel+Firebase MVP in six weeks for a fixed $40K, against a $150K agency quote - our exact lane. The named incidents that make founders reach for their wallet are on the record: Jason Lemkin's live-tweeted Replit database wipe (1,206 records, the agent admitting "I destroyed months of work in seconds"), Moltbook's 1.5M exposed API keys days after an AI-built launch, and a Lovable access-control flaw affecting 18,000+ users across 170 apps.

**What would change our mind**: the demand is for *rescue*, but the buyer might default to re-hiring the original shop or limping along rather than paying a new team. That is a switching-cost question, not a demand question - and it is exactly what the Anxiety and Habit forces in the customer profile, and the first ~10 discovery calls, are built to test.

**Sizing (order of magnitude, full working in [`10-19-research/market-analysis-2026.md`](10-19-research/market-analysis-2026.md))**: the AI-app-builder market is ~$4.7B and 38% CAGR; Lovable alone has 8M+ users, 45.7% of them founders and ~80% non-technical, creating 200K+ projects a day; Apple took 235,800 new app submissions in Q1 2026, up 84% year over year. Two independent estimates put the US ICP-fit rescue pool in the **thousands of prospects a year** (a soft ~$225M/yr serviceable market - treat as scale, not a quotable figure). The point is the ratio: JetThoughts needs **one** client, which is well under 1% of that pool. Market size is not the constraint; sourcing and trust are.

## Appetite

**One client. One window. Now through November 30, 2026.**

This is a fixed-time bet, not an open-ended growth program. We are not building a pipeline machine or ranking in search. We are proving, end to end, that one motion works: a founder in pain finds us, books a free audit, and signs a fixed-price rescue. One signing produces the first case study and the confidence to scale in Q1 2027.

**Circuit breaker**: if two weeks of warm outreach produce zero booked calls, we stop and re-open the ICP bet before spending another hour - the machine is wrong, not under-fed.

## Solution

**The offer.** A free 45-minute Code Audit - one senior engineer reads the founder's actual code and hands back a one-page, plain-English read on what's solid, what to fix, and whether to salvage or rebuild. No contract. If they move forward, a fixed-price Rails rescue ($25-50K, 4-8 weeks, keep 30-50% of the code), agreed up front so the number can't creep.

**The wedge.** Not "we fix broken code" - that lane is crowded. Ours is **ownership and trust**: you own the code and every account at each milestone, and Paul sits on every call as your fractional CTO translating what the developers are doing into decisions you can make. Trust is the product; the rebuild is how we deliver it.

**How we find them.** We listen for the founder's own words of pain (the "Push" - our trigger taxonomy) in the venues where they post it, and lead with their words plus the ownership wedge, never a cold pitch. Warm intros and past-client referrals first (they convert fastest for a burned buyer); agent-sourced cold community threads (IndieHackers, Reddit, HN, X) second; Paul working the high-value manual signals on LinkedIn.

**Who does what.** A white-label partner builds the rescue under the JetThoughts brand, to our quality bar. Agents do all the prep - research, sourcing, drafting, the target list, the openers, the scripts. **Paul is reserved for the calls and the close.** A runbook plus an incremental task backlog holds the state so any session can pick up and execute without losing context.

## Rabbit holes

- **The white-label partner is the single point of failure.** The offer is only sellable if delivery is guaranteed under our brand. Validate with a paid trial rescue and name a fallback partner before selling - do not sell on a handshake.
- **Content is not pipeline.** Blog posts and SEO support conversations; they do not sign clients by November. The human-path steps (warm outreach, the call, the close) are what count. Never ship a content sprint while the outreach is stalled.
- **The assumptions are bets, not facts.** Who the buyer is, which trigger leads, how we find them, how we pre-validate - each is registered with a kill-criteria that fires on the first ~10 calls. We follow the data, not the deck.
- **Cold outreach at volume looks like spam.** Six competitors are already DM-ing distressed founders "free audit." We cap cold volume, lead with the founder's words and the ownership angle, and let warm channels carry the weight.

## No-gos

- **Not a generic dev shop again.** We rescue and hand back control; we do not pitch staff augmentation.
- **Not a price war.** We will not out-cheap the six rescue shops. We win on trust and ownership, or we do not win this buyer.
- **Not a big rebuild of the site or brand.** Reuse the existing rescue landing and consultation funnel; no landing-page overhaul or brand refresh this cycle.
- **Not chasing volume.** One signed client, not twenty leads. Vanity pipeline is a distraction from the single proof we need.
- **Not Paul doing the prep.** Research, sourcing, drafting, and list-building are agent work. If a task lands on Paul's desk that isn't the booking page, the price call, hitting send, or a discovery call, it was mis-scoped.

---

**In one line**: rescue funded founders from broken AI/dev-shop code by handing them back a product they own and understand - one signed client by November 30 to prove the machine, then scale.
