---
title: "SOW Reading Guide: The 8 Clauses Agencies Hope You Skim"
aliases: ["/blog/sow-reading-guide/"]
description: "An annotated sample SOW that catches the 8 clauses agencies hope you skim. Read the night before you sign, alone, with a yellow highlighter."
date: 2026-05-18
draft: false
course_chapter: true
author: "JetThoughts Team"
slug: sow-reading-guide
keywords:
  - sow reading guide founder
  - dev shop contract review
  - milestone acceptance clause
  - code ownership contract clause
  - non technical founder contract
tags:
  - founders
  - non-technical-founder
  - template
  - course-companion
  - hiring
categories: ["Templates"]
canonical_url: "https://jetthoughts.com/course/tech-for-non-technical-founders-2026/sow-reading-guide/"
related_posts: false
---

📋 Template companion to Module 5B of the [From Idea to First Paying Customer course](/course/tech-for-non-technical-founders-2026/). Read the night before you sign. Print, highlighter, 90 minutes alone.

# The SOW Reading Guide

An annotated sample SOW that catches the 8 clauses agencies hope you skim.

By the time you finish your second coffee you will know whether the 47-page Statement of Work in front of you carries 3-5 clauses that will cost you more than the price of the project. You will not have read a line of code or talked to a lawyer. You will have walked one sample SOW clause by clause, marked the flags, and written the questions the agency needs to answer before you sign.

## Why this exists

A SaaS founder we picked up in late Q1 2026 had signed a **47-page SOW** her general counsel cleared the night before. He flagged the liability cap and the IP assignment, fixed both, called it done. She missed the **milestone acceptance clause**: it defined "delivered" as "deployed to staging" rather than "passing the acceptance criteria with production traffic." Three months in, she had paid for **four of five milestones**, every one sitting on a staging URL that 500'd on the second click. By the time she renegotiated, the agency had invoiced **$78K** for milestones nobody could use, and her runway had compressed from twelve months to seven. Most agencies are not malicious about SOW language; they start from a template that survived their last twelve clients, and the template has a few clauses that quietly favor the agency.

## How to use it

Read this **the night before you sign, alone**, with a printed SOW, a yellow highlighter, and 90 minutes blocked. Bring the SOW, your original RFP or feature wishlist, and this guide. Walk every clause against the 8 flags below; when a flag fires, write the question for the agency in the margin. Type all the questions into one email and send it before you sign anything. A working agency answers in writing and signs the redline. If your general counsel cleared the SOW already, run this anyway - generalist attorneys catch the IP and liability paragraphs and skim the operational ones, and the 8 clauses below are where the operational money lives.

> **The 8-clause SOW scoreboard** - use this as a pre-flight checklist; details below:
>
> - [ ] **Clause 1 - Scope:** feature list at concrete shipping level + per-feature day estimate
> - [ ] **Clause 2 - Milestone acceptance:** acceptance criteria in CI + click-through on staging + written sign-off (not "deployed = delivered")
> - [ ] **Clause 3 - Change requests:** capped at 10-20% of SOW, written estimate, 48-hour approval window, no verbal approval
> - [ ] **Clause 4 - IP / code ownership:** transfers per-milestone (not "upon final payment")
> - [ ] **Clause 5 - Third-party dependencies:** every account under your email + card from Day 1, no 15% admin fee
> - [ ] **Clause 6 - Termination triggers:** quality + missed-milestone triggers + termination-for-convenience with handover
> - [ ] **Clause 7 - Post-launch warranty:** anchored to production launch (not "delivery"), ≥60 days, "warranted bug" defined
> - [ ] **Clause 8 - Dispute resolution:** mediation step + neutral venue + prevailing-party fee-shift

## The 8 clauses

### Clause 1 - Scope definition

> **Sample**: "Vendor will deliver the features described in Exhibit A. Detailed scope, including specific tickets, will be defined sprint by sprint with Client's product owner."

**Plain English**: We do not know what we are building. We will figure it out and bill you for it.

**Flag**: "Scope to be defined sprint by sprint", "agile discovery throughout", "exact features dependent on user research." Sounds collaborative; means the SOW is a blank cheque.

**Fix**: Demand a feature list at the level of "a Rails 7 app with a Hotwire frontend, deployed via Kamal to Hetzner, with sign-up, contractor-match, payment, and an admin panel listing the last 100 jobs." Then ask for an estimate per feature in days, not story points. If they cannot estimate the work, they cannot price it. (See [the founder's guide to hiring a dev shop](/blog/founders-guide-hiring-dev-shop/) for what a real scope looks like.)

### Clause 2 - Milestone acceptance

> **Sample**: "A milestone shall be deemed delivered upon Vendor's deployment to the Client-accessible staging environment. Client shall have five (5) business days to raise objections; absent objections, the milestone is accepted and payable."

**Plain English**: We get paid when we push code to a URL nobody uses. If you do not write a structured rejection in five days, the money is ours.

**Flag**: "Delivered" defined as "deployed to staging" or "made available for review." Five-day silent-acceptance windows. No acceptance criteria the milestone has to pass.

**Fix**: "A milestone is delivered when (a) the acceptance criteria in Exhibit B pass in CI (`bundle exec rspec` for Rails, `pytest` for Django, `php artisan test` for Laravel), (b) Client has clicked the feature end-to-end on the staging URL, and (c) Client has signed off in writing." Acceptance criteria belong in the SOW, not in a Slack message. The [Friday demo template](/course/tech-for-non-technical-founders-2026/friday-demo-template/) covers what the click-through looks like.

### Clause 3 - Change-request process

> **Sample**: "Any modification to Scope shall be processed via Change Order, billed at Vendor's standard rate of $185/hour. Vendor shall provide a written estimate prior to execution."

**Plain English**: Anything you ask for after signing costs $185/hour with no ceiling. The estimate can be 4 hours or 400; you have nothing to compare it against.

**Flag**: Hourly-rate change-orders with no cap, no estimate review window, and especially "Vendor may proceed upon Client's verbal approval."

**Fix**: (1) Cap change orders at a percentage of the original SOW (10% standard, 20% generous). (2) Require a written estimate naming the developer, hours, and deliverable, with a 48-hour Founder-approval window. (3) Strike "verbal approval." Founders who skip this end up with the [hidden-cost vendor management problem](/blog/hidden-cost-poor-development-vendor-management-fix/) on their AmEx statement.

### Clause 4 - IP / code ownership

The single highest-stakes clause in the SOW: who owns the code while you're paying for it. The bad version turns any future invoice dispute into a repo hostage situation. The good version transfers ownership invoice by invoice, so a dispute on milestone 4 cannot block milestones 1-3.

|  | Sample language | What it means |
|---|----------------|---------------|
| **Bad** | "Upon Vendor's receipt of **all amounts due** under this Agreement, Vendor hereby assigns to Client all right, title, and interest in and to the Deliverables." | The agency owns the code until you have paid every invoice. If a milestone is disputed, the agency still owns everything. |
| **Good** | "Upon Client's payment of **each milestone invoice**, Vendor irrevocably assigns to Client all right, title, and interest in the corresponding portion of the Deliverables, including all source code committed to the Client-owned GitHub repository as of that milestone's completion date." | Ownership moves milestone by milestone. A dispute on milestone 4 cannot hold milestones 1-3 hostage. |

**Flag**: Ownership transfers only "upon final payment", "upon receipt of all amounts due", or "upon completion of the Project."

**Fix**: Insert the good-version language above. Pair it with the [GitHub / AWS / database ownership checklist](/course/tech-for-non-technical-founders-2026/ownership-checklist/) so the assignment also moves the actual GitHub org owner row - the contract assignment is paper; the GitHub owner row is the actual control.

### Clause 5 - Third-party dependencies

> **Sample**: "Vendor shall manage all third-party services required for the Project, including hosting, third-party APIs, and AI/ML tooling. Costs shall be passed through to Client at cost plus a 15% administrative fee."

**Plain English**: We will rent AWS, Stripe, and the AI tools under our own accounts and bill you whatever they cost, plus 15%. When this engagement ends, the accounts stay with us.

**Flag**: Pass-through costs with no cap, no monthly attribution, and no language about who owns the third-party accounts. Watch AI token costs (Cursor seats, Anthropic API, OpenAI API) - the [5-question AI script](/course/tech-for-non-technical-founders-2026/agency-ai-five-questions/) caught a $4,800 OpenAI line that surprised one founder we worked with.

**Fix**: (1) Every third-party account (AWS, GitHub, Stripe, Anthropic, OpenAI) is created under your company email from Day 1, paid by your company card; the agency gets IAM sub-access. (2) Pass-through costs capped per month with a Founder-approval gate above the ceiling. (3) AI token usage itemized monthly per developer and per project. Strike the 15% admin fee on infrastructure.

### Clause 6 - Termination triggers

> **Sample**: "Either party may terminate for material breach by the other, provided thirty (30) days written notice and an opportunity to cure. Upon termination, Client shall pay Vendor for all work performed through the termination date."

**Plain English**: You cannot walk away because we are slow, sloppy, or shipping bugs. Only paper breach counts, and even then we get 30 days to fix it.

**What to redline** (four numbered insertions):

1. **Quality trigger** - "Client may terminate immediately if Vendor misses the acceptance criteria for two consecutive milestones, or if test coverage on Vendor-written code falls below [agreed floor, e.g. 70%] for 30 consecutive days."
2. **Missed-milestone trigger** - "Client may terminate immediately if any milestone slips more than 21 days past the SOW-stated delivery date without a Client-approved revised plan in writing."
3. **Termination for convenience** - "Client may terminate at any time upon 30 days' written notice and payment of the next milestone fee as an exit fee."
4. **Handover obligation** - "Upon termination for any reason, Vendor shall, within 30 days, deliver: (a) all source code in the Client-owned repository, (b) all credentials and secrets, (c) deployment and operations runbooks, and (d) a 60-minute call with the incoming engineering team."

The [step-by-step exit guide](/blog/fire-dev-shop-guide/) covers what a clean termination looks like in practice once these triggers are in place.

### Clause 7 - Post-launch warranty

> **Sample**: "Vendor warrants that the Deliverables shall conform to the specifications for thirty (30) days following Delivery."

**Plain English**: We will fix bugs free for 30 days after we declare the thing delivered. If "delivered" means "deployed to staging" (see Clause 2), the warranty might run out before users ever touch the feature.

**Flag**: Warranty starts at "Delivery" rather than "Launch to Production Users." Windows under 60 days. No definition of warranted bug versus "new feature request."

**Fix**: Anchor the warranty to **production launch**: "The warranty period begins on the date the Deliverables are first served to live, paying users in production, and runs for 90 days thereafter." Define "warranted bug" plainly: anything that blocks a user from completing a flow listed in Exhibit A. The opening-story founder lost three weeks of warranty coverage because three milestones were "delivered" to staging but never reached production.

### Clause 8 - Dispute resolution

> **Sample**: "Any dispute arising under this Agreement shall be finally resolved by binding arbitration administered by JAMS in [Vendor's home county, Vendor's home state]. Each party shall bear its own costs."

**Plain English**: If we ever fight about money, you fly to our city, hire a local lawyer, and wait six to twelve months for an arbitrator we know to decide.

**Flag**: Binding arbitration in the agency's home state. No mediation step before arbitration. "Each party bears its own costs" favors whichever party has more cash to wait you out.

**Fix**: (1) Add a **mediation step**: "The parties shall attempt in good faith to resolve any dispute through non-binding mediation in [Client's home city] before initiating arbitration." Mediation resolves about 80% of commercial disputes. (2) Set the arbitration venue at a **neutral location** or split it by who initiates the claim. (3) Add a **prevailing-party fee-shift**: the loser pays the winner's reasonable attorney fees.

## What to do before signing

- **Send the agency one email with all your fired-flag questions, in writing.** Numbered list, every question tied to a clause. If they want to discuss it on a call, fine - the answers come back in writing afterwards.

- **Get a one-call review from a contract lawyer who has reviewed at least 3 dev-shop SOWs**, typically $300-$600 for 60 minutes plus a one-page redline. Generalist business attorneys catch the IP and liability paragraphs and miss the operational ones. Ask specifically: "Do clauses 2, 3, 5, 6, and 7 favor the vendor?" The founder in the opening story would have saved $78K for $400.

- **Save the redlined SOW + questions email + answers email together** in one folder, with the date in the filename. If a dispute lands in mediation eighteen months from now, this folder is the entire record.

If the agency walks away from this exercise, the engagement was going to fail anyway. The next reads are the [dev shop red flags checklist](/blog/dev-shop-red-flags-checklist/) and the [5 questions to ask before hiring a dev shop](/blog/hiring-dev-shop-questions/).

---

*Built by [JetThoughts](https://jetthoughts.com) as part of the [From Idea to First Paying Customer](/course/tech-for-non-technical-founders-2026/) curriculum.*
