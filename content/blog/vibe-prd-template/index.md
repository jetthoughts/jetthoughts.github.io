---
title: "Vibe PRD Template - One-Page Product Brief"
description: "One-page Product Brief template. Hand to Lovable, Cursor, or a hired junior. Free."
date: 2026-07-29
draft: false
author: "JetThoughts Team"
slug: vibe-prd-template
keywords:
  - vibe prd template
  - one page product brief template
  - founder product spec template
  - lovable cursor brief template
  - non technical founder prd template
tags:
  - founders
  - non-technical-founder
  - template
  - course-companion
  - product
categories: ["Templates"]
canonical_url: "https://jetthoughts.com/blog/vibe-prd-template/"
related_posts: false
---

📋 Template companion to the [Module 4.1 post](/blog/one-page-product-brief-vibe-prd/). Print after running the synthesis from [Module 3.2](/blog/mom-test-ask-about-past-not-future/#synthesis-write-down-what-you-heard-decide-whats-next). Fill in 45 minutes. Hand to your AI agent or contractor tomorrow.

# Vibe PRD Template - One Page, Five Sections

*The brief that turns a validated problem into something Lovable, Cursor, or a hired junior can ship from on Tuesday morning.*

## Why this exists

A solo founder I spoke with last quarter had a validated problem statement and a Lovable subscription. She typed her problem statement into the Lovable prompt and asked it to "build the simplest version of this." Twelve hours later she had a working web app with a settings page, a billing dashboard, three integrations, and 17 toggles she didn't ask for. She spent the next three weeks deciding which parts to delete. When she opened a second project with a one-page Vibe PRD - the same problem, but now with a no-go list - Lovable shipped the smallest end-to-end thing in 90 minutes. The page she filled in between the two attempts was the difference. The agent fills blanks with reasonable defaults; the brief is your only way to forbid the defaults.

## How to use this

Block 90 minutes on a single morning. Print the template (or copy the markdown block below into a Notion doc). Bring your filled-in [validated problem statement](/blog/validated-problem-statement-template/). Open Lovable, Cursor, or your contractor's kickoff doc in a second tab. You will not type into the second tab yet. The page first.

Section 1 copies directly from your validated problem statement, word for word. Sections 2 through 5 you write from scratch. Hard cap at 45 minutes per section, 90 minutes total. If you spill, the persona is too broad or you are designing too much.

After the page is filled, read it aloud to one peer over a 20-minute call. Ask them: "If you built this in a week using Lovable, what would you build that isn't on my no-go list?" Their first answer is your missing no-go item.

Total time budget: 90 minutes to write, 1 hour to read aloud + revise, 0 minutes to convert for the audience. The same page goes to Lovable, Cursor, or the hired junior. The brief is the brief.

## The template - copy and paste

Use the markdown block below directly in Notion, Lovable's prompt window, or a Word doc. The [SVG of the page](/blog/one-page-product-brief-vibe-prd/) is embedded in the Module 4.1 post for printing.

```
======================= VIBE PRD =======================

Product name (working): _________________________________

Founder: _________________  Date: _______________________

Source: validated problem statement signed ____/____/____
        by ____________________ (advisor 1) and
           ____________________ (advisor 2)

---------------------------------------------------------
1. THE PROBLEM (copy from validated problem statement)
---------------------------------------------------------

Persona + industry + dated 10-call sample:
_________________________________________________________

Quantified cost (time per week + money per month):
_________________________________________________________

Verbatim quote from a strong-signal interview:
"_______________________________________________________"

Why now (trigger / market shift, one sentence):
_________________________________________________________

Inherited from validated problem statement - DO NOT
paraphrase. If you find yourself softening the wording,
stop and reread the original page.

---------------------------------------------------------
2. THE USER AND THEIR CONTEXT
---------------------------------------------------------

Who they are while using your product (job + situation):
_________________________________________________________

The 60 seconds before they reach for your product:
_________________________________________________________

The 60 seconds after they close it:
_________________________________________________________

Device + environment (laptop / phone / desk / commute):
_________________________________________________________

Emotional state at the moment of use:
_________________________________________________________

The agent or junior needs the context, not the TAM.
"Tired, two tabs open, wants to be done" beats
"SMB SaaS company, 11-50 employees, Series A."

---------------------------------------------------------
3. WHAT YOU'RE BUILDING (one paragraph, plain English)
---------------------------------------------------------

The smallest end-to-end thing the user can do:
_________________________________________________________
_________________________________________________________

Inputs the user provides:
_________________________________________________________

Output the user gets back:
_________________________________________________________

Authentication method (magic link / OAuth / none):
_________________________________________________________

What v1 explicitly supports (scope of "done"):
_________________________________________________________

Write this as one paragraph, verb-led. If it reads like
a feature list (Stripe integration + dashboard + settings)
the agent will build a settings page nobody asked for.
Rewrite until it reads like a sentence about what the
user does.

---------------------------------------------------------
4. SUCCESS METRIC (one number)
---------------------------------------------------------

Number + unit + timeframe:
_________________________________________________________

How it's measured (analytics event, not gut feel):
_________________________________________________________

Pass threshold (build is validated above this):
_________________________________________________________

Fail threshold (kill or rewrite below this):
_________________________________________________________

One metric, not three. Three metrics let you cherry-pick.
One metric forces a build/no-build call in 30 days.

---------------------------------------------------------
5. WHAT YOU'RE NOT BUILDING (the no-go list)
---------------------------------------------------------

5 to 8 lines naming what a competent agent or junior
might add unprompted that you explicitly do not want in v1.

[ ] _____________________________________________________
[ ] _____________________________________________________
[ ] _____________________________________________________
[ ] _____________________________________________________
[ ] _____________________________________________________
[ ] _____________________________________________________
[ ] _____________________________________________________
[ ] _____________________________________________________

If this section is shorter than 5 lines, you have not
finished. The agent fills blanks. The longer your list,
the cheaper your build.

---------------------------------------------------------
HAND-OFF
---------------------------------------------------------

Audience for this brief:
 [ ] Lovable / Bolt / v0 (paste as prompt)
 [ ] Cursor / Claude Code (paste as context file)
 [ ] Hired junior contractor (page + 30-min kickoff call)
 [ ] Hired senior engineer  → switch to traditional PRD
 [ ] Product committee      → switch to traditional PRD

Date handed off: ___________________________________
Build start target: ________________________________
Metric check-in: 30 days from build start: __________

========================================================
```

## What good looks like vs what bad looks like

**Section 1 - The problem**

> Bad: *"Founders need a better way to handle their finances."*

> Good: *"Pre-seed B2B SaaS founders running their own Stripe-to-QuickBooks reconciliation lose 6 hours per week and £800 per month in CFO contractor time. 8 of 10 interviewees confirmed (May 2026 sample). Quote: 'Tuesday at 9pm I spent 40 minutes copying Stripe payouts into QuickBooks. I called my CFO. She did it in 90 seconds.' Why now: AI inference cost for the classification step fell to $0.001 per call - the unit economics flip at $9/month per seat."*

The good version is inherited from the validated problem statement. It names the persona by stage, industry, and specific workflow. It puts the cost in time and money. It includes a verbatim quote with a specific moment. It names the why-now with a specific number. A peer can argue with it. The bad version is too broad to argue with, which is why the agent or the junior fills it in for you.

**Section 3 - What you're building**

> Bad: *"A modern reconciliation platform with AI-powered automation, Stripe integration, QuickBooks integration, custom reporting, user roles, and a mobile app."*

> Good: *"A web app where the founder pastes a Stripe payout CSV and the app returns a QuickBooks-compatible journal entry CSV they can import in one click. The first version supports USD only, one Stripe account per user, and no multi-currency. The user authenticates with email plus magic link. We never store the CSV after the conversion completes."*

The good version is one paragraph, verb-led. It names the input (paste CSV), the output (journal entry CSV), the scope of v1 (USD only, one account), the auth choice (magic link), and one storage rule. The bad version is a feature list. Feature lists produce settings pages.

**Section 5 - What you're NOT building**

> Bad: *(blank)*

> Good: *"Not in v1: multi-currency support. Multi-Stripe-account support. Automatic recurring sync. A settings page. A billing dashboard. User roles and permissions. A marketing site beyond the signup page. Mobile responsive design beyond 'works on a 1024px screen.' We will revisit each of these after the Section 4 metric is hit."*

The good no-go list names eight things a competent agent or junior might add. Each is concrete. The bad version is blank, which is how an EdTech founder I spoke with ended up with 17 settings toggles in version one. Twelve had no backend. Two crashed the app. The team had read her brief as a wish list and added everything she didn't forbid.

## What to do after

- **Read the brief aloud to one peer in a 20-minute call.** Ask them: "If you had to build this in a week using Lovable, what would you build that isn't in my no-go list?" Their first answer is your missing no-go item. Add it. The peer is doing the work of an external red-team.
- **Paste the brief into Lovable, Cursor, or your contractor's first kickoff doc - unchanged.** Do not edit it for the audience. The same one page goes to all three. If the agent or the contractor asks a question whose answer is in the brief, your brief failed; rewrite the section that confused them before you take a second pass at the build.
- **Set a 30-day calendar reminder for the Section 4 metric.** The reminder fires whether or not you remember it. On day 30, open your analytics tool and read the conversion-completed count. Above the pass threshold = the brief was right and you build the next layer. Below = the brief was wrong somewhere, and you reread the page before adding anything.

Founders who skip the no-go list ship working demos of products nobody asked for. The same founders, six weeks later, post a [salvage or rebuild question](/blog/salvage-vs-rebuild-decision-tree/) about an MVP they can't extend. The page is cheap. The build round you save by writing it is the expensive thing you avoid.

If you want the doctrine in long form, the [Module 4.1 post](/blog/one-page-product-brief-vibe-prd/) walks through the five sections with the worked example, the decision between Vibe PRD and traditional PRD, and the case for paying $1,000 vs writing the page yourself for free.

---

*Built by [JetThoughts](https://jetthoughts.com) as part of the [Tech for Non-Technical Founders 2026](/blog/tech-for-non-technical-founders-2026/) curriculum.*
