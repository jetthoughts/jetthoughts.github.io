---
title: "Stop Handing Out Tasks. Hand Out the Goal."
description: "A task list caps the result at your own understanding of the problem. Here is the one clause we added to our reviewer instructions that turned approvals into findings."
date: 2026-09-16
draft: false
author: "Paul Keen"
slug: delegate-the-goal-not-the-task
keywords: 'delegation, engineering management, commander intent, ai agents delegation, briefing teams, outcome delegation'
tags: ['management', 'engineering', 'ai', 'teams']
categories: ['Engineering']
cover_image: "cover.png"
cover_image_alt: 'Obsidian-dark cover reading Stop handing out tasks, hand out the goal, with a faceted ruby gem and three chips: a task list caps at your own understanding, name one thing you would cut, goals need constraints'
metatags:
  image: cover.png
canonical_url: 'https://jetthoughts.com/blog/delegate-the-goal-not-the-task/'
related_posts: false
---

Cards on the table: we sell engineering help, and there is a link to us at the bottom. So the fix is at the top instead, in full, as two blocks you can copy. It works whether or not you ever talk to me.

We had a reviewer that approved everything.

Not carelessly. It read the diff, it considered the criteria, and it came back with some version of "this looks good, here are two small suggestions." Every time. The work was not that good, and I knew it was not that good, which is the only reason I noticed.

The instruction was the problem. Here is roughly what we had been sending:

```text
Review this change. I think the caching layer is wrong -
check whether the cache key handles the tenant scope, and
confirm the tests cover the invalidation path.
```

Read it as the reviewer. Three decisions are already made: that the caching layer is the risk, that tenant scope is the specific worry, and that invalidation is what tests should cover. The only work left is confirmation. So it confirmed, and handed my own opinion back to me with a second signature on it.

## What we changed was one clause

```text
Review this change. Goal: I need to be able to change the
caching layer in six months without breaking tenant isolation.

Tell me what you would cut, and name at least one thing.
```

No mention of cache keys. No mention of invalidation. The reviewer came back about a race in the warm-up path that I had not been looking at, because I had not thought of it, because if I had thought of it I would have put it in the prompt and capped the answer again.

That is the whole mechanism. "Check whether X is wrong" is a task, and completing it faithfully produces a confirmation. "Here is what I need to be true, tell me what should go" is a goal, and there is no way to complete it without forming an opinion.

Our own written instructions now carry the general form:

> Brief others with evidence, never with your conclusions - a panel handed your inference will return it wearing independent-sounding confidence.

## Why a task list caps the result

When you assign a task, you have already made the decisions that matter. You decided what the problem is, what approach fits, and what the steps are. Whoever executes it can do that faithfully and cannot do better, because the ceiling is your understanding of the problem at the moment you wrote the ticket.

That is fine when your understanding is complete. Most of the time it is not, and the person doing the work is about to learn things you did not know when you assigned it. A task list gives them nowhere to put that.

Delegating the goal inverts it. You supply purpose, what success looks like, and the constraints that must hold. They supply the route. When the situation turns out different from your assumption - and it will - they can adapt without waiting for you, because they know what they were actually trying to achieve.

Military doctrine has a name for this and a large literature behind it, filed under mission command. I am not going to reach for the Prussian origin story that usually gets told with it. Historians have been arguing about that lineage for two decades, the tidy version is contested, and I have not read the sources closely enough to arbitrate. The idea stands on its own without the costume.

## The same instruction, both ways

| Handed out as a task | Handed out as a goal |
|---|---|
| "Add caching to the search endpoint" | "Search feels slow on the dashboard. Get it under 200ms without stale results." |
| "Write tests for the payment module" | "I want to be able to change the payment module without fear. Show me what you would trust." |
| "Review this PR for SQL injection" | "This touches auth. Tell me what you would not ship, and what you would cut." |

The left column is easier to write and easier to measure. It is also the version where you find out on delivery that caching was the wrong fix, the tests cover the code rather than the risk, and the reviewer found no SQL injection because there was not any - while missing the session handling that was actually broken.

## Where this goes wrong

Goals without constraints produce creative compliance. "Make the dashboard faster" gets you a dashboard that loads instantly and shows yesterday's numbers. The constraint was in your head, it never made it into the brief, and what came back satisfied every word you actually said.

So the goal has to carry its boundaries. Not steps - boundaries. What must remain true, what you will not accept, where the edges are. "Under 200ms" is a goal. "Under 200ms without stale results" is a goal somebody can actually pursue without accidentally destroying something you cared about.

The second failure is subtler. Goal delegation needs the person or the agent to have enough context to make the decisions you are handing over. Give a goal to someone who does not know the system and you have not empowered them, you have abandoned them. That is not an argument for task lists. It is an argument for the context arriving first.

This is also why the brief matters more with agents than it does with people, at least for now. Anthropic, writing about their own multi-agent system, note that "LLM agents are not yet great at coordinating and delegating to other agents in real time." A human team repairs a bad brief by talking to each other. A set of agents mostly cannot, so whatever you failed to put in the instruction stays missing.

## It is the same rule for people and for agents

I did not arrive at this from management books. I arrived at it because our review process was producing agreeable nonsense, and the fix that worked on an AI reviewer turned out to be the fix I should have been applying to humans for years.

The mechanism is identical. A junior developer told exactly what to do will do exactly that and will not tell you the requirement was wrong. A senior developer given the goal will come back and say the feature should not exist. You hired the second one for that, and then you brief them like the first one.

Worth saying: this is about what goes *in* the instruction, not about who does the work. The question of how to structure a team of agents - who is allowed to write, who only reads - is a different problem, and I wrote about [what the measured success rates actually look like](/blog/agent-team-success-rate/) separately.

## Try it on the next thing you send

Open the last instruction you wrote, to a person or a model, and look for your own conclusion in it. Mine was hiding in the words "I think the caching layer is wrong." Take it out, put the evidence in its place, and add the clause.

Two warnings. The first week is unpleasant, because you find out what people were not telling you. And you have to actually accept the cuts: ask for them twice, override them twice, and you have taught everyone the question was rhetorical, which leaves you worse off than before you asked.

And if the answers you get back are alarming enough that you want someone else to look, [that is a thing we do](/services/vibe-code-rescue/). The clause works without us.

## Sources

- Anthropic, [How we built our multi-agent research system](https://www.anthropic.com/engineering/multi-agent-research-system) - on the current limits of agents delegating to each other.
- The idea has a formal home in US Army mission command doctrine (ADP 6-0). I have deliberately not quoted it here: the publication is public, the historical lineage usually told alongside it is disputed by military historians, and I have not read those sources closely enough to summarise the argument fairly.
