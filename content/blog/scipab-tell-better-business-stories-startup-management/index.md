---
remote_url: https://dev.to/jetthoughts/scipab-tell-better-business-stories-15im
source: dev_to
remote_id: 2158197
dev_to_id: 2158197
dev_to_url: https://dev.to/jetthoughts/scipab-tell-better-business-stories-15im
title: 'SCIPAB Your Dev Shop: 6 Founder Questions'
description: 'Most founders use SCIPAB to brief their board. Use it to interrogate your dev shop instead. Six questions that turn fuzzy weekly updates into transparency.'
created_at: '2024-12-16T00:36:51Z'
edited_at: '2026-05-10T00:00:00Z'
draft: false
keywords: 'manage dev shop, questions to ask dev shop, non-technical founder dev shop, scipab framework, devshop transparency'
tags:
- founder
- dev-shop
- communication
- transparency
- startup
canonical_url: https://jetthoughts.com/blog/scipab-tell-better-business-stories-startup-management/
cover_image: cover.png
date: 2024-12-16
metatags:
  image: cover.png
  og_title: 'SCIPAB Your Dev Shop: 6 Founder Questions'
  og_description: 'Most founders use SCIPAB to brief their board. Use it to interrogate your dev shop instead. Six questions that turn fuzzy weekly updates into transparency.'
slug: scipab-tell-better-business-stories-startup-management
---

You're on a weekly status call with your dev shop. The PM walks you through fourteen closed Jira tickets. You nod. You don't actually know what shipped, and the budget side of that question never gets answered. The meeting is designed to leave you feeling informed, and you walk out flying blind anyway.

SCIPAB is a six-step communication framework that consultants use to brief executives. Most posts about it teach founders how to talk to their board. This post does the opposite. Use SCIPAB to make your dev shop talk to you.

## Why turn SCIPAB around

In the room with your dev shop, you're the executive. They're the operator. You don't need a clear narrative for your investors right now - they need a clear narrative for you. The same six-step compression that takes a 30-minute board update down to 60 seconds also takes a fuzzy weekly status down to six concrete artifacts you can verify. You can't read code, but you can read whether the answers move when you press on them.

## The six questions

**S - Which users touched what shipped this week?**

A real production team can show you which users hit the new feature this week, with timestamps and usage counts. For paying products that means real customers; for pre-launch products it means beta testers or your design partner. "We deployed it" isn't the answer. If nobody can show you a single user interacting with this week's release, what shipped didn't actually reach anyone yet. The [Friday demo rule](/blog/how-know-what-your-team-doing-remote-startup/) covers the deployment-side artifact; this question covers the people-side.

**C - What slipped this week, and why?**

Every team hits problems. The question is whether your team explains them in plain English or in jargon. "We hit unexpected complexity" tells you nothing. "The email parser broke when users sent attachments larger than 5MB; we caught it Tuesday and patched it Thursday" tells you the team understood what happened and did something about it. A vendor who hands you "unexpected complexity" without ever getting more specific is testing whether you'll let it slide.

**I - What does that delay cost me?**

A vague "we'll catch up in the next sprint" hides a number. The honest version translates a slip into runway: "this pushes launch by 8 working days, costs $4K in cloud overage, and we'll miss Tuesday's investor demo." Sprints don't pay your AWS bill. Every slip should land somewhere on your cap-table math - a number you can put in front of a board.

**P - What do you recommend we do about it?**

A competent vendor brings options with trade-offs. A struggling vendor brings the question back to you. If the recommendation is "we'll look at options," your team is asking you to decide for them. The right answer sounds like: "we recommend cutting the Stripe retry feature from this release. It saves four days. The two customers using webhook retries today will see slower retries until next sprint - that's the trade-off."

**A - What's the next concrete step?**

"We'll keep working on it" isn't a step. A real action has a person and a date attached: "Marcus will deploy the fix to staging Thursday at 2pm. You'll get a demo Loom on Friday morning." If your team can't name the person and the day, the work hasn't actually been planned yet.

**B - What does success look like in numbers?**

You should be able to tell whether the work succeeded by looking at one number a month later. "Things will improve" isn't a number. "We go from 12 paying users last month to 30 by July with the new flow live" is. If success isn't measurable at the call, you'll measure activity at every call after.

## How to actually run this

Use SCIPAB on the call you're already having. Don't add a meeting. Walk the six questions in order, write the answers down, and compare them across three weeks. If the answers match the "good" patterns above, your shop is operating transparently. If most sit on the "bad" side, the problem stopped being communication a while ago. Your vendor doesn't want to be held accountable, and that's a different conversation.

Founders deeper into the rescue zone can pair this with our [red flags checklist for dev shops](/blog/dev-shop-red-flags-checklist/), which covers the contract clauses to demand and the signals that say SCIPAB has run out of room.

## When SCIPAB won't help

A vendor who refuses to answer the Situation question - who can never produce a staging URL - has a different problem than communication. They don't have a working build to show you. The framework is a magnifier for transparent vendors; an opaque vendor stays opaque no matter how good your questions are.

A founder we worked with last year ran SCIPAB on her shop for three weeks. Question 1 came back with promises every time, never with a URL she could click. Velocity looked fine on paper - eighteen tickets closed per sprint - but nothing she could log into. We rebuilt her project from scratch a month later. The questions caught the problem before her budget did.

If you suspect the codebase under your shop's work is itself the issue - AI-generated, untested, hard to change - our [diagnostic on detecting vibe-coded apps](/blog/vibe-coding-crisis-ai-code-debt/) walks through the signals separately from the communication audit.

## What this changes

Don't expect the framework to fix anything on its own. Run the six questions three weeks in a row and write down the answers. By week three, the gaps and patterns will tell you whether your team is operating with the kind of transparency you're paying for. The structural compression itself comes from Barbara Minto's [Pyramid Principle](https://www.barbaraminto.com/), the consulting playbook that taught McKinsey associates how to brief partners in sixty seconds. SCIPAB just points the same compression at the side of the table that needs to be more accountable.
