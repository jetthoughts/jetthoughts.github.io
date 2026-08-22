---
title: "What Senior Devs Catch That AI Misses"
description: "An AI agent replaced a made-up number in our own blog post with a confident, wrong explanation. What caught it is the thing you are actually hiring for."
date: 2026-08-22
draft: false
author: 'JetThoughts Team'
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

The sentence looked fine, and it sat in an open pull request waiting to be merged.

An agent had just pulled an unsourced performance number out of one of our older Rails posts and written a replacement in its place. Propshaft, it said, "drops the transpilation and concatenation stages entirely, so asset precompilation stops being a build step that scales with your asset count."

Read that again if you know Rails. It is wrong.

Propshaft still walks every asset, fingerprints it, and copies it into place. The work scales with how many assets you have - what drops is the cost of each one. The agent had removed a made-up number and replaced it with a made-up mechanism, which is worse, because a mechanism reads as reasoning rather than as a claim someone should go and check.

## Nobody skimming that paragraph would have stopped

That is the part worth sitting with.

The sentence had a subject, a cause and an effect, and it used the right vocabulary throughout. It also agreed with the general direction of the truth - Propshaft *is* faster - while getting the reason for it wrong.

You cannot catch that by reading carefully.

You catch it by already knowing what `assets:precompile` does.

Hacker News spent the last three weeks arguing about exactly this, mostly without noticing it was one argument. Sean Goedecke's ["LLMs reward expertise"](https://www.seangoedecke.com/llms-reward-expertise/) drew 573 comments with a simple claim: "The most important skill in prompting is expertise in the domain you're prompting for."

Two weeks later Senko Rašić's ["'Code was never the hard part' is an insult to all programmers"](https://blog.senko.net/code-was-never-the-hard-part-is-an-insult-to-all-programmers) drew 590 more, insisting that "creating good code is a craft that requires skill, patience, attention to detail, experience and wisdom."

Both threads circle the same question and neither settles it. If the model writes the code, what is the person for?

## The answer our own mistake gave

Not typing - the agent typed fine.

What it could not do was notice that its own explanation was false. It had no way to check, because checking meant knowing something about the Rails asset pipeline that was not in the sentence it had just written.

Goedecke calls the thing experts do "steering" - you recognise a suboptimal suggestion and redirect it. Our incident is the same mechanism running backwards. Nobody steered, so a confident wrong answer went straight into a draft, inside a change whose entire purpose was removing unreliable claims.

That last part is the uncomfortable bit. The task was *clean up unsourced numbers*, and the agent did the task and introduced a new defect in the same motion.

## What actually caught it

A second model, told to attack the diff.

The fix was not a better model or a longer prompt. It was a different one, with a brief that made disagreement its job rather than a risk. It came back with four findings, and this was one of them, stated flatly: Propshaft still enumerates, fingerprints and copies every asset, so its work still scales with asset count.

Then a person had to decide whether the reviewer was right. That took knowing the answer independently, or being willing to go read the Propshaft source until you did.

Three links in that chain, and only one of them is automatable. A model wrote, another model challenged, and someone with domain knowledge adjudicated.

Drop the third link and you have two confident systems agreeing with each other.

## It is not only the model that is confident

There is a measurement for this, and it is worse than the anecdote. METR ran a randomised trial with sixteen experienced open-source developers across 246 real issues, in repositories they had worked in for years.

They were 19% slower with AI.

Going in, those developers expected a 24% speedup. Coming out, having just lived through the slowdown, they still estimated AI had made them 20% faster. Roughly forty points between what happened and what they believed happened - in experts, on their own code.

METR is careful about what that does not show, so I will be too: early-2025 models, Claude 3.5 and 3.7 Sonnet through Cursor Pro, on mature codebases with demanding quality standards, and they explicitly decline to claim it generalises to most developers or to later tools.

What travels is the gap itself. Being experienced did not make the self-assessment accurate, which is the whole problem with judging this by feel.

## Partial checking feels exactly like checking

Here is the same failure again, from later the same day, after the rule above had been written down.

We found an old Laravel migration guide with no citations at all and went to verify it. The framework's support table said Laravel 11 had been out of security support since March. So a correction went on the page: do not land on 11, go to 12, same PHP floor.

Two of those three facts were right.

Laravel 12 had stopped getting bug fixes nine days earlier, and Laravel 13 - current since March, and the sensible target - requires PHP 8.3 rather than the 8.2 the correction promised. The table had four rows and two of them got read.

Nobody skipped the check. The check got done, felt done, and stopped one row short of the answer. That is a harder failure to design against than not checking at all, because it produces the same feeling of having been careful.

## What this means if you are the one paying for it

You are not buying keystrokes any more. That part got cheap, and pretending otherwise is how founders end up overpaying for output they could have generated themselves.

What stayed expensive is the ability to look at a fluent, well-structured, technically-worded paragraph and say *that specific clause is false*. There is no shortcut to it. It comes from having been wrong about the same thing before.

So when you are deciding who to hire, or whether the shop you are already paying is worth it, the question changed. It is no longer "can they build this." It is: **when the AI hands them something plausible, do they check it, and can they?**

Three things worth asking, none of which require you to read code:

- **Ask them to show you something the AI got wrong recently.** Not a crash - a crash announces itself. Something that ran, looked right, and was wrong anyway. If nothing comes to mind, either they are not reviewing or they are not catching.
- **Ask who reviews the AI's work, and whether it is the same person who prompted it.** Self-review by the author fails the same way here as it always has, except faster and with better grammar.
- **Ask what happens when a check fails.** A team that treats "stop and don't ship this" as a normal outcome has a working process. A team where every review ends in approval has a ritual.

We wrote about the [team structure that makes this hold up](/blog/claude-code-xp-team-workflow/) if you want the operating detail. The short version fits in a sentence: the reviewer has to be someone other than the writer, and they have to be allowed to say no.

## The uncomfortable version

Our agent produced a wrong claim while cleaning up wrong claims. We caught it because we had built the habit of pointing a second, adversarial pass at anything an agent wrote, and because someone on the other end knew Rails well enough to referee.

If we had not, that sentence would be live right now, sounding authoritative, on a post about Rails performance.

That is the whole argument for expertise, and it is not a comfortable one. The value is not in what gets produced. It is in the small number of moments where someone looks at fluent output and says no.

## Sources

- Sean Goedecke, ["LLMs reward expertise"](https://www.seangoedecke.com/llms-reward-expertise/) - [HN discussion](https://news.ycombinator.com/item?id=49161518), 573 comments
- Senko Rašić, ["'Code was never the hard part' is an insult to all programmers"](https://blog.senko.net/code-was-never-the-hard-part-is-an-insult-to-all-programmers) - [HN discussion](https://news.ycombinator.com/item?id=49222189), 590 comments
- METR, ["Measuring the Impact of Early-2025 AI on Experienced Open-Source Developer Productivity"](https://metr.org/blog/2025-07-10-early-2025-ai-experienced-os-dev-study/) - the 19% slowdown, the 24% predicted speedup, the 20% believed speedup, and METR's own limits on what it shows
- [Propshaft](https://github.com/rails/propshaft) - the asset pipeline whose behaviour the claim got wrong. Its README settles both halves. It is faster: "a dramatically simpler and faster asset pipeline compared to previous options, like Sprockets." And it still does per-asset work: "All assets in the load path will be copied (or compiled) in a precompilation step for production that also stamps all of them with a digest hash." The original sentence took the first half as the reason for the second.
