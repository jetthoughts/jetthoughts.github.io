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

You can stand up a team of autonomous agents this afternoon. The frameworks are real, the demos are real, and the question worth asking is the one nobody puts on the landing page: how often does it work?

Somebody measured. A group at UC Berkeley - collected execution traces from seven multi-agent frameworks and published the success rates. Across six of them, on their respective benchmarks:

| Framework | Benchmark | Success |
|---|---|---:|
| AG2 | OlympiadBench | 59.0% |
| MetaGPT | ProgramDev | 40.0% |
| Magentic-One | GAIA | 38.0% |
| ChatDev | ProgramDev | 33.3% |
| HyperAgent | SWE-Bench Lite | 25.3% |
| AppWorld | Test-C | 13.3% |

Two things travel with those numbers. The paper's own caption says "Performances are measured on different benchmarks, therefore they are not directly comparable," so read it as a range rather than a league table: AppWorld is not four times worse than AG2, they are not attempting the same thing. And the runs used GPT-4o and Claude-3, which are not what you would wire up today. Frontier models have moved; whether the coordination failures moved with them is the open question, and the paper does not answer it.

What the spread does tell you is the shape of the answer. On the tasks these systems were built for, the modal outcome is failure, and the paper opens by saying so: "Despite enthusiasm for Multi-Agent LLM Systems (MAS), their performance gains on popular benchmarks are often minimal."

## The failures are organisational, not mathematical

The same team built a taxonomy out of those traces. Fourteen distinct failure modes, sorted into three categories, with two expert annotators reaching a Cohen's kappa of 0.88 - which is to say the failure modes are consistent enough that different people looking at the same trace agree on what went wrong.

The three categories are worth memorising: system design, inter-agent misalignment, task verification. Notice what is missing. None of them is "the model was not smart enough." They are specification, coordination and checking - the same three things that go wrong in a team of humans who have never worked together.

## The enthusiasm was not stupid

It would be easy to stop there and write the sceptical post. The evidence does not support that either.

Anthropic published results from their multi-agent research system where a lead agent directs subagents, and reported that it "outperformed single-agent Claude Opus 4 by 90.2% on our internal research eval." Not a rounding error. For the right shape of problem, the architecture wins convincingly.

They were equally direct about the bill. "Agents typically use about 4× more tokens than chat interactions, and multi-agent systems use about 15× more tokens than chats." And on their browsing evaluation, "token usage by itself explains 80% of the variance" - most of what looks like architectural cleverness is buying compute.

Then the sentence that should decide this for most teams reading it. On why the pattern suits research and not their day job:

> most coding tasks involve fewer truly parallelizable tasks than research, and LLM agents are not yet great at coordinating and delegating to other agents in real time.

That is the company selling the agents, telling you the parallel-swarm shape is a poor fit for building software.

## Both camps arrived at the same rule

In June 2025 Cognition, the team behind Devin, published an essay called *Don't Build Multi-Agents*. Their argument was not about model quality. Two subagents each make locally reasonable choices, neither sees the other's decisions, and you get a coherent half bolted to a different coherent half.

Ten months later Walden Yan wrote the follow-up, and this is the part I find genuinely useful. They did not double down and they did not recant. They narrowed:

> we've found a narrower class of patterns that do [work]: setups where multiple agents contribute intelligence to a task while writes stay single-threaded.

Put that next to Anthropic's lead-agent-with-subagents design and the two most-cited positions in this argument are describing the same architecture in different vocabulary: many agents may read and reason, exactly one is allowed to change anything.

That constraint is doing specific work. Two agents editing the same codebase each make choices the other never sees, and the incoherence shows up at integration rather than at the point either one went wrong. Route every change through one writer and the disagreements surface as review comments instead, which is a form you can act on.

![Diagram contrasting two agents both editing a codebase and producing incompatible halves, against several agents reading and checking while a single agent owns every change](writers.svg)

## What this means if you are setting one up

Start by asking whether your task actually has parallel parts. Research does: twenty sources can be read at once and nothing breaks. A feature usually does not, because step four depends on a decision made in step two, and an agent that never saw step two will contradict it confidently.

Then keep the write path single-threaded, and let the extra agents do everything that is not writing - reading, checking, disagreeing.

We run our own delivery this way, and not because we read the papers first. We arrived at it by losing review findings between agents until we stopped letting more than one of them write. The rule is four lines:

```text
One author owns the diff. Nobody else writes.
Reviewers get the artifact and the goal, never my conclusion.
Every reviewer must name one thing they would cut.
Author never reviews their own change.
```

Line one is the topology the papers describe. Lines two and three are what stops the readers from simply agreeing with you, which is the failure mode that replaces the coordination failure once the topology is right. A reviewer told what you already concluded will confirm it. A reviewer required to name a cut has to form an opinion.

On our own projects that formula now runs the loop end to end: agents pick work off a queue, write, review each other, and open pull requests, with a short written list of decisions that come back to a human. Pricing, publishing outward, whether a claimed number is real, and anything both split and irreversible. Everything else they settle.

I want to be precise about the scope, because this is the kind of claim that gets inflated. That is our own codebases, not client delivery, and the list of human decisions is the reason it works rather than an admission that it does not. The formula is the four lines above. There is nothing else to it.

If you want the implementation rather than the argument, we wrote up [our production multi-agent pipeline in Rails](/blog/multi-agent-llm-rails-rubyllm/), including where one agent turned out to be enough.

And budget for the 15×. A system that is right slightly more often and costs an order of magnitude more per run is not automatically a good trade. It depends entirely on what a wrong answer costs you, which is a question about your business rather than about agents.

## So how many of them work?

Between 13% and 59% on the published benchmarks, in the wide-open configuration most of those frameworks were attempting.

For our own projects the answer is different, and I want to be careful about how I say it: the loop runs unattended and produces work we ship, which is a description rather than a rate. I have not published a percentage because we have not measured one, and quoting a feeling next to Cemri's numbers would be exactly the move this post is complaining about.

So that is the question to take away, pointed at yourself. What share of your agent runs produced something you shipped without rework? If you cannot answer it, you do not have a success rate. You have an impression, and impressions in this field have been running well ahead of the measurements.

## Sources

- Mert Cemri et al., [Why Do Multi-Agent LLM Systems Fail?](https://arxiv.org/abs/2503.13657), arXiv 2503.13657, NeurIPS 2025 Datasets & Benchmarks track.
- Anthropic, [How we built our multi-agent research system](https://www.anthropic.com/engineering/multi-agent-research-system).
- Walden Yan, Cognition, [Don't Build Multi-Agents](https://cognition.com/blog/dont-build-multi-agents) (June 2025) and [Multi-Agents: What's Actually Working](https://cognition.com/blog/multi-agents-working) (22 April 2026).
