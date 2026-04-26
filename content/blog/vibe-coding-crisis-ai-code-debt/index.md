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
---

Your dev shop used AI to ship your app in three weeks, and the code looked clean enough that nobody worried. Then 200 real users showed up and broke everything.

Last month a founder showed us the app he'd paid $40K to build. His dev shop had used React and Rails, kept the naming conventions clean, and the demo looked good enough that his investors didn't blink. He called us because the first 200 real users broke it. We opened the codebase and there were no tests at all. Anyone could access another user's data just by changing the ID in the URL. The app had been live for three months like that.

## What "vibe coding" actually means

[Andrej Karpathy coined the term](https://x.com/karpathy/status/1886192184808149383) in February 2025. He described a way of writing software where you tell an AI what you want in plain English, it writes the code, and you accept it if it "vibes." If it looks right and runs without crashing, you ship it.

Karpathy was talking about throwaway scripts and weekend projects - a personal experiment, not a production strategy.

Then agencies turned it into a business model. By late 2025, shops were advertising "AI-first development," which meant one junior developer watching Claude or Cursor generate thousands of lines per day. [A quarter of Y Combinator's W25 batch](https://techcrunch.com/2025/02/05/y-combinator-startups-are-applying-with-codebases-almost-entirely-generated-by-ai/) submitted codebases that were 95%+ AI-generated. That's not a handful of experimenters. That's the most selective startup accelerator on earth.

## The numbers keep getting worse

[Qodo's 2025 State of AI Code Quality report](https://www.qodo.ai/reports/state-of-ai-code-quality/) found that AI-generated code produces 1.7x more issues than code humans wrote. Not style nits. Actual defects that break things in production.

[Veracode tested over 100 LLMs](https://www.veracode.com/blog/genai-code-security-report/) across four languages and 80 real-world coding tasks. 45% of the generated code contained at least one exploitable security flaw - SQL injection and cryptographic failures, plus cross-site scripting. Attackers exploit these holes to steal user data, hijack accounts, or access databases through mistakes the AI left behind. The kind of mistakes that put your company on Hacker News.

[GitHub surveyed developers](https://github.blog/news-insights/research/survey-ai-wave-grows/) and found 92% of them now use AI coding tools. That number alone isn't the problem. The problem is that many of those developers ship code nobody on their team tested or reviewed before users touched it.

## Why vibe code fools everyone

Your founder friend who "knows a bit about code" won't catch it. Your investor's technical advisor might not either if they're doing a quick scan.

AI-generated code has clear variable names and reasonably sized functions. Sometimes it even has comments. The AI trained on millions of open-source repositories, so it learned exactly how clean code is supposed to look. It writes code the way a student writes an essay with a thesaurus. Every word sounds right, but the argument has no spine.

What nobody sees in a quick scroll is what's missing. The AI wasn't told to write tests, so it didn't. Every function assumes perfect input - nobody asked what happens when a user enters an emoji in the phone number field, or a null where a string should be.

When something fails (and it will), the app crashes. Or worse, it silently corrupts data and keeps running while you have no idea. The AI also doesn't refactor. It generates fresh code for each prompt, which means you end up with 14 slightly different implementations of the same function scattered across the codebase, each with its own quirks.

## How vibe code kills your app

### Security holes nobody checked

A founder came to us after a penetration tester flagged 23 critical vulnerabilities in his app - an app that had been running in production for four months. The team had hashed user passwords, which was good. But nobody had added authentication to the API endpoints. The AI built a login screen and left every other door wide open, so any logged-in user could read, edit, or delete another user's account by changing a number in the URL.

### Silent data corruption

A fintech founder couldn't figure out why customers were complaining about wrong transaction amounts. His dev team hadn't noticed because the errors were tiny - fractions of a cent. The AI-generated code stored dollar amounts in a format that introduces rounding errors on every calculation, and after four months those fractions added up across thousands of transactions. The founder found out when a user filed a complaint with their bank.

### "Works on my machine" fragility

The app ran fine when one developer tested it on one browser with a small dataset. Then 500 real users showed up, and someone connected from a slow 3G network in rural Texas. A database query that used to return 10 rows started returning 10,000 - and everything fell apart. Nobody had run a load test. Nobody had set up monitoring. The AI wrote exactly what the developer asked it to write, which was a demo.

## How to spot vibe code in your codebase

You don't need to read code to catch this. Ask your technical advisor to check these signals, or run the checks yourself.

| Signal | Healthy | Vibe-coded |
|--------|---------|------------|
| Test coverage | 70%+ | 0-5% |
| Commit size | 50-200 lines | 2,000+ lines |
| Error handling | Graceful failures | White screens, crashes |
| Monitoring | Alerts at 3am | "A user emailed us" |
| Code duplication | Reused functions | Same logic in 8 files |

The test coverage number is the fastest signal. A healthy production app sits at 70% or above. If yours is in single digits, whoever wrote the code never verified it actually works. We put together a full guide on [how TDD prevents exactly this problem](/blog/why-how-use-tdd-main-tips-testing/).

The commit log tells a similar story. If you see a commit called "Add user module" that changed 2,000 lines, followed by "Add payment module" with another 3,000, that's AI paste. Developers who [review each other's code on every PR](/blog/ai-powered-code-reviews-transforming-development-workflows/) make small commits, 50 to 200 lines, dozens per week. Big dumps mean nobody reviewed the code before it went in.

A quick way to test resilience: break a form in your app. Enter garbage into fields. Leave required inputs blank. Paste 10,000 characters into a text box. If the app crashes or shows a white screen, the developer only built for the happy path.

One question worth asking your team: "If the app goes down at 3am, how do we find out?" If the answer is "a user emails us," nobody set up monitoring. AI-generated code doesn't add alerting because the developer never prompted it to.

## The practices that prevent this

The practices that prevent vibe coding disasters have been around for twenty years. They're just unfashionable when everyone wants to ship in a weekend - which is exactly why the shops that follow them stand out.

You write the test before the code, then you make the test pass. That's [test-driven development](/blog/test-driven-development-tdd-in-ruby-step-by-guide-tutorial-bestpractices/), and it catches code that looks good but doesn't work. The AI can help write the implementation, but a human writes the test that defines what "working" means.

Nobody ships code without a second person reading it. A reviewer asks "what happens when this input is null?" and "where's the test for this?" Two developers [working together on the same problem](/blog/async-remote-xp-practices/) catch errors the moment they're introduced, not days later when the context is gone.

Your team sends you a [weekly report](/blog/how-know-what-your-team-doing-remote-startup/) that shows what shipped and whether the test coverage number went up or down. Watch the ratio - if features climb while coverage drops, someone is cutting corners.

And you ship small features often, not a 3-week sprint that ends in a big reveal. That big reveal is where vibe-coded apps look impressive, because nobody has tested them with real users yet. [Technical debt compounds fast](/blog/fixing-slow-engineering-teams-an-extended/) when teams ship large batches without getting feedback.

## Vibe coding has a place

If you need a clickable demo for an investor meeting next Tuesday, generate the whole thing with Cursor, show it off, and get the check.

AI works for throwaway scripts too - data migrations that run once, one-off reports, internal tools that only three people touch. And it's good for exploration. "What would this feature look like?" An AI can answer that question in 20 minutes instead of 2 days.

But once real users touch your product and real money flows through it, you need someone writing tests and someone reviewing the code. You need a human who takes responsibility for what ships.

If you're evaluating your current dev team, start with our [red flags checklist for dev shops](/blog/dev-shop-red-flags-checklist/) or the guide on [code quality signals non-technical founders can actually check](/blog/code-quality-evaluation-non-technical-founders/). If you've already decided to make a change, here's [how to fire your dev shop safely](/blog/fire-dev-shop-guide/).

If you suspect your codebase is vibe-coded, we do a free code audit. One senior developer looks at your codebase and writes you a report covering test coverage, security risks, and architecture quality. [Get an honest assessment](https://jetthoughts.com/contact-us/).

## Further reading

- [Andrej Karpathy's original "vibe coding" post](https://x.com/karpathy/status/1886192184808149383) - where the term started
- [Qodo 2025 State of AI Code Quality Report](https://www.qodo.ai/reports/state-of-ai-code-quality/) - AI code produces 1.7x more issues
- [Veracode GenAI Code Security Report](https://www.veracode.com/blog/genai-code-security-report/) - 45% of AI-generated code contains exploitable vulnerabilities
- [TechCrunch: YC startups applying with AI-generated codebases](https://techcrunch.com/2025/02/05/y-combinator-startups-are-applying-with-codebases-almost-entirely-generated-by-ai/)
- [GitHub survey: 92% of developers use AI coding tools](https://github.blog/news-insights/research/survey-ai-wave-grows/)
- [OWASP Code Review Guide](https://owasp.org/www-project-code-review-guide/) - what a real security review looks like
