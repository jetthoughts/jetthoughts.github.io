> DRAFT - T1 output (Incremental agent backlog). LIGHT cold-eyes applied. Feeds T2 sourcing-pipeline.

# ICP Buying-Trigger Taxonomy - Vibe Code Rescue

**Task**: T1 (runbook Incremental agent backlog) | **Created**: 2026-07-21 | **Owner**: agent-built, no Paul needed
**Purpose**: a ranked list of *detectable* moments when an ICP-E founder is ready to pay to rescue a broken build, with the observable signal and where it shows up. Feeds T2 (sourcing-pipeline) and T7 (openers).
**ICP**: non-technical founder, pre-seed to Series A, whose MVP was built by a dev shop, a freelancer, or an AI tool and is now failing on real users. See `90.10`.

---

## How to read this

Each trigger has four fields:
- **Signal** - the observable thing the founder says or does that we can actually see.
- **Where** - the venue an agent can watch for it (feeds T2/T4/T5).
- **Strength** - how close to a buying moment (High = already looking to pay someone; Med = pain named, not yet shopping; Low = venting, not ready).
- **Opener** - which C0 template fits (thread-reply, warm-intro, referral, forwardable).

Warm signals (someone Paul already knows shows one of these) always outrank cold ones - route those to T3.

---

## Ranked triggers

### 1. "The app broke after launch / at scale" (High)
- **Signal**: founder posts that the product worked in the demo and started failing once real users arrived - checkout fails for some users, pages time out, sessions get wiped, data corrupts under concurrent use.
- **Where**: r/startups, r/SaaS, r/webdev, r/developersPak, Indie Hackers, X/Twitter build-in-public threads; also the comment sections and "get a free audit" forms of competitor blogs (HeyDev, Modall, AttributeX) where these founders self-select.
- **Strength**: High - this is the exact pain our free Code Audit answers. Confirmed live: multiple 2026 posts and a dozen-plus founder accounts documented across the competitor set.
- **Opener**: thread-reply (offer the audit as help, no pitch) or forwardable.

### 2. "About to sign a dev contract over $25K and can't evaluate it" (High)
- **Signal**: founder asks whether a quote/SOW is fair, whether a shop is overselling, or how to vet a proposal before signing.
- **Where**: r/startups, r/Entrepreneur, founder Slack/Discord communities, LinkedIn posts asking for a "second opinion on a dev quote."
- **Strength**: High - they are actively deciding to spend money on code and want a trusted read first. The audit IS that read.
- **Opener**: warm-intro or thread-reply.
- **Source note**: this trigger is lifted directly from Eight Bit Studios' fractional-CTO "when you need it" checklist - a competitor validated it as a real buying moment.

### 3. "The dev shop holds my code / I can't get access" (High, and it is our sharpest pain)
- **Signal**: founder says the repo is under the shop's GitHub, the server sits on the shop's account, they can't get a clean handoff, or the shop went quiet.
- **Where**: r/startups, r/smallbusiness, r/Entrepreneur, legal/founder subreddits, LinkedIn.
- **Strength**: High - maps to ICP pain #13 (ownership hostage). The S0 intake question 5 (repo access) pre-qualifies these on the call.
- **Opener**: thread-reply or warm-intro. Handle with care - they are burned and wary of another agency.

### 4. "Hiring the first engineer / fractional CTO after an outsourced build" (Med-High)
- **Signal**: founder is interviewing engineers or a fractional CTO and admits they can't gauge skill, or wants someone senior in the interview loop to inherit an agency-built codebase.
- **Where**: LinkedIn hiring posts, r/cto, r/startups, Wellfound/AngelList job posts from non-technical solo founders, fractional-CTO directories.
- **Strength**: Med-High - a buying moment for senior judgment; the audit is the low-commitment first step before a bigger engagement.
- **Opener**: warm-intro or LinkedIn direct.

### 5. "Technical co-founder / lead dev just left" (Med-High)
- **Signal**: founder says their CTO or lead developer left and nobody understands the codebase.
- **Where**: r/startups, Indie Hackers, LinkedIn.
- **Strength**: Med-High - urgent, but they may first look for a replacement hire rather than a rescue. Audit reframes "who understands this" before they over-hire.
- **Opener**: warm-intro.

### 6. "Investors / diligence asking technical questions I can't answer" (Med)
- **Signal**: founder preparing to raise, worried a technical diligence call will expose the build.
- **Where**: LinkedIn, founder communities, accelerator cohorts.
- **Strength**: Med - real but deadline-driven and sensitive; better via warm intro than cold.
- **Opener**: warm-intro or referral (an angel/accelerator contact forwarding).

### 7. "We keep hearing 'we need to refactor' and don't know what it means" (Med)
- **Signal**: founder confused by developers saying they're "refactoring" or "working on the architecture" while no working product ships.
- **Where**: r/startups, r/Entrepreneur, founder Slack.
- **Strength**: Med - pain named, not yet shopping; educational content converts these better than a direct ask.
- **Opener**: thread-reply pointing at a helpful post, then the audit.

### 8. "Just venting about vibe-coding breaking" (Low)
- **Signal**: developer or founder venting about AI-generated code breaking, no buying intent yet.
- **Where**: r/developersPak, r/ExperiencedDevs, X.
- **Strength**: Low - engage only to learn phrasing; do not pitch. Useful for T1/T2 language, not for the target list.

---

## Where ICP founders post (venue map for T2/T4/T5)

| Venue | What to watch for | Access |
|---|---|---|
| r/startups, r/SaaS, r/Entrepreneur, r/smallbusiness | triggers 1-7; highest volume | web search + read (no login) |
| r/webdev, r/cto, r/ExperiencedDevs, r/developersPak | triggers 1, 4, 8; more technical framing | web search + read |
| Indie Hackers | triggers 1, 5, 7; build-in-public | web (public) |
| LinkedIn | triggers 2, 4, 5, 6; best for warm + hiring signals | manual (Paul's account, per Step 3 plan) |
| X/Twitter build-in-public | trigger 1; fast but noisy | web search |
| Competitor "free audit" blog comment threads (HeyDev, Modall, AttributeX, Autonoma) | self-selected trigger-1 founders | web (public) |
| Wellfound/AngelList job posts | trigger 4 (non-technical founder hiring first eng) | web (public) |

---

## Competitor note (so C0 openers don't sound like the other six rescue shops)

The "broken vibe-coded MVP -> free audit -> fixed-price rescue" offer is already crowded: Modall (vibe code cleanup & recovery), HeyDev, AttributeX ("Get a Free Audit"), Autonoma, plus solo devs (Anton de Villiers) and Rails shops (JetRockets, public $100/hr and $25,600 minimum - confirms our $25K band). Our wedge is **Paul as the named fractional-CTO trust layer on every call** and **founder ownership handed back at each milestone** - not "we audit code." Openers must lead with the trust/ownership angle, not the audit mechanic every competitor already offers.

---

## LIGHT cold-eyes gate (self-refute, per runbook rule 4)

**Refute prompt**: "Is each trigger actually observable by us, or a guess?"
- Triggers 1-8 each name a concrete signal a founder types in public - not an inferred internal state. PASS.
- **Objection that holds**: triggers 2, 4, 5, 6 are strongest on LinkedIn, which we can only work manually through Paul's account (no API/MCP). So the *cold-sourceable* set an agent can build unattended is mainly triggers 1, 3, 7, 8 (Reddit/IH/web) plus trigger-1 self-selectors in competitor comment threads. T2 must split "agent can source unattended" (Reddit/web) from "needs Paul's LinkedIn session." Noted for T2.
- **Objection that holds**: competitor saturation is real; a generic "free audit" opener will be ignored. T7 openers must carry the trust/ownership wedge. Noted above.

**Verdict**: PASS with two carried constraints (LinkedIn triggers are manual-only; openers must differentiate on trust/ownership). Both handed to T2/T7.

---

## Sources
- heydev.us/blog/vibe-coded-mvp-scaling-fix; modall.ca/blog/vibe-coded-app-breaks-production; attributex.ai/problems/why-vibe-coded-apps-crash-in-production; getautonoma.com/blog/vibe-coding-failures
- eightbitstudios.com/services/fractional-cto ("when you need a fractional CTO" trigger checklist)
- jetrockets.com/blog/fractional-cto-and-ai-agents (public pricing + common-trigger FAQ)
- reddit.com/r/developersPak/comments/1sdzina (live founder venting thread)
