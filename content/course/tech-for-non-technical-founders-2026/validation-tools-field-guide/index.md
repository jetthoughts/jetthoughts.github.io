---
title: "Validation Tools Field Guide"
aliases: ["/blog/validation-tools-field-guide/"]
description: "How to use VenturusAI, DimeADozen, and Preuve AI to stress-test your hypothesis before you book the first interview. Per-tool input prep, report reading guide, common mistakes, and a recommended workflow."
date: 2026-06-05
draft: false
course_chapter: true
author: "JetThoughts Team"
slug: validation-tools-field-guide
keywords:
  - business idea validation tools 2026
  - VenturusAI how to use
  - DimeADozen report guide
  - Preuve AI founder tutorial
  - pre-interview AI validation
tags:
  - founders
  - non-technical-founder
  - validation
  - course-reference
categories: ["Founders"]
cover_image: cover.png
metatags:
  image: cover.png
  og_title: "Validation Tools Field Guide - JetThoughts Course"
  og_description: "How to use VenturusAI, DimeADozen, and Preuve AI to stress-test your hypothesis before you book the first interview."
cover_image_alt: "Validation tools field guide cover showing three AI validation tools"
canonical_url: "https://jetthoughts.com/course/tech-for-non-technical-founders-2026/validation-tools-field-guide/"
related_posts: false
---

> **Course reference** · [From Idea to First Paying Customer](/course/tech-for-non-technical-founders-2026/) course.
> Companion to [Lesson 1.1: Form Your Founding Hypothesis](/course/tech-for-non-technical-founders-2026/form-your-founding-hypothesis-90-minute-sprint/). Read this when you are filling in the five blanks of the Mad Libs sentence and want a structured second opinion before you book the first interview.

You are about to write a one-sentence hypothesis naming your customer, problem, approach, competition, and differentiation - the sentence that anchors every interview, landing-page headline, and build decision for the next three months. Before you commit it to your `Founding Hypothesis` Google Doc, push it through one or two validation tools.

This guide covers three tools - VenturusAI, DimeADozen, and Preuve AI - in enough detail to use each productively in under ten minutes. All three are pre-interview research aids; they do not replace Lesson 2.1's ten Mom Test interviews.

---

## Why use validation tools

Write the Mad Libs sentence in five minutes and you'll fall in love with it. Run it through one validation tool first and you'll find the blank you were vague about before it costs you ten interviews.

```mermaid
%%{init: {'theme':'base', 'themeVariables': {'fontFamily':'Caveat, Patrick Hand, Comic Sans MS, cursive', 'primaryColor':'#fff5f5', 'primaryBorderColor':'#cc342d', 'lineColor':'#333', 'primaryTextColor':'#1a1a1a'}}}%%
flowchart TD
    Draft(["Draft hypothesis<br/>(rough Mad Libs sentence)"])
    Draft --> V["VenturusAI · ~30s<br/>catches weak differentiation<br/>and missed competitors"]
    Draft --> D["DimeADozen · ~2min<br/>catches wrong unit economics<br/>and market too small"]
    Draft --> P["Preuve AI · ~60s<br/>catches customer too broad,<br/>reads market signal"]
    V --> Refine["Rewrite the blanks<br/>the tools flagged"]
    D --> Refine
    P --> Refine
    Refine --> Out(["Sharpened hypothesis<br/>ready for Lesson 2.1 interviews"])

    classDef draft fill:#e8f4f8,stroke:#0277bd,stroke-width:2.5px,color:#1a1a1a
    classDef tool fill:#fff5f5,stroke:#cc342d,stroke-width:2px,color:#1a1a1a
    classDef refine fill:#f0f9f0,stroke:#2e7d32,stroke-width:2.5px,color:#1a1a1a
    classDef out fill:#fffbe6,stroke:#bf8a00,stroke-width:2.5px,color:#1a1a1a

    class Draft draft
    class V,D,P tool
    class Refine refine
    class Out out
```

The tools catch different things:

| Blind spot | Which tool catches it |
|---|---|
| You named a competitor nobody has heard of (or missed the one everyone uses) | VenturusAI (Porter's Five Forces) |
| Your `[CUSTOMER]` blank is "small businesses" - a category, not a person | Preuve AI (niche-segment scan) |
| Your unit economics assume $50/mo pricing when the market pays $15 | DimeADozen (retention-curve section) |
| Your problem is real but the market is too small to support a business | DimeADozen (market-sizing section) |
| Your `[DIFFERENTIATION]` is "easier to use" - the vaguest claim in SaaS | VenturusAI (SWOT strengths section flags it) |

Two are free; none costs more than a month of Perplexity Pro. Run at least one before you fill the five blanks.

---

## Quick comparison

| Tool | What it does | Price | Best for |
|---|---|---|---|
| **VenturusAI** | SWOT, PESTEL, Porter's Five Forces strategic frameworks (~30s) | Free tier (1,000 chars) / Pro from $10/mo | Spotting structural blind spots in your business model |
| **DimeADozen** | 7-section validation brief with kill-risks and market sizing (~2 min) | $9 Starter / $129 Entrepreneur | A brutal second opinion on whether the idea has legs |
| **Preuve AI** | Evidence-based scoring from 50+ live data sources with source links (~60s) | Free scan / $29 Founder Report | Data-backed market signal check (not LLM hallucination) |

---

## VenturusAI

### What it does

VenturusAI runs your business idea through three classic strategic frameworks - SWOT (Strengths, Weaknesses, Opportunities, Threats), PESTEL (Political, Economic, Social, Technological, Environmental, Legal forces), and Porter's Five Forces (Buyer Power, Supplier Power, Threat of Substitution, Competitive Rivalry, Threat of New Entrants). It also produces sections on target audience, marketing strategy, and financial estimates.

Think of it as a free MBA student who reads your one-paragraph description and produces a structured critique in 30 seconds. The frameworks are academic; the output is practical when your input is specific.

### What to prepare before you open it

Write a 2-4 sentence paragraph covering four things before you open the tool:

1. **What you are building** - one sentence, plain English. "A mobile app for solo chiropractors that reduces insurance-claim resubmission time."
2. **Who it is for** - the specific person, not a category. "Solo chiropractors with 1-3 staff who handle their own billing."
3. **The specific problem** - a verb-noun pair. "Resubmitting denied insurance claims takes 14 days and 8% of recovered revenue."
4. **Your business model** - even if rough. "Subscription at $200/mo per clinic."

Example input that produces good results:

> *"I'm building a mobile app for solo chiropractors that reduces insurance-claim resubmission time from 14 days to one click. Subscription model at $200/mo."*

Example input that produces useless results:

> *"An app for small businesses to be more productive."*

Every blank in the Mad Libs sentence is a blank in your VenturusAI input. Specific in = specific out.

### How to read the report

The report has 7-8 sections. You do not need to read all of them. Focus on three:

**Porter's Five Forces - Competitive Rivalry section.** If it names a competitor you had not thought of, add it to the Competition column in the [full hypothesis sprint](/course/tech-for-non-technical-founders-2026/reference/hypothesis-sprint-full/). If it names one you knew about but describes their advantage in a way you had not considered, rewrite your `[DIFFERENTIATION]` blank.

**SWOT - Weaknesses.** The section that hurts. A weakness you already knew about (e.g., "founder has no engineering background") is expected. One you had not considered (e.g., "customer acquisition depends on insurance-industry partnerships that take 6-12 months to close") is a structural blank in your hypothesis - pay attention.

**PESTEL - Legal/Regulatory.** Many founders skip this. If your product touches healthcare, finance, education, or anything involving personal data, read this section carefully. A regulatory blocker you discover now costs zero dollars. One you discover after building costs your runway.

The Marketing Strategy and Financial Estimates sections are AI-generated first drafts - skim for ideas, do not treat the numbers as real.

### Common mistakes

- **Trusting it blindly.** The AI generates insights from general logic, not from your specific market - it cannot access your local competitors or proprietary data.
- **Stopping at one report.** If the first report is too generic, take the most interesting section, expand on it, and re-feed it as new input.

### Pro tips

- Export to Google Docs. Keep the AI-generated framework and update it as you gather real interview data - by Module 2 you will have a side-by-side of what the AI predicted vs. what real humans said.
- Ask explicitly about failure modes - add "What could cause this to fail?" to your input and the Weaknesses and Threats sections sharpen.
- The free tier has a ~1,000 character limit. If your input exceeds it, cut adjectives before you cut specifics. "Very innovative" costs characters and adds zero signal.

---

## DimeADozen

### What it does

DimeADozen produces a multi-section validation report: Executive Summary, Market Sizing, Competitive Landscape, Customer Profiling, Risk Assessment (kill risks), Unit Economics, and Go-To-Market Strategy. The Starter report ($9) is 5-7 pages; the Entrepreneur report ($129) is 40+ pages with sourced data and full metrics. It is built for exactly the person reading this guide: someone who wants a brutal second opinion before committing time and money.

### What to prepare before you open it

Same 2-4 sentence paragraph as VenturusAI, plus 1-2 competitors you are aware of - the tool uses them to calibrate its market-sizing and competitive-landscape sections. Name zero competitors and it assumes the market is empty, which makes the report less useful.

### How to read the report

You only need to read two sections on the first pass:

**Kill Risks.** This is the section that justifies the $9. It flags existential threats: market saturation (too many entrenched players), low barriers to entry (competitors can clone you in a weekend), CAC-to-LTV problems (acquiring a customer costs more than they will ever pay you), and regulatory hurdles. If any kill risk is specific - names a competitor, a regulation, or a cost number - take it seriously. If it is generic ("the market is competitive"), treat it as a yellow flag, not a red one.

**Retention-Curve / Unit Economics.** This section estimates whether the numbers work. If it says your target market is too small at your price point, revisit the `[CUSTOMER]` blank in Lesson 1.1. If it says your CAC is too high relative to LTV, revisit your channel assumption.

Skip the Executive Summary and Go-To-Market sections on first read. They are AI-generated strategy that rarely says anything new; read them after you have real interview data.

### Starter ($9) vs. Entrepreneur ($129)

| | Starter | Entrepreneur |
|---|---|---|
| Length | 5-7 pages | 40+ pages |
| Data sourcing | AI-generated estimates | Sourced data with citations |
| Kill risks | High-level flags | Specific, with competitor names and cost numbers |
| Unit economics | Rough ranges | Detailed modeling |
| When to use | Pre-interview sanity check | Due diligence before committing capital |

At the pre-interview stage, the $9 Starter is enough - you are looking for red flags, not investment-grade due diligence. If it flags a kill risk, decide whether to investigate or pivot; if it comes back clean, proceed to interviews.

### Common mistakes

- **Paying $129 before you know what a $9 report looks like.** Run the Starter first. If it flags something specific that needs deeper investigation, upgrade.
- **Treating it as a go/no-go decision.** The tool validates the *logic* of a business model, not the *demand*. A clean report means the idea is not obviously broken, not that customers will pay - that needs Lesson 1.2-1.4's smoke test and Lesson 2.1's interviews.
- **Ignoring the competitors it names.** The tool often surfaces competitors you did not know existed. Use these as starting points for your own manual research.

### Pro tips

- Run the report, read the kill risks, adjust your hypothesis, and run it again. Two $9 reports on different versions of your hypothesis are cheaper than one week of building the wrong thing.
- If the report flags a competitor you have never heard of, spend 20 minutes on their website - pricing page, testimonials, most recent blog post. A live competitor's marketing teaches more than a generic competitive-landscape summary.

---

## Preuve AI

### What it does

Preuve AI scans 50+ live data sources - Crunchbase, Google Trends, Reddit, G2, Product Hunt, and industry publications - and produces an evidence-based viability score (0-100). Every claim in the report links to its underlying source. Unlike general-purpose LLMs that hallucinate market facts, Preuve shows you where the data came from.

The key product is the **Founder Report** ($29 one-time): a 13-section analysis with competitor mapping, TAM/SAM/SOM estimates, customer personas, and AI Coach pivot suggestions.

### What to prepare before you open it

One sentence, as specific as possible. The narrower the niche, the more relevant the signals Preuve finds.

Bad: "Helping small businesses."

Good: "Accounts-payable teams at 50-200 person companies."

Better: "Solo-practice chiropractors who file their own insurance claims and spend Mondays on resubmissions."

The tool matches your description against live data sources. Broad matches everything and tells you nothing.

### How to read the report

**Start with the Viability Score (0-100).** Above 70 means positive market signals; below 40 means more problems than opportunities; 40-70 means mixed - drill into the sections that pulled the score down.

**Competitor Mapping.** Preuve identifies up to 15 competitors with pricing and "weak spots" - the most actionable part of the report, telling you where existing solutions fall short. If three competitors share the same weak spot, your `[DIFFERENTIATION]` blank should target it.

**Source links.** Every claim links to its source. If a score looks off, drill into the cited source before dismissing it - sometimes the AI misinterprets a data point (e.g., a Reddit post from 2018 gets weighted too heavily). You are the human in the loop.

### The AI Coach

After your first report, the AI Coach suggests pivots based on what the data shows - comparing your idea against competitor weaknesses and demand signals to identify blind spots. Common suggestions:

- Target a micro-niche where existing solutions are too broad
- Change the business model (e.g., B2C → B2B)
- Add a feature that competitors are missing

Treat the pivot suggestions as hypotheses to test in Lesson 2.1 interviews, not as instructions. The AI Coach can tell you what the data suggests; it cannot tell you whether a real customer agrees.

### Pricing

| Tier | Price | What you get |
|---|---|---|
| Free Scan | $0 | High-level viability verdict |
| Founder Report | $29 one-time | Full 13-section analysis with competitor mapping and source links |
| Radar | $9/mo | Ongoing market monitoring |
| Investor-Ready | $499 | Manual review, custom pitch deck, 18-month financial model, 4-page investment memo |

For pre-interview validation, the Free Scan + Founder Report is the sweet spot. Skip Investor-Ready until you have a signed paid pilot and a deck to raise on.

### Common mistakes

- **Treating the viability score as binary.** A 55 does not mean "kill the idea" - it means the data is mixed; investigate the low-scoring sections first.
- **Ignoring the pivot suggestions.** Run the report, read the pivots, adjust your description, and scan again. Watch how the score changes. The delta between scans tells you which blank in your hypothesis is weakest.

### Pro tips

- Run the free scan first. If the score is above 50 and the competitor mapping names companies you recognize, the $29 Founder Report is worth it. If it comes back below 30 with vague competitors, save your $29 and revisit your hypothesis.
- Preuve scans Reddit and niche forums. If real people are discussing your problem, it links to those threads. Read them - verbatim language from real users beats any AI-generated summary.

---

## Recommended workflow

The three tools work best in sequence. Here is the order that produces the most signal for the least time:

![The three validation tools in recommended order: VenturusAI first (free, ~30s) catches missed competitors and weak differentiation, Preuve AI free scan second (free, ~60s) reads market signal and flags a too-broad customer, DimeADozen Starter third (optional, $9, ~2min) catches kill risks and unit economics - none validates the hypothesis, only 10 Mom Test interviews do](tools-in-sequence.svg)

### 1. VenturusAI (first - free)

Run your hypothesis paragraph through VenturusAI and read the Competitive Rivalry and SWOT Weaknesses sections. If it flags a competitor you missed or a structural weakness, fix those blanks before the next tool.

**Time:** 10 minutes (5 to write input, 5 to read key sections).

### 2. Preuve AI free scan (second - free)

Run your refined hypothesis through Preuve's free scan. If the viability score is low, revisit your `[CUSTOMER]` or `[PROBLEM]` blank; if it is solid and the competitor mapping names companies in your space, you have a data-backed signal the market exists.

**Time:** 5 minutes.

### 3. DimeADozen Starter (third - $9, optional)

If VenturusAI and Preuve both gave green or yellow signals, spend $9 on a DimeADozen Starter report and read only the Kill Risks and Retention-Curve sections. Address any specific kill risks before booking interviews; a clean report means three independent tools say your hypothesis is structurally sound.

**Time:** 10 minutes + $9.

### After the tools: Lesson 2.1 interviews

No tool validates your hypothesis - only ten strangers describing the problem in their own words can. The tools tell you the sentence is well-constructed; the interviews tell you it describes something real.

---

## What none of these tools can do

These tools sharpen your hypothesis. They do not validate it. Specifically:

**They cannot prove a real customer will pay.** A clean DimeADozen report and a Preuve score of 80 do not equal a signed Stripe checkout. That signal comes from Lesson 1.2-1.4's smoke-test landing page and Lesson 5.6's Design Partner Agreement with a real deposit.

**They cannot tell you whether the problem is real.** AI tools summarize what people have already said online; they cannot surface a problem nobody has articulated publicly. The Mom Test interviews in Lesson 2.1 surface what specific named humans actually did last Friday.

**They cannot substitute for the Pragmatic-lens gut-check.** VenturusAI can flag that you have no engineering background, but only you know whether you can ship the thing with Lovable on evenings and weekends. The Pragmatic lens in Lesson 1.1 is still yours to score.

Spend three hours across these tools and zero hours on interviews and you have three AI reports and zero validation. The tools sharpen the sentence; the interviews test whether it describes anything real.

---

## Further reading

- [Lesson 1.1: Form Your Founding Hypothesis](/course/tech-for-non-technical-founders-2026/form-your-founding-hypothesis-90-minute-sprint/) - write the Mad Libs sentence these tools stress-test.
- [Lesson 2.1: The Mom Test - Ask About the Past, Not the Future](/course/tech-for-non-technical-founders-2026/mom-test-ask-about-past-not-future/) - validate the sharpened hypothesis with ten real interviews.
- [Lesson 1.4 · Smoke Test: Run It and Read the Signal](/course/tech-for-non-technical-founders-2026/smoke-test-landing-page-7-day-demand-test/) - the next step after these tools confirm your sentence is well-constructed.

---

*Built by [JetThoughts](https://jetthoughts.com) as part of the [From Idea to First Paying Customer](/course/tech-for-non-technical-founders-2026/) curriculum. Tool research: June 2026, based on official websites (venturusai.com, dimeadozen.ai, preuve.ai), user reviews on Product Hunt and Indie Hackers, and hands-on testing with free tiers.*
