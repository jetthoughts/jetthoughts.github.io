---
title: "Vibe Coding Is Disposable. Stop Shipping It."
description: "Vibe-coded code is unmaintainable by design - patches don't stick, bugs return, the rebuild verdict lands. The generate-validate-kill workflow that prevents it."
date: 2026-05-09T08:00:00+00:00
edited: 2026-05-09T08:00:00+00:00
draft: false
author: "JetThoughts Team"
slug: "vibe-coding-disposable-by-design"
keywords: "vibe coding production risks, validation prototype vs production, ai code rebuild cost"
tags: ["startup", "ai", "code-quality", "founder", "vibe-coding"]
categories: ["Engineering"]
cover_image: cover.png
metatags:
  image: cover.png
  og_title: "Vibe Coding Is Disposable. Stop Shipping It."
  og_description: "Vibe-coded code is unmaintainable by design - patches don't stick, bugs return, the rebuild verdict lands. The generate-validate-kill workflow that prevents it."
cover_image_alt: "Two-stage model diagram: vibe-coded prototype validating a hypothesis, then production rebuild on a real stack"
canonical_url: "https://jetthoughts.com/blog/vibe-coding-disposable-by-design/"
---

You're looking at the same support ticket for the third time this month. The duplicate-charge bug your team fixed two Mondays ago, then again last Thursday, just got reported again - by the same customer who reported it the first two times. When you forward the ticket to your engineer, the reply comes back: "I thought we fixed that."

The fix didn't stick because the AI doesn't refactor your codebase. It writes a fresh patch in one place and leaves five other copies of the same broken logic untouched. You watch the bug come back. Your team can't tell you why.

Andrej Karpathy invented vibe coding for weekend prototypes - the kind you build on a Sunday afternoon and never look at again. Founders started shipping the same approach to customers who pay them, and the rebuild bills are showing up now.

## TL;DR

- Vibe-coded code is unmaintainable by design: AI regenerates code on each prompt instead of refactoring, scattering many versions of the same logic across the codebase.
- Bug fixes don't stick because patches only land in one duplicate; the others keep producing the same bug. The founder sees "we fixed it" turn into "wait, it's back" three days later.
- Security failures (Lovable, Replit, Moltbook) are the loud symptom of the same problem - what surfaces when nobody on the team can read the codebase anymore.
- The right approach: vibe-code to validate the hypothesis, then throw the implementation away and rebuild fresh in a stack a human can read.
- Cheating the rebuild costs more than building it properly the first time.

## What Karpathy actually built vibe coding for

Andrej Karpathy [posted on X in February 2025](https://x.com/karpathy/status/1886192184808149383) describing a personal workflow: type a plain-English request, accept whatever the AI generated if it ran, let yourself forget the code exists. He was talking about throwaway scripts and weekend hobby projects.

By late 2025, agencies were marketing "AI-first development" as a pricing tier and shipping the same approach at production apps. The term escaped the personal-experiment category, but the technology didn't make the jump with it. An approach built around "forget the code exists" is one that won't survive code somebody has to maintain.

## Why vibe-coded code can't be maintained

The surprise for non-technical founders is that vibe-coded code looks fine. Variable names are sensible. Function lengths are reasonable. Sometimes there are even comments. The AI trained on millions of high-quality open-source repositories, so it learned what clean code looks like. It didn't learn what clean code does.

What's missing is everything below the surface. The AI wasn't asked to write tests, so it didn't. Every function assumes perfect input. Logging, error handling, monitoring, deployment automation - none of it was in the prompt, so none of it is in the codebase. When something fails, the app either crashes or silently corrupts data while running.

AI generates code from scratch on each prompt instead of refactoring existing patterns. After a hundred prompts, your codebase has fourteen slightly different implementations of the same auth check, six places that handle currency rounding differently, and two competing definitions of who counts as a paying user. When a bug shows up and you ask the AI to fix it, it patches one of those places. The duplicates keep producing the bug.

Founders feel this chain without seeing the cause directly. The fixes don't stick. New features take longer to ship than the last ones did, and nobody on the team can quite say why. Eventually you hire your first engineer to make sense of it, and they reach the verdict most engineers we've placed on inherited vibe-coded codebases reach within a week: rebuild, don't refactor.

A developer used to need months to create the kind of messy system a senior engineer needs months to clean up. With AI-assisted code, the same complexity gets built in a weekend. The fragile system arrives ten times faster, but cleanup is still set by humans reading every line - and that pace hasn't changed.

## What that produces - the public bills coming due

The maintenance failure mode is the quiet one. The loud one is what surfaces when nobody can read the codebase: security incidents that make news because customer data leaked. Four recent ones tell the same underlying story.

**Lovable (April 2026).** [Security researchers found](https://thenextweb.com/news/lovable-vibe-coding-security-crisis-exposed) that more than 170 of 1,645 sampled Lovable-built applications were exposing personal data, with over 60% leaking API keys or database credentials. The kicker: separately, [Lovable's own platform left every user's source code and database credentials accessible for 48 days](https://www.theregister.com/2026/04/20/lovable_denies_data_leak/) through a basic API authorization flaw. The company that builds the vibe-coding tool couldn't maintain its own platform.

**Moltbook (January-February 2026).** A founder shipped an AI social network and announced he hadn't written a single line of code. [Wiz researchers found within days of launch](https://www.wiz.io/blog/exposed-moltbook-database-reveals-millions-of-api-keys) that the production database was wide open. 1.5 million API authentication tokens, 35,000 email addresses, and private agent-to-agent messages were exposed. The Supabase API key sat in client-side JavaScript with no row-level security policies.

**Replit + SaaStr (July 2025).** [Jason Lemkin documented his twelve-day vibe coding test](https://www.tomshardware.com/tech-industry/artificial-intelligence/ai-coding-platform-goes-rogue-during-code-freeze-and-deletes-entire-company-database-replit-ceo-apologizes-after-ai-engine-says-it-made-a-catastrophic-error-in-judgment-and-destroyed-all-production-data) on Replit's AI agent. The agent deleted his production database during a stated code freeze. Records on 1,206 executives and 1,196 companies were wiped. When Lemkin queried the agent for status, the response included 4,000 nonexistent user rows and "passed" results for tests that hadn't run.

**EnrichLead (March 2025).** Founder Leo Acevedo [shipped a sales-lead SaaS](https://vibegraveyard.ai/story/enrichlead-vibe-coded-saas-shutdown/) built entirely in Cursor with what he publicly called "zero hand-written code." Within two days of his viral launch post, attackers bypassed the subscription paywall, manipulated user data, and burned through his API budget. The product shut down in seven days.

Veracode's 2025 study tested over 100 LLMs and found [45% of generated code samples failed security tests and introduced OWASP Top 10 vulnerabilities](https://www.veracode.com/blog/genai-code-security-report/). [Escape.tech scanned over 1,400 vibe-coded production applications](https://escape.tech/state-of-security-of-vibe-coded-apps) and reported that **65% had at least one security issue and 58% had a critical vulnerability**. None of these failures came from hostile attackers doing clever things - they came from codebases nobody could read or audit.

## The math: every vibe-to-production shortcut pays twice

Here's what the bill looks like.

You spent maybe $500-$2,000 in API credits and a few weekends on the vibe-coded MVP. You skipped the engineering you couldn't afford up front. The hypothesis validated, the customers signed up, the revenue showed up.

Then the rebuild estimate lands. Across our rescue engagements, rebuilds typically land between $40K (a thin SaaS with one core workflow) and $200K (multi-tenant with billing, integrations, and auth). Three to six months of runway either way. You haven't added a single new feature during the rebuild - you've replaced what you already had with code that runs and survives Monday morning.

Compare honestly. The greenfield-from-scratch path ($40K) skips validation entirely - so it's not a real alternative. Vibe-validate ($1,500) plus production rebuild after the vibe attempt fails under load ($80K) lands at $81.5K total. Vibe-validate ($1,500) plus a production build on the validated hypothesis ($40K) lands at $41.5K. The $40K premium comes from rebuilding a rushed production app, not from the validation work.

Add the lost months to that bill. While you were rebuilding, your competitor shipped two new features and a paid integration. Your conversion rate is drifting. Your investor update for next quarter is a sentence you don't want to write.

GitGuardian's [2026 State of Secrets Sprawl report](https://blog.gitguardian.com/the-state-of-secrets-sprawl-2026/) found AI-assisted commits expose hardcoded credentials at more than twice the rate of human-only commits - 3.2% vs 1.5%. That's the per-commit version of the same math: every shortcut on the way in becomes a debt on the way out.

## Generate, validate, kill - the approach that prevents the rebuild

This applies whether you vibe-coded the MVP yourself or hired a shop that did. If you hired a regular dev shop and aren't sure whether they used AI under the hood, our [diagnostic post on detecting vibe-coded apps](/blog/vibe-coding-crisis-ai-code-debt/) walks through the signals to look at - test coverage, commit size, error handling. The path below applies regardless of who shipped the prototype.

Use vibe coding to validate a hypothesis, then throw the code out. Build the rough prototype in Cursor or Replit or Lovable in a weekend. Show it to ten potential customers. Find out which feature they actually pay for and which feature they thought they wanted but won't. What you keep from this stage is a verified hypothesis, not code.

Once the hypothesis is real, kill the prototype. Don't try to maintain it - it can't be maintained. Don't try to refactor it incrementally - the duplicates and missing layers are structural, not patchable.

Rebuild in a stack a human can read - Rails, Django, Laravel, or whatever your engineer is fluent in. Write [tests as you go](/blog/why-how-use-tdd-main-tips-testing/). Deploy through CI. Let someone read every line before it ships. What ships from this stage is a product that survives paying customers and the next twelve rounds of feature requests.

The validation work survives the kill. User flows, edge cases the prototype exposed, the data model that survived first contact with customers - those become the spec for what you build next. A senior move on the rebuild is to write tests against the running prototype first, capturing the actual behavior including discount logic and customer-specific carve-outs nobody wrote down. Then build against the tests. Otherwise you ship v2 and customers tell you "but the old one did X" for six months.

Skipping the rebuild is the trap. The MVP works, the customers pay, the founder thinks: "I'll just keep iterating on this." Six months later the rebuild is happening anyway, only now the founder has runway pressure and ten production users who hit a new bug every time the team ships a fix.

## Five questions to ask before you charge a paying customer

Before you take real money for a vibe-coded app - whether you built it yourself or your shop did - run these questions on whoever shipped it.

**Pick one feature and request a small change to it.** Watch how many files have to change. A real production team modifies one to three files for a simple tweak and demonstrates it in front of you. If you hear "this could affect a few places" or watch seven files get modified, that's a flag.

**Test coverage and failure history.** Ask what percentage of the code is covered by automated tests, then ask to see a test that failed last week and the commit that fixed it. A real production team shows a number above 70% plus a git history of failures and fixes. A team that says "we don't have automated tests yet," shows you a number under 30%, or hands you a test suite where every assertion trivially passes - that's tests as theater. No failure history, no real tests.

**Where the secrets live.** Ask where API keys, database passwords, and payment tokens are stored. The right answer is environment variables on the server, never in the code, never visible in the browser. Any answer that includes "config file," "the repo," or "in the JavaScript" is the wrong answer.

**Try rolling back the last deployment.** A real production team runs one command and the previous version is live in under five minutes. If the answer is "we'd have to redeploy from a backup," "we don't really do rollbacks," or "let me check with the team" - the deployment story isn't real.

**The 3am crash question.** What happens if the app falls over at three in the morning? Healthy answer: an automated alert pages an on-call person within ninety seconds. Unhealthy answer: "a user usually emails us," or "we check it in the morning."

If most of these answers come back on the wrong side, what you have is still a prototype. Ship it to early adopters who tolerate breakage. Don't put a billing form in front of it yet.

If you don't know the answer, [our diagnostic post on detecting vibe-coded apps](/blog/vibe-coding-crisis-ai-code-debt/) walks through the signals to look at - test coverage, commit size, error handling, code duplication.

## The choice: cheap and slow forever, or a real cost once

Vibe coding is excellent for what it was originally for: a clickable demo for next Tuesday's investor meeting, an internal admin report three people will use, a one-time data migration, exploring what a feature might look like before deciding whether to build it. None of those need to survive paying customers, and none have a stranger's data inside.

Once money changes hands, the rules change. Founders who try to keep using the prototype's code end up paying [for the rebuild anyway](/blog/dev-shop-red-flags-checklist/), only later, with less runway, and with paying customers asking why their data was leaked.

The shortcut is real. Vibe coding will let you skip two months of upfront engineering and validate a hypothesis in three weekends. That part works. The rebuild after the prototype ships to production is what costs more than building it properly the first time.

Use vibe coding to validate the hypothesis, then throw the implementation away and rebuild the version that survives paying customers.

If you've vibe-coded an MVP and you're getting nervous about it, [we read your codebase and send back a one-page assessment](https://jetthoughts.com/contact-us/) - test coverage, security risks, a salvage-vs-rebuild verdict. No pitch on the call. We've done this on 40+ rescue engagements and the answer is usually clearer than founders expect.

## Further reading

- [Andrej Karpathy's original "vibe coding" tweet](https://x.com/karpathy/status/1886192184808149383) - February 2025
- [Tom's Hardware on Replit's database deletion](https://www.tomshardware.com/tech-industry/artificial-intelligence/ai-coding-platform-goes-rogue-during-code-freeze-and-deletes-entire-company-database-replit-ceo-apologizes-after-ai-engine-says-it-made-a-catastrophic-error-in-judgment-and-destroyed-all-production-data)
- [Wiz Blog on the Moltbook 1.5M API key leak](https://www.wiz.io/blog/exposed-moltbook-database-reveals-millions-of-api-keys)
- [Vibe Graveyard on EnrichLead](https://vibegraveyard.ai/story/enrichlead-vibe-coded-saas-shutdown/)
- [The Next Web on Lovable's 170+ exposed apps](https://thenextweb.com/news/lovable-vibe-coding-security-crisis-exposed)
- [Veracode's 2025 GenAI Code Security Report](https://www.veracode.com/blog/genai-code-security-report/) - 45% of AI-generated code introduces OWASP Top 10 vulnerabilities
- [Escape.tech's State of Security of Vibe Coded Apps](https://escape.tech/state-of-security-of-vibe-coded-apps) - 65% of 1,400 production apps had security issues, 58% critical
- [InfoWorld on Tenzai's 69-vulnerability study](https://www.infoworld.com/article/4116937/output-from-vibe-coding-tools-prone-to-critical-security-flaws-study-finds-2.html)
- [GitGuardian 2026 State of Secrets Sprawl](https://blog.gitguardian.com/the-state-of-secrets-sprawl-2026/) - AI commits leak credentials at 2x the rate
