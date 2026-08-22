---
title: "What Senior Devs Catch That AI Misses"
description: "A change swapped a made-up number for a confident, wrong explanation of how Propshaft works. Spotting the difference is the thing you are actually hiring for."
date: 2026-08-22
draft: false
author: "Paul Keen"
slug: what-senior-developers-catch-that-ai-misses
keywords: 'ai code review, senior developer value, llm expertise, ai generated code errors, hiring developers ai, technical due diligence'
tags: ['ai', 'hiring', 'startup', 'engineering', 'code-review']
categories: ['Engineering']
cover_image: "cover.png"
cover_image_alt: 'Obsidian-dark cover reading Fluent, Confident, Wrong, with a faceted ruby gem and three chips: METR 19% slower but felt faster, the rule is a different agent type, caught before the merge'
metatags:
  image: cover.png
canonical_url: 'https://jetthoughts.com/blog/what-senior-developers-catch-that-ai-misses/'
related_posts: false
---

Cards on the table before I start: I run a development shop, and this post argues you need experienced people reviewing AI output. That is convenient for me. So I am going to make the case with a diff you can check yourself, and if the Rails reasoning does not hold up, none of the rest should persuade you either.

Here is a change we stopped in review. It is small, it is plausible, and it is wrong in a way you cannot see without knowing Rails.

```diff
- Propshaft is dramatically faster than Sprockets: precompilation drops from
- 45-60 seconds to under 5 seconds on a medium app.
+ Propshaft drops the transpilation and concatenation stages entirely, so asset
+ precompilation stops being a build step that scales with your asset count.
```

The deletion is correct. That timing figure had no measurement behind it and deserved to go.

Read the addition again. It is wrong.

Propshaft still walks every asset, fingerprints it, and copies it into place. Its own README says so:

> All assets in the load path will be copied (or compiled) in a precompilation step for production that also stamps all of them with a digest hash

The work scales with how many assets you have. What drops is the cost of each one, because transpiling and bundling are gone - which is a real and useful thing to say, and not what the sentence said.

So a made-up number was swapped for a made-up mechanism. That is the worse trade, because a mechanism reads as reasoning rather than as a claim someone should go and check - and reasoning gets waved through where a number gets questioned.

## Nobody skimming that paragraph would have stopped

Sit with that for a second.

The sentence had a subject, a cause and an effect, and it used the right vocabulary throughout. It also agreed with the general direction of the truth - Propshaft *is* faster - while getting the reason for it wrong.

You cannot catch that by reading carefully.

You catch it by already knowing what `assets:precompile` does.

Hacker News spent the last three weeks arguing about exactly this, mostly without noticing it was one argument. Sean Goedecke's ["LLMs reward expertise"](https://www.seangoedecke.com/llms-reward-expertise/) drew 573 comments with a simple claim: "The most important skill in prompting is expertise in the domain you're prompting for."

Two weeks later Senko Rašić's ["'Code was never the hard part' is an insult to all programmers"](https://blog.senko.net/code-was-never-the-hard-part-is-an-insult-to-all-programmers) drew 590 more, insisting that "creating good code is a craft that requires skill, patience, attention to detail, experience and wisdom."

Both threads circle the same question and neither settles it. If the model writes the code, what is the person for?

## What the diff answers

It was not the typing.

The prose came out clean, grammatical and confident on the first pass, and would have survived any editor who did not happen to know how Rails compiles assets.

What it could not do was notice that its own explanation was false. It had no way to check, because checking meant knowing something about the Rails asset pipeline that was not in the sentence it had just written.

Goedecke calls the thing experts do "steering" - you recognise a suboptimal suggestion and redirect it. This diff is that mechanism running backwards: without someone who knows the asset pipeline, there is nothing to steer against, and the confident answer wins by default.

Note what the change was *for*. The task was removing an unsourced number, and the same edit introduced a new defect while completing it. Cleanup is where this happens most, because a correction feels like tidying rather than authorship, and gets read that way.

## What actually caught it

A second model, told to attack the diff.

The fix was not a better model or a longer prompt. It was a different one, with a brief that made disagreement its job rather than a risk.

It came back with four findings. This was one, stated flatly:

> On applications with many assets, Propshaft still enumerates, fingerprints, and copies every asset during `assets:precompile`, so its work still scales with asset count. Removing transpilation and concatenation reduces the per-asset cost but does not make the build independent of asset count; the new wording gives readers an incorrect performance expectation.

Then a person had to decide whether the reviewer was right, and I want to be precise about what that took: either knowing the answer already, or being willing to go and read the Propshaft source until you did.

Three links in that chain, and only one of them is automatable. A model wrote, another model challenged, and someone with domain knowledge adjudicated.

Drop the third link and you have two confident systems agreeing with each other.

## It is not only the model that is confident

There is a measurement for this, and it is worse than the anecdote. METR ran a randomised trial with sixteen experienced open-source developers across 246 real issues, in repositories they had worked in for years.

They were 19% slower with AI.

Going in, those developers expected a 24% speedup. Coming out, having just lived through the slowdown, they still estimated AI had made them 20% faster. Roughly forty points between what happened and what they believed happened - in experts, on their own code.

METR is careful about what that does not show, so I will be too: early-2025 models, Claude 3.5 and 3.7 Sonnet through Cursor Pro, on mature codebases with demanding quality standards, and they explicitly decline to claim it generalises to most developers or to later tools.

What travels is the gap itself. Experience did not make those developers better at estimating their own speed. It made them more certain about an estimate that was forty points off.

## Partial checking feels exactly like checking

Here is the same failure again, from later the same day, after the rule above had been written down.

Take a Laravel migration guide that recommends upgrading to 11. Checking it against Laravel's support table shows 11 left security support in March, so the obvious correction is: do not land on 11, go to 12, same PHP floor.

Two of those three facts are right.

Laravel 12 stopped getting bug fixes on 13 August 2026. Laravel 13 has been current since March and requires PHP 8.3, not the 8.2 that correction promises. The table has four rows, and stopping after two produces a fix that is still wrong.

Nobody skipped the check there. The check ran, felt complete, and stopped one row short. That is harder to design against than not checking at all, because it produces the identical feeling of having been careful.

## What this means if you are the one paying for it

You are not buying keystrokes any more. That part got cheap, and pretending otherwise is how founders end up overpaying for output they could have generated themselves.

What stayed expensive is the ability to look at a fluent, well-structured, technically-worded paragraph and say *that specific clause is false*. I have not found a shortcut to it. It comes from having been wrong about the same thing before, which is a slow way to acquire anything.

So when you are deciding who to hire, or whether the shop you are already paying is worth it, the question changed. It is no longer "can they build this." It is: **when the AI hands them something plausible, do they check it, and can they?**

Three things worth asking, none of which require you to read code:

- **Ask them to show you something the AI got wrong recently.** Not a crash - a crash announces itself. Something that ran, looked right, and was wrong anyway. If nothing comes to mind, either they are not reviewing or they are not catching.
- **Ask who reviews the AI's work, and whether it is the same person who prompted it.** Self-review by the author fails the same way here as it always has, except faster and with better grammar.
- **Ask what happens when a check fails.** A team that treats "stop and don't ship this" as a normal outcome has a working process. A team where every review ends in approval has a ritual.

We wrote about the [team structure that makes this hold up](/blog/claude-code-xp-team-workflow/) if you want the operating detail. The short version fits in a sentence: the reviewer has to be someone other than the writer, and they have to be allowed to say no.

## The uncomfortable version

Every defect in this post was caught the same way: a second pass whose brief was to disagree, followed by someone who knew the subject well enough to referee the disagreement.

Neither half works alone. The reviewer that only agrees is decoration, and the reviewer that objects to something nobody can adjudicate is noise.

Expertise earns its money in a handful of moments per week, and none of them look like productivity. Someone reads a paragraph that scans perfectly and says no, and cannot always explain why until they go and check.

That is an awkward thing to sell and an awkward thing to measure. I would still rather tell you that than quote you a velocity number.

## Sources

- Sean Goedecke, ["LLMs reward expertise"](https://www.seangoedecke.com/llms-reward-expertise/) - [HN discussion](https://news.ycombinator.com/item?id=49161518), 573 comments
- Senko Rašić, ["'Code was never the hard part' is an insult to all programmers"](https://blog.senko.net/code-was-never-the-hard-part-is-an-insult-to-all-programmers) - [HN discussion](https://news.ycombinator.com/item?id=49222189), 590 comments
- METR, ["Measuring the Impact of Early-2025 AI on Experienced Open-Source Developer Productivity"](https://metr.org/blog/2025-07-10-early-2025-ai-experienced-os-dev-study/) - the 19% slowdown, the 24% predicted speedup, the 20% believed speedup, and METR's own limits on what it shows
- [Propshaft](https://github.com/rails/propshaft) - the asset pipeline whose behaviour the claim got wrong. Its README settles both halves. It is faster: "a dramatically simpler and faster asset pipeline compared to previous options, like Sprockets." And it still does per-asset work: "All assets in the load path will be copied (or compiled) in a precompilation step for production that also stamps all of them with a digest hash." The original sentence took the first half as the reason for the second.
