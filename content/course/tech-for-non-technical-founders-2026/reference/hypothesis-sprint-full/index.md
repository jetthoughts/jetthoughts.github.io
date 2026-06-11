---
title: "Full Reference: The 6-Step Founding Hypothesis Sprint"
description: "The complete Click/Jake Knapp Foundation Sprint methodology for writing a falsifiable one-sentence hypothesis. Includes the Mad Libs template, 4-lens scoring deep-dive, AI deep-research prompts, and a worked procurement-tool example."
date: 2026-05-13
draft: true
type: reference
slug: hypothesis-sprint-full
---

> **Reference companion to [Lesson 1.1 · Form Your Founding Hypothesis](/course/tech-for-non-technical-founders-2026/form-your-founding-hypothesis-90-minute-sprint/)** — this page contains the full 6-step sprint, 4-lens scoring deep-dive, AI research prompts, and worked examples. Read the micro-lesson first for the minimum effective path; return here when you want the full methodology.

---

## The Full 6-Step Sprint

Jake Knapp and John Zeratsky published *Click* in April 2025 after twenty years of running design sprints with 300+ startups. The book's central artifact is the Founding Hypothesis: one Mad Libs sentence that names your customer, problem, approach, competition, and differentiation. Their thesis: *"Products click with customers when they make a compelling promise — and that promise must be simple, or customers won't pay attention."*

The version below compresses the original multi-day workshop into a focused session you can run alone with a notebook and a kitchen timer.

### Step 1: The Basics

Open four columns in a notebook: Customer, Problem, Advantages, Competition. Write five entries in each column.

- Five candidate customers (different segments)
- Five candidate problems for the strongest customer (different jobs-to-be-done)
- Five things you bring that a generic Lovable build does not (audience, domain knowledge, a contact, a unique data set)
- Five things the customer does today instead of your product (competition, even when it is "a spreadsheet" or "doing nothing")

Read the column. Circle the one entry you would bet on.

Beside the customer you circled, write three ICP characteristics in plain words: industry vertical (e.g., "solo chiropractic clinics"), company size band (e.g., "1-3 staff"), and the specific moment the pain happens (e.g., "Monday morning insurance-claim resubmission"). These three become inputs for your interviews.

### Step 2: Classic Differentiator

Draw three columns: *fast*, *easy*, *free*. For each, write "more," "less," or "same" against the strongest competition entry from Step 1. Pick the one column you can credibly own.

You cannot own all three. A product that is faster AND easier AND cheaper than the spreadsheet is a product nobody believes exists. Write one sentence: "Our product will be the [faster / easier / cheaper] one."

### Step 3: Generate 3 Candidate Approaches

Write three different one-sentence approaches to solve the circled problem for the circled customer. Three is the right number: two collapse into the safer option, four is procrastination.

### Step 4: Magic Lenses (Full Deep-Dive)

Score each of the three approaches on a 1-5 scale across four lenses:

**Customer lens:** Would the customer pick this on a Friday afternoon between meetings? If the answer is "they would have to be convinced," score 1-2. If "they would notice this in a Reddit thread and bookmark it," score 4-5.

**Pragmatic lens:** Can you ship something usable with what you have today? Drop one point if the approach requires integrating with an API you have never used. Drop another if it requires a license, partnership, or compliance work.

**Growth lens:** How does the customer hear about you, and how many of them are there? An approach that needs a sales call to explain itself is 1-2. An approach that fits in a Reddit headline and converts on a landing page is 4-5.

**Money lens:** Do the unit economics work at the scale you can plausibly reach? A consumer app at $4/mo needing 10,000 users to clear $40K MRR is a different shape than B2B SaaS at $400/mo needing 100. Pre-revenue founders with no built product: leave the Money lens blank and come back after the smoke test gives you real conversion data.

Sum each approach. Pick the highest sum. The lens that scored lowest across the winning approach is your biggest risk — the part of the hypothesis most likely to break.

**The PASS bar:** ≥14/20 across the four lenses with no individual lens below 2. Pre-revenue founders leaving Money blank: the bar drops to ≥11/15 across the other three, same "no lens below 2" rule.

**The routing rule:** The lowest-scoring lens is the part of your hypothesis the next test must attack. Money lowest → smoke test is about price. Customer lowest → interviews are about real pain. Pragmatic lowest → feasibility check first. Growth lowest → ad-test the channel before the build.

### Step 5: Write the Founding Hypothesis

Open the Mad Libs sentence. Fill in the five blanks using the winning approach from Step 4, the customer and problem from Step 1, the competition from Step 2, and the differentiator from Step 2.

Read it aloud three times. Stop when the sentence reads like a thing a friend could repeat back. Type the final sentence into a Google Doc titled `Founding Hypothesis - [date]` and save it to a `Founder OS` folder. You will paste this sentence verbatim into your landing-page headline, interview script, and Stripe price prompt.

### Step 6: Test Design

Open a fresh page. Write one sentence: *The smallest signal that would prove or kill this hypothesis is _____*.

The full test is two parts: (1) a smoke-test landing page for demand signal, and (2) ten Mom Test interviews for problem signal. Write both as your test plan now. Modules 2 and 3 run the tests; this sprint produces the plan they run.

---

## AI Deep-Research Prompts

### For the [customer] and [problem] blanks

Paste into Perplexity Pro ($20/mo), ChatGPT Deep Research (Pro tier), or Gemini Deep Research ($20/mo Advanced tier):

```text
Find the 5 most-named pain points among [YOUR CANDIDATE ICP] in 2024-2026, from Reddit, LinkedIn posts, G2 reviews, and industry podcasts. Cite the exact source for each pain point and quote one verbatim phrase. If you cannot find a real source for any item, respond with "NOT FOUND - [item]" rather than estimating or paraphrasing.
```

**Free-tier fallback:** Paste the same prompt into Claude free (claude.ai) or ChatGPT free (chat.openai.com). The output is less exhaustive (these tools cannot browse the web in real time) but the NOT-FOUND escape valve will tell you which items it could not verify.

### For the 4-lens scoring (optional AI shortcut)

If you don't want to score yourself, paste into Claude or ChatGPT:

```text
Here is my Founding Hypothesis: [SENTENCE]. Score it 1-5 on each of the Customer, Pragmatic, Growth, and Money lenses. For each lens, name the single biggest risk and the one piece of evidence that would change my score. If any lens lacks enough specifics to score honestly, respond with "INSUFFICIENT DETAIL: [lens]" rather than guessing.
```

---

## Worked Example: Procurement-Tool Valuation

A founder building a vendor-management tool for procurement teams scored her approach:

| Lens | Score | Why |
|---|---|---|
| Customer | 4/5 | Procurement teams she'd interviewed wanted the workflow |
| Pragmatic | 4/5 | Could ship on Lovable + Supabase without partnerships or compliance |
| Growth | 4/5 | Procurement people cluster in the same 3 newsletters |
| Money | 1/5 | Buyers expected under $150/mo; unit economics needed $600/mo |

The Money lens scored 1 because procurement teams expected under $150/mo and her unit economics needed $600/mo. She designed her landing-page CTA around the price point — not the feature set — and learned quickly that procurement at that price was a no. She pivoted to a 200-employee-plus mid-market segment where $600/mo was reasonable, re-scored Money to 4, and ran the test again. The pivot happened before she wrote a line of product code.

---

## Two More Worked Examples

**Gmail in 2003:** If we help heavy email users solve finding old messages with full-text search + 1 GB free, they will pick it over Yahoo Mail because Yahoo charges for storage and has no real search.

**B2B SaaS — chiropractic billing:** If we help solo chiropractors solve insurance-claim resubmission with a one-click resubmit, they pick it over billing services that take 14 days and charge 8% of recovered claims.

**B2C — parents of teens with allergies:** If we help parents solve weekend menu safety with a 3-second phone-camera scan, they pick it over reading menus aloud because the teen does not have to feel different.

---

## Case Study: Tomas & Mia

**Tomas** (ReconcileBot, B2B SaaS) filled his hypothesis: "If we help mid-size accounting firm controllers solve manual Stripe-to-QuickBooks reconciliation with an auto-matching engine, they will choose it over exporting to Excel because it cuts 2 hours of Monday work to 90 seconds." He scored 4/5 on customer, 4/5 on pragmatic, 3/5 on growth, 3/5 on money. Weakest blank: money — he doesn't know if firms will pay $200/mo or $2,000/mo. The money test goes into his smoke-test design.

**Mia** (TutorMatch, B2C marketplace) filled hers: "If we help parents of kids 8-14 with dyslexia/ADHD solve finding a vetted specialist tutor with a search-by-specialty marketplace, they will choose it over Googling and calling dead numbers because it matches them in 48 hours with parent reviews." She scored 5/5 on customer, 4/5 on pragmatic, 3/5 on growth, 3/5 on money. Weakest blank: growth — she doesn't know if parents prefer search-by-specialty or search-by-location. Her smoke-test headline will test both.

---

## Further Reading

- Jake Knapp and John Zeratsky, [*Click*](https://www.theclickbook.com/) — the book that introduced the Founding Hypothesis Mad Libs and the Foundation Sprint workshop
- Lenny Rachitsky, [Introducing the Foundation Sprint](https://www.lennysnewsletter.com/p/introducing-the-foundation-sprint) — short writeup of how the format works
- Once you have run the sprint at least once, layered frameworks like Lean Inception, JTBD Canvas, Value Proposition Canvas, and Lean Canvas add useful structure. Skip them on the first pass.

---

*Built by [JetThoughts](https://jetthoughts.com) as a companion reference to the [From Idea to First Paying Customer](/course/tech-for-non-technical-founders-2026/) free curriculum.*
