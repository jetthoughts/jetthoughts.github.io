---
title: "Vibe Coding Crisis: Why AI Code Breaks"
description: "45% of AI-generated code has known security vulnerabilities. How to detect vibe-coded apps and what to do about the damage before it spreads."
date: 2026-04-19T08:00:00+02:00
draft: false
author: "JetThoughts Team"
slug: "vibe-coding-crisis-ai-code-debt"
keywords: "vibe coding problems production, ai generated code quality, ai code technical debt 2026"
tags: ["startup", "ai", "code-quality", "founder", "testing"]
categories: ["Engineering"]
cover_image: cover.png
metatags:
  image: cover.png
  og_title: "Vibe Coding Crisis: Why AI Code Breaks in Production"
  og_description: "45% of AI-generated code has known security vulnerabilities. How to detect vibe-coded apps and what to do about the damage."
cover_image_alt: "JetThoughts blog cover for Vibe Coding Crisis with AI code quality stats"
canonical_url: "https://jetthoughts.com/blog/vibe-coding-crisis-ai-code-debt/"
related_posts: false
---

Your dev shop used AI to ship your app in three weeks. Three months later a pen tester found 23 holes nobody had checked.

Last month a founder showed us the app he'd paid $40K to build. The dev shop had used React and Rails and kept the naming conventions clean. The demo looked good enough that his investors didn't blink. Then his first 200 real users hit it, and any logged-in user could access another user's data by changing the ID in the URL. The app had been live for three months like that.

## What "vibe coding" actually means

[Andrej Karpathy coined the term](https://x.com/karpathy/status/1886192184808149383) in February 2025. He described a workflow: type a plain-English request, accept whatever the AI generates if it "vibes." If it looks right and runs without crashing, you ship it.

Karpathy was talking about throwaway scripts and weekend projects. He treated it as a personal experiment for the kind of code that gets tossed on Sunday night.

Then agencies turned it into a business model. By late 2025, shops were advertising "AI-first development," which meant one junior developer watching Claude or Cursor generate thousands of lines per day. Garry Tan reported on YC's spring 2025 demos that an estimated quarter of the W25 batch had submitted codebases more than 95% AI-generated. YC isn't a fringe accelerator.

## The numbers keep getting worse

[Qodo's 2025 State of AI Code Quality report](https://www.qodo.ai/reports/state-of-ai-code-quality/) found AI-generated code produces 1.7x more defects than human-written code. These aren't style nits; they're production bugs.

[Veracode tested over 100 LLMs](https://www.veracode.com/blog/genai-code-security-report/) across four languages and 80 real-world coding tasks. **45% of the generated code contained at least one exploitable security flaw**: SQL injection, broken cryptography, cross-site scripting. The kind of mistake that shows up in your first SOC 2 audit, or in a customer's lawyer's letter.

## Why vibe code fools everyone

Your founder friend who "knows a bit about code" won't catch it. Your investor's technical advisor might not either if they're doing a quick scan.

AI-generated code has clear variable names and reasonably sized functions. Sometimes it even has comments. The AI trained on millions of open-source repositories, so it learned exactly how clean code is supposed to look. It learned what clean code looks like. It didn't learn what clean code does.

What nobody sees in a quick scroll is what's missing. The AI wasn't told to write tests, so it didn't. Every function assumes perfect input - nobody asked what happens when a user enters an emoji in the phone number field, or a `null` where a string should be.

When something fails (and it will), the app crashes. Or worse, it silently corrupts data and keeps running while you have no idea. The AI also doesn't refactor. It generates fresh code for each prompt, which means you end up with **14 slightly different implementations of the same function** scattered across the codebase, each with its own quirks.

## How vibe code kills your app

### Security holes nobody checked

A founder came to us after a penetration tester flagged **23 critical vulnerabilities** in his app, which had been running in production for three months at that point. The team had hashed user passwords, which was good. But nobody had added authentication to the API endpoints. The AI built a login screen and left every other door wide open, so any logged-in user could read or modify another user's account by changing a number in the URL.

### Silent data corruption

A fintech founder couldn't figure out why customers were complaining about wrong transaction amounts. His dev team hadn't noticed because the errors were tiny - fractions of a cent. The AI-generated code stored dollar amounts as floats, which produces **rounding errors on every calculation**, and after four months those fractions added up across thousands of transactions. The founder found out when a user filed a complaint with their bank.

### "Works on my machine" fragility

The app ran fine when one developer tested it on a fast laptop with five seed users. Then 500 real users showed up, and a customer on T-Mobile rural-coverage hit a paginated dashboard that loaded everything in one query. The query that used to return 10 rows started returning 10,000, the database fell over, and the load tests nobody had written would have caught it weeks earlier. The AI wrote exactly what the developer asked for, which turned out to be a demo.

## How to spot vibe code in your codebase

You don't need to read code to catch this. Ask your technical advisor to check these signals, or run the checks yourself.

| Signal | Healthy | Vibe-coded |
|--------|---------|------------|
| Test coverage | 70%+ | 0-5% |
| Commit size | 50-200 lines | 2,000+ lines |
| Error handling | Graceful failures | White screens, crashes |
| Monitoring | Alerts at 3am | "A user emailed us" |
| Code duplication | Reused functions | Same logic in 8 files |

Test coverage is the fastest signal. If yours is in single digits, whoever wrote the code never verified it actually works - here's [how TDD prevents exactly this problem](/blog/why-how-use-tdd-main-tips-testing/).

The commit log tells the same story. A commit called `Add user module` that changed 2,000 lines, followed by `Add payment module` with another 3,000, is AI paste. Developers who [review each other's code on every PR](/blog/ai-powered-code-reviews-transforming-development-workflows/) ship dozens of small commits per week instead. Big dumps mean nobody read the code before it went in.

A quick way to test resilience: have a QA tester break a form in your app, pasting 10,000 characters where a name should go, leaving required fields blank, dropping emoji in a phone-number field. If the app crashes or shows a white screen, the developer only built for the happy path.

One question worth asking your team: "If the app goes down at 3am, how do we find out?" If the answer is "a user emails us," nobody set up monitoring. AI-generated code doesn't add alerting because the developer never prompted it to.

## The practices that prevent this

We've rescued 40+ codebases over the last decade. The shape repeats most of the time: test coverage under 5%, no deployment automation, and a founder who spent $80K-$200K before realizing the code couldn't survive real users. We've also shipped vibe-coded prototypes ourselves; the first time we used Cursor for a client demo, we forgot to flag it as throwaway and the founder kept building on it. That cost us a week of rewrites and a clearer rule: any AI-assisted code that touches paying users gets the test-first treatment from day one. Write the test before the code, then make the test pass; the AI can help write the implementation, but a human writes the test that defines what "working" means. That's [test-driven development](/blog/test-driven-development-tdd-in-ruby-step-by-guide-tutorial-bestpractices/), and it catches code that looks good but doesn't work.

Healthy engineering teams don't ship code without a second person reading it. A reviewer asks "what happens when this input is null?" and "where's the test for this?" Two developers [working together on the same problem](/blog/async-remote-xp-practices/) catch errors the moment they're introduced, not days later when the context is gone.

Your team sends you a [weekly report](/blog/how-know-what-your-team-doing-remote-startup/) that shows what shipped and whether the test coverage number went up or down. Watch the ratio - if features climb while coverage drops, someone is cutting corners.

And you ship small features often, not a 3-week sprint that ends in a big reveal. That big reveal is where vibe-coded apps look impressive, because nobody has tested them with real users yet - and where [technical debt compounds fastest](/blog/fixing-slow-engineering-teams-an-extended/).

## Vibe coding has a place

If you need a clickable demo for an investor meeting next Tuesday, generate the whole thing with Cursor, show it off, and get the check.

AI works for throwaway scripts too - data migrations that run once, one-off reports, internal tools that only three people touch. And it's good for exploration. "What would this feature look like?" An AI can answer that question in **20 minutes instead of 2 days**.

Once real money flows through your product, you need a human reading every PR before merge. AI can draft the code, but a person still owns the decision to ship it.

If you suspect your codebase is vibe-coded, start with the [red flags checklist for dev shops](/blog/dev-shop-red-flags-checklist/) - it gives you the questions to ask your team this week. Or skip the audit-yourself step: we read your codebase and send back a report covering test coverage, security risks, and architecture quality. [Get an honest assessment](https://jetthoughts.com/contact-us/).

## Further reading

- [Andrej Karpathy's original "vibe coding" post](https://x.com/karpathy/status/1886192184808149383) - where the term started
- [Qodo 2025 State of AI Code Quality Report](https://www.qodo.ai/reports/state-of-ai-code-quality/) - AI code produces 1.7x more issues
- [Veracode GenAI Code Security Report](https://www.veracode.com/blog/genai-code-security-report/) - 45% of AI-generated code contains exploitable vulnerabilities
- [GitHub survey: 92% of developers use AI coding tools](https://github.blog/news-insights/research/survey-ai-wave-grows/)
- [OWASP Code Review Guide](https://owasp.org/www-project-code-review-guide/) - what a real security review looks like
