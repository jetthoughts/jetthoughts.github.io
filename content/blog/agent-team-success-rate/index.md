---
title: "Autonomous Agent Teams Are Real. Measured Success Runs 13% to 59%."
description: "Six multi-agent frameworks, measured across coding and reasoning benchmarks. Then the pattern both the loudest sceptic and the loudest proponent ended up agreeing on: many agents may think, one agent writes."
date: 2026-09-09
draft: false
author: "Paul Keen"
slug: agent-team-success-rate
keywords: 'multi agent success rate, autonomous ai agents team, multi agent llm failure, ai agent orchestration, coding agents production'
tags: ['ai', 'agents', 'engineering', 'architecture']
categories: ['Engineering']
cover_image: "cover.png"
cover_image_alt: 'Obsidian-dark cover reading Autonomous agent teams are real, measured success runs 13 to 59 percent, with a faceted ruby gem and three chips: six frameworks measured, 15x the token bill, writes stay single-threaded'
metatags:
  image: cover.png
canonical_url: 'https://jetthoughts.com/blog/agent-team-success-rate/'
related_posts: false
---

You can stand up a team of autonomous agents this afternoon. Whether it produces anything you would ship is a separate question.

A group at UC Berkeley collected execution traces from seven multi-agent frameworks and published how often each one finished its task correctly. Six of them, on their own benchmarks:

| Framework | Success on its own benchmark |
|---|---:|
| AG2 | 59.0% |
| MetaGPT | 40.0% |
| Magentic-One | 38.0% |
| ChatDev | 33.3% |
| HyperAgent | 25.3% |
| AppWorld | 13.3% |

If you go and check that figure, it is captioned "Failure rates" - I have flipped it, because the chart's own legend labels those segments Success. The caption warns against reading it as a ranking: "Performances are measured on different benchmarks, therefore they are not directly comparable." AppWorld and AG2 are not attempting the same thing. The caption also names the models, GPT-4o and Claude-3.7-Sonnet, which is not what you would wire up today. Whether the failures got better when the models did is unmeasured.

Even allowing for all of that, most runs failed. The paper's first line is "Despite enthusiasm for Multi-Agent LLM Systems (MAS), their performance gains on popular benchmarks are often minimal."

## The failures look like a bad org chart

The same team sorted those traces into fourteen failure modes and three groups: system design, inter-agent misalignment, and task verification. In plainer words, the specification was wrong, the agents talked past each other, or nobody checked the result.

None of the three is "the model could not do it." Every one of them is a management problem, and you can find all three in a company that has never used an agent.

## The other side has numbers too

Anthropic runs a multi-agent research system, a lead agent directing subagents, and reports it "outperformed single-agent Claude Opus 4 by 90.2% on our internal research eval." For the right shape of work, the architecture wins by a lot.

They are equally plain about the price. "Agents typically use about 4× more tokens than chat interactions, and multi-agent systems use about 15× more tokens than chats." Spending is also most of what separates a good configuration from a bad one: across their browsing evaluations "token usage by itself explains 80% of the variance," with tool-call count and model choice as the other two factors.

Then they say who it is not for:

> most coding tasks involve fewer truly parallelizable tasks than research, and LLM agents are not yet great at coordinating and delegating to other agents in real time.

## Cognition changed its mind in public

In June 2025 Cognition, who build Devin, published *Don't Build Multi-Agents*. Their complaint was not about model quality. Split a job between two subagents and each one makes reasonable local choices the other never sees, so you get two coherent halves that do not fit together.

Ten months later Walden Yan published the follow-up. He did not recant and he did not double down. He narrowed the claim:

> we've found a narrower class of patterns that do [work]: setups where multiple agents contribute intelligence to a task while writes stay single-threaded.

Anthropic's system reaches the same shape from the other end - many subagents searching and reading, one lead agent holding the result - though theirs is a research system whose subagents never touch code, so it has no writes to serialise in the first place. Yan's rule is the version that applies when they do: any number of agents may read, reason and argue, and one of them is allowed to change the code.

![Diagram contrasting two agents both editing a codebase and producing incompatible halves, against several agents reading and checking while a single agent owns every change](writers.svg)

When two agents edit the same code, their disagreement shows up at integration, long after either of them made the choice that caused it. Send every change through one writer and the same disagreement arrives as a review comment, while there is still time to do something about it.

## What we do

Ask first whether the job has parts that can genuinely happen at once. Reading twenty sources does. Building a feature usually does not, because step four depends on something decided in step two, and an agent that never saw step two will contradict it with total confidence.

We lost review findings between agents for months before we accepted that and stopped letting more than one of them write. What replaced it is four lines:

```text
One author owns the diff. Nobody else writes.
Reviewers get the artifact and the goal, never my conclusion.
Every reviewer must name one thing they would cut.
Author never reviews their own change.
```

Line one is the topology the papers describe. Lines two and three exist because once the topology is fixed, the next failure is agreement: a reviewer told what you already concluded will agree with you. Making it name a cut forces it to have an opinion of its own.

On our own projects that runs the whole loop. Agents take work off a queue and open pull requests, each change written by one of them and reviewed by others - the rule is one writer per diff, not one writer overall. A short written list says what comes back to a human: pricing, anything published outward, whether a claimed number is real, and anything both split and irreversible. They settle the rest.

Two limits on that. It is our codebases, not client delivery. And that list of things which come back to a human is a component of the system rather than an apology for it.

The implementation, if you want that rather than the argument, is [our multi-agent pipeline in Rails](/blog/multi-agent-llm-rails-rubyllm/), including the part where one agent turned out to be enough.

Budget for the 15× before you start. A system that is right somewhat more often and costs ten times more per run is only worth it if a wrong answer is expensive, and how expensive a wrong answer is depends on your business rather than on agents.

## So how many of them work?

Between 13% and 59% on the published benchmarks, running the wide-open shape most of those frameworks attempted.

Ours works, and I am not going to put a number on it. The loop runs without a human in it between those checkpoints and produces work we ship, which is a description rather than a measurement. Printing a percentage next to Cemri's would be the exact thing this post is complaining about.

Which leaves the question worth pointing at yourself. What share of your agent runs produced something you shipped without rework? Nobody I have asked can answer it, ourselves included, and in the absence of that number everyone has been going on impressions.

## Sources

- Mert Cemri et al., [Why Do Multi-Agent LLM Systems Fail?](https://arxiv.org/abs/2503.13657), arXiv 2503.13657, NeurIPS 2025 Datasets & Benchmarks track.
- Anthropic, [How we built our multi-agent research system](https://www.anthropic.com/engineering/multi-agent-research-system).
- Walden Yan, Cognition, [Don't Build Multi-Agents](https://cognition.com/blog/dont-build-multi-agents) (June 2025) and [Multi-Agents: What's Actually Working](https://cognition.com/blog/multi-agents-working) (22 April 2026).
