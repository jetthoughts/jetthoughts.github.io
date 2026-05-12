---
title: "9.2 · The AI Token Bill Your Agency Forgot"
description: "The pass-through OpenAI, Anthropic, and Cursor costs that creep into month-2 invoices. Predictable per-developer ranges plus 3 SOW clauses to redline now."
date: 2026-11-18
draft: false
author: "JetThoughts Team"
slug: ai-token-bill-dev-shop-pass-through-cost
keywords:
  - ai token bill agency pass through
  - cursor anthropic openai cost developer
  - sow ai cost clause founder
  - ai pass through invoice itemization
  - dev shop ai cost ranges 2026
tags:
  - founders
  - non-technical-founder
  - course-companion
  - ai-era
  - cost-management
categories: ["Founders"]
cover_image: cover.png
metatags:
  image: cover.png
  og_title: "9.2 · The AI Token Bill Your Agency Forgot to Mention"
  og_description: "Pass-through Cursor, Anthropic, and OpenAI costs creep into month-2 invoices. Get predictable per-developer ranges plus 3 SOW clauses to redline now."
cover_image_alt: "JetThoughts course cover showing a stacked AI cost layer cake: Cursor seat, Anthropic API, OpenAI API, totaling per developer per month"
canonical_url: "https://jetthoughts.com/blog/ai-token-bill-dev-shop-pass-through-cost/"
related_posts: false
course_nav: false
---

> **Module 9 · Step 2 of 3** · [Tech for Non-Technical Founders 2026](/blog/tech-for-non-technical-founders-2026/) course.
> Input: a signed agency contract OR a hire who claims "AI-augmented." Output: monthly AI cost predicted within ±20% + 3 contract clauses you add to the next SOW.

> **Supplementary content.** This chapter is relevant after you've shipped (Module 5+) and your product touches AI in production. Bookmark and return when needed.

A founder posted in r/SaaS last month: **"Our dev shop just sent the month-2 invoice. There's a $1,860 line called 'AI Services - passthrough.' We never agreed to this. The contract is for $14K/month flat. What is going on?"** The replies told her what the line was. None of them told her how to predict it for month 3.

That is the gap this post closes. By the end of one coffee you will know the per-developer AI cost ranges that should be in your invoice, the formula that predicts your bill within ±20%, and the 3 clauses you paste into your next SOW so the surprise never happens again.

![Per-developer AI cost stack: Cursor seat $20-60, Anthropic API $30-200, OpenAI API $50-300, with disciplined team total $80-120 and undisciplined $300-500 per dev per month](cost-stack-per-developer.svg)

## Why this hits in month 2-3

Month 1 your invoice arrives clean. The agency is still negotiating, the team is staffing up, and AI usage is light because the developers are reading your codebase, not generating against it. Month 2 production starts. By month 3 the team is shipping daily, and one or two developers fall in love with Claude Code agent loops that run for 40 minutes against a hard ticket. The invoice arrives with a new line: "AI Services," "Tooling pass-through," or "Engineering AI." There is no breakdown. The number is between $800 and $4,000. The agency owner says "yeah we use AI now, it's industry standard." You sign it because the alternative is fighting about it for two weeks while the project stalls.

That conversation is preventable in 20 minutes of contract reading and 10 minutes of math. The next 1,200 words show you how.

## The 2026 cost ranges

Three line items make up almost every dev shop's AI bill in 2026. Memorize the ranges and you can spot a wrong invoice in 30 seconds.

### Per-developer Cursor (or Copilot Enterprise) seat: $20-$60/mo

Cursor Pro is $20/month per seat ([Cursor pricing](https://cursor.com/pricing)). Cursor Business is $40/seat with admin controls and usage analytics. Cursor Ultra is $200/seat for heavy users. GitHub Copilot Enterprise sits at $39/seat ([GitHub Copilot pricing](https://github.com/features/copilot/plans)). Most agencies pick one - Cursor Business is the modal choice in 2026 because it bundles team admin and gives the agency owner a usage dashboard. This line is fixed and predictable. It should never surprise you.

### Per-developer Anthropic API spend: $30-$200/mo

This is where the variance starts. Claude Code (the terminal agent) uses the Anthropic API directly. A disciplined developer running 30-60 short prompts a day on Claude Sonnet 4.5 spends $30-80/month. A developer who fires off 5-minute agent loops on hard tickets - the kind where Claude reads 12 files and writes 400 lines of diff - can hit $150-200/month without trying. Sonnet 4.5 input is **$3 per million tokens**, output is **$15 per million tokens** ([Anthropic API pricing](https://www.anthropic.com/pricing)). One agent loop on a complex ticket can burn 200K-400K tokens in an afternoon.

### Per-developer OpenAI API spend: $50-$300/mo

Less common in 2026 since Claude Code dominates the agent-loop workflow, but teams that run Codex, gpt-4o for image-heavy tasks, or o3 for "deep thinking" tickets still see this. gpt-4o input is **$2.50 per million tokens**, output is **$10 per million** ([OpenAI API pricing](https://openai.com/api/pricing/)). o3 is dramatically more expensive on output tokens. Some agencies route a fraction of work to GPT for variety; others do not touch OpenAI at all. Ask which during the discovery call.

### Total per developer: $80-$500/mo above the hourly rate

The disciplined-team end of the range is **$80-$120/dev/month**: Cursor Business seat ($40), Claude Code with budget alerts ($60-80), no OpenAI. The undisciplined end is **$300-$500/dev/month**: 5 AI tools concurrent, no per-developer budget caps, agent loops left running on lunch break. Most dev shops in 2026 sit at the disciplined end if they are profitable, the undisciplined end if they are still figuring out their AI workflow.

## The math: predict your bill

Take your invoice in three numbers.

**Formula:**

> Monthly AI bill = (number of developers on your project) × (avg per-dev AI cost) × (1 + agency margin %)

**Worked example:** 4 developers, disciplined team avg of $100/dev/month, 0% agency margin (per the SOW clause below), expected monthly AI line: **$400 ± 20% = $320 to $480**. If your month-2 invoice shows $1,800 on a 4-dev team, you have either an undisciplined developer (Devon in the invoice graphic below), an agency hiding 30% margin in the AI line, or both. Either is a conversation worth 15 minutes.

**Same formula, different team:** 2 developers, mid-range avg of $200/dev/month (one of them runs heavy agent loops on hard tickets), expected monthly AI line: **$400 ± 20% = $320 to $480**. Same number, very different reasoning - which is why the per-dev breakdown matters more than the total.

The trade-off you are accepting: ±20% is a wide band. AI usage is genuinely variable - a sprint full of refactoring tickets burns 2-3x more tokens than a sprint full of UI work. The point of the formula is not pinpoint accuracy; it is catching the 200%-over-estimate invoices that show up when nobody is watching.

## The 3 contract clauses to add

Paste these into your next SOW under "Pricing and Pass-Through Costs." If the agency redlines all three, that tells you something. If they accept all three with a shrug, that also tells you something useful.

```mermaid
flowchart TD
    A[Sign SOW with the 3 clauses] --> B[Predict bill: devs x avg x margin]
    B --> C{Month-2 invoice arrives}
    C -->|Within +/-20%| D[Pay it. Mark as baseline]
    C -->|>20% over| E[Itemized breakdown required]
    E --> F{Itemization explains it?}
    F -->|Yes - Devon hit a hard ticket| G[Update budget alert. Continue]
    F -->|No - margin or padding| H[Push back. Cite Clause 1]
    D --> I[Quarterly: review dashboards under Clause 3]
    G --> I
    H --> I
    I --> A
```

### Clause 1 - Pass-through caps

> "AI tooling and API pass-through fees are billable at cost plus 0% margin. Total monthly AI pass-through is capped at $500 per developer per month without prior written approval from Client. Charges above the cap require an itemized written request and Client's signature before invoicing."

What it does: blocks the agency from quietly marking up your AI bill 20-30% (yes, this happens) and gives you a per-dev ceiling that any reasonable team stays under without thinking about it. The "prior written approval" bit forces an email conversation before a $4,200 invoice surprise.

### Clause 2 - Itemization

> "Each monthly invoice itemizes AI tooling pass-through separately by developer and by tool (Cursor seat, Anthropic API, OpenAI API, other). The itemization shows tokens consumed per tool per developer for the period."

What it does: makes the "AI Services - $1,860" line illegal. Instead you get the right-hand invoice in the graphic below. With per-dev itemization, when month-3 spikes, you know whether it is one developer on one hard ticket (workflow conversation) or a margin slipped in (contract conversation).

![Two side-by-side invoices: bad invoice with single AI Services lump line ($2,340 hidden in $59,760 total). Good invoice with per-developer per-tool itemization showing Devon at $1,055 with a $300 budget alert breach.](good-vs-bad-invoice.svg)

### Clause 3 - Visibility

> "Client receives read-only access to the Anthropic Console, OpenAI Platform, and Cursor admin billing dashboards for the project workspace, scoped to project usage. Access provisioned within 5 business days of contract execution."

What it does: collapses the information asymmetry. You see the dashboards the agency sees. When Anthropic rolls out a new model that is 40% cheaper on the same workload, you spot it before the agency does. When usage spikes on a Tuesday, you can see which developer and which day without asking. The agency that refuses this clause is telling you they want the asymmetry.

The trade-off: provisioning read-only project access takes 5-30 minutes per platform. An agency with 12 active clients adds an hour or two of admin per month. That is the cost of trust - cheap.

## What to do tomorrow

Three actions. In order.

- **Open your last 3 invoices and find the AI line.** If there isn't one, ask in writing: "What is your team's average AI tooling spend per developer per month, and where is it billed?" If the answer is "we absorb it" or "it's in the rate," ask for a written breakdown of the rate showing the AI carve-out. The breakdown either exists or the agency is improvising; both answers are useful.
- **Calculate your expected month-3 bill using the formula above.** Write it in a Notion doc with a date. When month 3 arrives, compare. If actual is within ±20% of predicted, the agency is being straight with you. If actual is 50% over, you have a conversation, not an argument, because you have a number to start from.
- **Open your in-flight SOW redline (or your next one) and paste the 3 clauses under "Pricing."** Send the redline back the same day. The agency that returns the SOW with all 3 accepted is telling you they have the workflow already. The agency that accepts 2 of 3 is negotiating in good faith. The agency that strikes all 3 is telling you to walk.

> AI tooling is not magic - it is a metered utility. Every agency in 2026 should be able to tell you per-developer Cursor seat plus Anthropic API plus OpenAI API to two significant figures. The ones that cannot are billing you for their own learning curve.

## Further reading

- [Anthropic API pricing](https://www.anthropic.com/pricing) - the canonical Sonnet, Opus, and Haiku per-million-token rates. Read the input vs output split; it is where most invoice surprises live.
- [OpenAI API pricing](https://openai.com/api/pricing/) - the gpt-4o, o3, and o1 per-token rates. Note the cached input rates if your team uses prompt caching aggressively.
- [Cursor pricing](https://cursor.com/pricing) - Pro, Business, and Ultra tiers. Business is the modal agency choice in 2026.
- [GitHub Copilot pricing](https://github.com/features/copilot/plans) - Individual, Business, Enterprise. The fallback for teams that have not switched to Claude Code.
- The Pragmatic Engineer, [The state of AI coding tools in 2025](https://newsletter.pragmaticengineer.com/p/state-ai-coding-tools-2025) - per-developer spend ranges from a survey of senior engineers, useful for sanity-checking the numbers above.
- Simon Willison, [Pelican on a bicycle benchmarks](https://simonwillison.net/2024/Oct/25/llm-pricing/) - running cost comparison across models with public token-cost ranges.
- Latent Space, [The AI engineer's stack 2026](https://www.latent.space/p/ai-engineer-stack) - which model and tool combinations large engineering orgs settle on, with cost commentary.

Related course posts:
- ["We Use AI": 5 Follow-Up Questions for Your Agency](/blog/agency-ai-five-questions/) - sister chapter; the 5-question script for AI theatre detection includes the cost question this post expands.
- [Reading the SOW Clause by Clause](/blog/hire-track-supplementary-reference/#reading-the-sow) - hire track contract reading guide; pair with the 3 AI clauses above when redlining your next SOW.
- [The Quality Tax for AI MVPs](/blog/quality-tax-ai-mvp-cost/) - the rebuild bill that arrives when AI-generated code meets production load nobody planned for.
- [The Hidden Cost of Poor Vendor Management](/blog/hidden-cost-poor-development-vendor-management-fix/) - the broader pattern: surprise line items follow the contracts you did not read carefully.

---

*Built by [JetThoughts](https://jetthoughts.com) as part of the [Tech for Non-Technical Founders 2026](/blog/tech-for-non-technical-founders-2026/) curriculum.*
