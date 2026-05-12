---
title: "7.4 · Going Outbound Without a Sales Team"
description: "Once the network is exhausted, customers 11-20 come from filtered cold outbound. The Filter -> Loom -> Calendly -> Stripe pipeline, 4-line scripts."
date: 2026-05-13
draft: false
author: "JetThoughts Team"
slug: outbound-without-sales-team
keywords:
  - cold outbound non technical founder
  - filtered cold email 2026
  - linkedin sales navigator founder
  - apollo io free tier founder
  - first ten customers cold outreach
tags:
  - founders
  - non-technical-founder
  - first-paying-customer
  - sales
categories: ["Founders"]
cover_image: cover.png
metatags:
  image: cover.png
  og_title: "7.4 · Going Outbound Without a Sales Team"
  og_description: "Once the network is exhausted, customers 11-20 come from filtered cold outbound. The Filter -> Loom -> Calendly -> Stripe pipeline, 4-line scripts."
cover_image_alt: "JetThoughts blog cover showing a cold-outbound pipeline funnel from filtered list through Loom and Calendly to a signed Stripe invoice"
canonical_url: "https://jetthoughts.com/blog/outbound-without-sales-team/"
related_posts: false
---

> **Module 7 · Step 4 of 4** · [Tech for Non-Technical Founders 2026](/blog/tech-for-non-technical-founders-2026/) course.
> Input: network exhausted, ~10 customers in from Chapters 7.2 and 7.3. Output: 30 cold messages sent, 3-5 demo calls booked, 1-2 paid pilots cleared in weeks 3-4.

This is sales outbound, not interview recruitment. You are asking for money, not time. The 10 people you interviewed in Module 3 may or may not become customers - outreach to them goes through this chapter's sales sequence, not the Module 3 recruitment script.

Product Hunt converted at 3.1% per launch event across 387 launches OpenHunts studied in 2024. Indie Hackers - posts written as engagement rather than launch announcements - converted at 23.1% per engaged post over the same period. 89% of the Product Hunt founders OpenHunts surveyed said they would not launch on the platform again ([source](https://awesome-directories.com/blog/indie-hackers-launch-strategy-guide-2025/)). The data has been public since the OpenHunts study released in mid-2024, yet every "first 10 customers" article still leads with Product Hunt. The problem is not that Product Hunt is bad. The problem is that it is a one-day event in a job that needs sustained motion.

A B2B SaaS rescue we joined in April 2026 had cleared four paid pilots from the founder's personal network and LinkedIn audience over six weeks. Customer five was where the music stopped - no more warm names. The founder had already booked a launch coach and signed an ad-agency contract. The OpenHunts numbers were the reason she cancelled both. Customer five signed a $4,200 pilot in week 3 from the four-line cold-email sequence below.

![Product Hunt 3.1% vs Indie Hackers 23.1% - per OpenHunts 2024](ph-vs-ih.svg)

This is the closing chapter of Module 7 (First Paying Customer). Once your personal network is exhausted, the next 10 customers come from filtered cold outbound, not from launch events. Figma's first customer 11-20 cohort came from cold DMs to influential designers identified via Twitter data. Retool filtered Crunchbase by funding recency. Your rescue-Rails MVP customer 11-20 cohort will come from LinkedIn Sales Navigator (or Apollo, or both) feeding the four-line script below.

## Why Product Hunt is the wrong lever for an ICP-E product

Product Hunt is a top-of-funnel acquisition channel for a specific kind of product: developer tools, AI productivity, indie SaaS where the buyer reads Product Hunt daily. If your customer is a non-technical buyer at a 50-500 person company in a vertical sector, your customer does not read Product Hunt. The 5,000 upvotes you might get are votes from the wrong people.

The deeper problem is the calendar shape. Product Hunt is one day. Indie Hackers is six months of posts. Filtered cold outbound is a 30-message run every two weeks for a quarter. The shape that converts is the sustained one. Founders who try to shortcut to a one-day event keep being surprised that the leads do not show up the next morning.

For an ICP-E founder coming out of [Chapter 7.3](/blog/paid-pilot-charge-before-ship/), the question is not "which big launch should I do." It is "which 50 named buyers should hear from me first."

## The pipeline: Filter -> Personalize -> Loom -> Calendly -> Stripe

The pipeline is five stages and the tools are off-the-shelf. No engineer required, no $1,200/month sales stack, no Salesforce.

```mermaid
%%{init: {'theme':'base', 'themeVariables': {'fontFamily':'Caveat, Patrick Hand, cursive', 'primaryColor':'#fff5f5', 'primaryBorderColor':'#cc342d', 'lineColor':'#333', 'primaryTextColor':'#1a1a1a'}}}%%
flowchart LR
    A[Filter<br/>LinkedIn Sales Nav<br/>or Apollo.io] --> B[Personalize<br/>60-90s per name<br/>Read profile + last post]
    B --> C[Loom<br/>same product Loom<br/>from Chapter 7.2]
    C --> D[Send<br/>LinkedIn DM<br/>or 4-line email]
    D --> E[Calendly<br/>15-min slot<br/>auto-confirm]
    E --> F[Stripe<br/>DPA + deposit<br/>from Chapter 7.3]
    classDef filter fill:#fff5f5,stroke:#cc342d,stroke-width:2px;
    classDef warm fill:#fbe9ff,stroke:#a855f7,stroke-width:2px;
    classDef close fill:#fff8e0,stroke:#b8860b,stroke-width:2px;
    class A,B filter;
    class C,D,E warm;
    class F close;
```

The five tools and their 2026 pricing:

| Tool | Role | Price |
|---|---|---|
| LinkedIn Sales Navigator | Filter buyers by title, company size, funding signal, role tenure | $99/month single-user (Core tier) |
| Apollo.io (Starter / free tier) | Cheaper alternative to Sales Nav for B2B email + filters | Free tier available; paid Apollo Pro starts ~$49/mo |
| Loom | 90s product walkthrough + you on camera | Free tier: 25 videos |
| Calendly | 15-min demo booking, auto-confirm | Free tier supports one event type |
| Stripe Invoice | Pilot deposit, no monthly fee | 2.9% + 30c per transaction |

You can ship the entire pipeline for under $100/month if you use Apollo's free tier and skip Sales Navigator. The trade-off: Sales Navigator's filters are richer for enterprise buyer profiles (especially for filtering on "joined company in last 90 days" or "recent leadership change"), and Apollo's free tier has limited credits. If your buyer is a 50-200 person company contact in a specific industry, Apollo free tier is enough. If your buyer is a recent VP hire at a 500-2,000 person company, Sales Navigator pays for itself in week 1.

## Volume targets and what to expect

Over a full quarter of cold outbound, 100-200 outreach contacts produces 5-10 paying customers. The funnel at each stage:

| Stage | Target |
|---|---|
| Raw list pulled | 100-200 names per quarter |
| Sent (after filter) | 30 per batch, 3-4 batches per quarter |
| Reply rate | ≥5% (below 5% = stop and diagnose) |
| Demo-to-paid | ≥20% of demos taken |
| Paid pilots landed | 5-10 from 100-200 outreach |

A 10% reply rate on 30 messages is 3 replies. At 20% demo-to-paid, 3 demos lands 0-1 pilots per batch - consistent with the 4-batch-per-quarter model above. The numbers are not impressive individually; they compound over 12 weeks.

## Filter: getting to 30 high-fit names

Apollo or Sales Navigator. Filter on the six dimensions from [Module 7.2](/blog/first-ten-customers-personal-network/) - job title (the buyer or the user, pick one), company size (start one tight band), industry (one vertical first), geography (one timezone for callable demos), technology used (filter for tools your product replaces or integrates with), recent funding or hiring signal (companies with momentum reply faster).

Pull 100-150 raw rows. Strip three categories before sending:

- Anyone whose company size or title is one band off your ICP. The 80% match is not the 100% match.
- Anyone whose LinkedIn shows no posting activity in the last 12 months. They will not see your DM.
- Anyone whose company you have a competing product alignment with (you sell to their competitor). A B2B services rescue we joined in March 2026 lost a great lead this way and had to wait two quarters for the lead's company to pivot before reaching out again.

You should be left with 30-50 clean names. Hold the bottom 20 for week 4 and send the top 30 in week 1.

## Personalize: 60-90 seconds per name, not 10 minutes

The mistake founders make in week 1 is over-personalizing. They spend 20 minutes researching each prospect, paste five quotes into the email, and end with a 400-word manifesto. Response rates fall off a cliff above the four-line threshold.

The right level of personalization is one specific reference per message. Open the prospect's LinkedIn, scan the last three posts and the recent role. Find one specific thing - a recent post they wrote, a comment they left, the company hit a hiring milestone, they joined a year ago and just got promoted. One sentence. Then the same four-line script for everyone.

The 60-90 second rule keeps the volume tractable. 30 prospects × 90 seconds = 45 minutes of personalization per send. A founder can do that in one Monday morning.

## The 4-line cold-email script (3 variants)

### Variant 1: B2B SaaS rescued-Rails context

> Subject: rescued from agency in [month] - your post on [topic]
>
> Hi [first name],
>
> Saw your post on [topic, paraphrased in their words] last [Tuesday]. I just rescued my own Rails MVP from an agency burn and the same issue you flagged was at the top of my list. I built [a tool that does X for Y].
>
> Worth 15 minutes to walk through? Paid design partner spots, [$ deposit] credited toward year one. Calendly: [link]
>
> [Your name]

### Variant 2: B2B services

> Subject: noticed your hiring for [role]
>
> Hi [first name],
>
> Saw [Company] is hiring a [role] - guessing [the problem the role solves] is on your roadmap. I run a [services category] practice and we have helped [a comparable company size] handle [the same problem] in [the same vertical] in the last six months.
>
> Open to a 15-minute walk-through? Paid pilot model, [$ deposit] credited toward year-one engagement. Calendly: [link]
>
> [Your name]

### Variant 3: B2C app

> Subject: re: your [Reddit post / TikTok video] on [topic]
>
> Hi [first name],
>
> Your [Reddit post / TikTok video] on [topic] hit. I built an app that handles [the painful task you described] - the link below is a 90-second Loom showing it work end-to-end on my phone.
>
> Loom: [link]. App: [link]. If it looks useful, I am opening 20 paid beta spots at $9/month for the first month. Reply to claim one.
>
> [Your name]

All three variants follow the same shape: a specific reference earns the open, one sentence on what you built, one specific ask with friction removed (Calendly or Loom + claim link), one currency anchor (deposit, beta price). Total length: 4-6 lines including subject. Anything longer reduces response rate.

## Week-by-week cadence

```mermaid
%%{init: {'theme':'base', 'themeVariables': {'fontFamily':'Caveat, Patrick Hand, cursive', 'primaryColor':'#fff5f5', 'primaryBorderColor':'#cc342d', 'lineColor':'#333', 'primaryTextColor':'#1a1a1a'}}}%%
flowchart TB
    W1[Week 1<br/>Send 30 messages<br/>3-5 replies expected]
    W2[Week 2<br/>Run 3-5 demos<br/>2-3 DPAs sent]
    W3[Week 3<br/>1-2 deposits cleared<br/>Pilot kickoffs scheduled]
    W4[Week 4<br/>Send next 20<br/>Hold for week-5 reply tail]
    W5[Week 5-6<br/>First Friday demos<br/>+ week-3 prospects mature]
    W7[Week 7-8<br/>Year-one conversions<br/>+ next 20 cold names]
    W1 --> W2 --> W3 --> W4 --> W5 --> W7
    classDef coldweek fill:#fff5f5,stroke:#cc342d,stroke-width:2px;
    classDef warmweek fill:#fbe9ff,stroke:#a855f7,stroke-width:2px;
    classDef conv fill:#fff8e0,stroke:#b8860b,stroke-width:2px;
    class W1,W4 coldweek;
    class W2,W5 warmweek;
    class W3,W7 conv;
```

Expect a 10-20% reply rate on a properly filtered, properly personalized 30-message batch. That is 3-6 replies, of which 2-4 will agree to a 15-minute demo. Of the demos, 1-2 will agree to a paid pilot. Of the pilots, the [Chapter 7.3](/blog/paid-pilot-charge-before-ship/) deposit-to-year-one conversion math holds - around 60% of paid pilots convert to year-one customers.

The 30-message batch is not a one-time event. Run a fresh 30-message batch every other Monday until you have 20 customers. The second and third batches will outperform the first by 30-50% because you will have learned which reference patterns earn replies and which do not.

## What "no reply" actually means

A 30-message batch with zero replies is rare and almost always indicates a filter problem, not a script problem. Check three things:

1. **Did the messages deliver?** If you are using cold email (vs LinkedIn DM), check your sending tool's bounce rate. Above 10% bounce means your list is dirty and your domain reputation is suffering. Pause sending for two weeks and re-warm the inbox.

2. **Is the filter right?** Re-read three random LinkedIn profiles from your sent list. If you cannot imagine the person reading the message and finding it relevant, your ICP filter is off. The fix is upstream of the script.

3. **Is the reference real?** Look at the first paragraph of your last 10 sent messages. If the "specific reference" sentence sounds generic ("noticed you work at [Company] in [role]"), it was not specific enough. Real specificity means the prospect can verify the claim - a date, a post title, a name, an event.

10-15% reply rate is the baseline for a well-filtered, well-personalized batch in 2026. Below 5% means stop sending and diagnose.

## Compounding past customer 20

Customers 11-20 come from filtered cold outbound. Customers 21-50 come from referrals out of customers 1-20. If your first 20 customers were chosen carefully (must-have segment from 8.1, personal-network plus filtered outbound from 8.2-8.4), each of them knows two more in the same segment. The motion that gets you to customer 50 is asking your first 20 for one introduction each.

The script for the referral ask is one line at the end of every Friday demo from week 4 onward: *"If this is useful for you, do you know one or two others I should be talking to?"* Half will say yes. Half of those will actually send the intro. That is 5 new warm leads per quarter from a 20-customer base, which is enough to keep cold outbound at 20-30 messages per month rather than 60.

## What to do this week

Monday morning:

1. Set up Apollo free tier or Sales Navigator. Build the filter for your must-have segment.
2. Export 30-50 high-fit names. Drop the bottom 20 into a "week 4" tab in your Sheet.
3. Pick one of the three message variants. Customize the deposit number and the product description.

Tuesday morning:

4. Spend 60-90 minutes personalizing the first 30 messages. One specific reference each.
5. Send via LinkedIn DM or cold email tool (Smartlead, Instantly).

Friday afternoon:

6. Tally the replies. Book demos for week 2.

The full cold-email scripts (3 variants: B2B SaaS rescued-Rails, B2B services, B2C app), the filter checklist, and the Apollo + Sales Navigator setup guide all ship in [the First-Paying-Customer Operating Kit](/blog/first-paying-customer-operating-kit/).

## Advanced (optional sidebar)

Founders who have closed 5-10 paid pilots from cold outbound and want to layer on sales-system rigor can read the [First Round Capital sales scripts collection](https://review.firstround.com/category/sales/), Sahil Bloom's ["The First 10 Customers"](https://www.sahilbloom.com/newsletter/the-first-10-customers) playbook, and the [Y Combinator library on early sales](https://www.ycombinator.com/library/4f-startup-sales-the-fastest-way-to-find-your-first-customers). Once you cross customer 30, the sales playbooks designed for solo founders give way to operator manuals: Mark Roberge's *The Sales Acceleration Formula* for hiring your first AE, Mike Weinberg's *New Sales. Simplified.* for the manager handbook. The main path above gets you from customer 11 to customer 20. The advanced versions matter after that.

> **Module 7 closes here.** → Download the [First-Paying-Customer Operating Kit](/blog/first-paying-customer-operating-kit/) (the full 6-piece template bundle). Now you have a paying pilot, the rest of the course is about keeping the build honest while you ship more: the [oversight rhythm](/blog/engineering-org-chart-non-technical-founder/) sets up the weekly Friday demo + standup + report cadence (Module 6.2), and [Manage AI-Era Risks](/blog/agency-uses-ai-follow-up-questions/) closes the course (Module 8). Or revisit the [course landing page](/blog/tech-for-non-technical-founders-2026/) to pick the next chapter.

## Going further (after your first paying customer)

You've completed the core 6-module course. Continuation chapters apply once you've signed your first paid pilot:

- **Customers leaving in week 2-4?** -> [Churn Triage Before Acquisition](/blog/customers-leaving-churn-triage-not-acquisition/) before you spend on more outbound
- **Key metric flat for 2+ months?** -> [Pivot or Persevere](/blog/pivot-or-persevere-decision-framework/) decision framework
- **Hit the self-serve ceiling?** -> [Hire Track Supplementary Reference](/blog/hire-track-supplementary-reference/) for when to hire and what to look for
- **Product touches AI in production?** -> [Agency AI Questions](/blog/agency-uses-ai-follow-up-questions/), [AI Token Bill](/blog/ai-token-bill-dev-shop-pass-through-cost/), [Slopsquatting](/blog/slopsquatting-ai-supply-chain-attack/) for AI-era hygiene

The course graduates here. Return to the [course landing page](/blog/tech-for-non-technical-founders-2026/) when you're ready to retake it for a new project.

## Further reading

- OpenHunts (via Awesome Directories), [Indie Hackers Launch Strategy Guide 2025](https://awesome-directories.com/blog/indie-hackers-launch-strategy-guide-2025/) - source for the Product Hunt 3.1% vs Indie Hackers 23.1% per-engaged-post conversion data from the 387-launch 2024 study.
- Lenny Rachitsky, [How to win your first 10 B2B customers](https://www.lennysnewsletter.com/p/how-to-win-your-first-10-b2b-customers) - the 7-step playbook from 100+ B2B founders, including the cold-outbound section.
- First Round Capital, [Cold Outreach That Works: A Founder Playbook](https://review.firstround.com/from-1-to-1000-users-tactics-from-airbnb-tinder-etsy-reddit-and-more/) - tactical cold-outreach scripts from Airbnb, Tinder, Etsy, Reddit founder interviews.
- Paul Graham, [Do Things That Don't Scale](http://paulgraham.com/ds.html) - the foundational text on manual customer recruitment, including the Stripe Collison-brothers cold-DM-and-install motion.
- Y Combinator Library, [Startup Sales: The Fastest Way to Find Your First Customers](https://www.ycombinator.com/library/4f-startup-sales-the-fastest-way-to-find-your-first-customers) - YC's collection on founder-led sales including the filter-and-personalize cold-outreach motion.
- Sahil Bloom, [The First 10 Customers](https://www.sahilbloom.com/newsletter/the-first-10-customers) - playbook framing the relationship-to-cold transition that closes the personal-network gap.
