---
title: 'How We Replicated a Full Product Team With Claude Code Agents'
description: 'Solo Claude Code agents ship like solo developers - missing PM, designer, QA, customer voice. Here is the team-mode setup running Shape Up plus XP plus reflection-driven Kaizen.'
date: 2026-05-04
draft: false
author: 'JetThoughts Team'
slug: claude-code-xp-team-workflow
keywords: 'claude code agents, ai code agents production, multi-agent workflow, xp team ai, claude code workflow, ai agents code review, shape up methodology, ralph loop'
tags: ['ai', 'claude-code', 'xp', 'productivity', 'startup', 'engineering']
categories: ['Engineering']
cover_image: cover.png
metatags:
  image: cover.png
  og_title: 'How We Replicated a Full Product Team With Claude Code Agents'
  og_description: 'Solo Claude Code agents ship like solo developers - missing PM, designer, QA, customer voice. Here is the team-mode setup running Shape Up plus XP plus reflection-driven Kaizen.'
cover_image_alt: 'Capability map of a Claude Code agent team for a Rails app: business strategist, product manager, UI/UX designer, tech lead, critic panel, QA, DevOps gates, reflection - styled as an XP team standup board.'
canonical_url: 'https://jetthoughts.com/blog/claude-code-xp-team-workflow/'
related_posts: false
---

A solo Claude Code agent compresses product, design, engineering, and QA into one process. The diff compiles, tests stay green, but the feature solves a problem nobody actually has. We covered this founder pain in [Vibe Coding Crisis](/blog/vibe-coding-crisis-ai-code-debt/). After that we wrapped the agent in the rest of a product team and what got shipped changed.

![Capability map of a Claude Code agent team running Shape Up plus XP plus reflection-driven Kaizen](pipeline.svg)

## The roles we replicated

Driver-plus-tests is not a team. Each role we added closed a gap that solo agents kept reproducing on every ticket.

| Role | What it does | Where it lives |
|------|--------------|----------------|
| Business Strategist | Sets the north star - markets, customers, where we don't compete | Founder plus a strategy doc the agents read |
| Product Manager | Runs Shape Up pitches, decides which bets to ship, holds the customer voice from interview transcripts, confirms the data signal supports each bet | PM agent (in our setup, `lead-shaper`) reading the strategy doc plus interview notes |
| UI/UX Designer | Runs synthetic-user walkthroughs against assumptions, then produces the screen flow before any code lands | Discovery agent (in our setup, `critic-discovery`) plus Google Stitch as the design canvas |
| Tech Lead | Calls feasibility risk, surfaces the architectural patterns the solution must fit, then drives and navigates the code in micro-step pairs during delivery | Tech-lead agent reading the codebase and ADRs; two Claude Code agents on the same diff during delivery |
| Critic Panel | Catches scope creep, design drift, premature abstractions | PM, Designer, Rails, Simplicity critics in parallel |
| QA / Visual Verifier | Confirms the change works in a browser, not just in tests | chrome-devtools MCP screenshots desktop and mobile |
| DevOps Gates | Runs the full test suite, type-check, lint, build, then opens the PR | CI plus auto-reviewer reading the diff |
| Reflection / Kaizen | Captures repeated failures into rule updates and skills | Incident log feeding the rule files and skills.sh |

Solo agents fill one seat and act like the rest don't exist.

## How the team works together

These seats link into actual team behavior through a sequence of formations. Each one produces a specific artifact (pitch doc, file map, screen flow) before delivery starts.

### Pitch and bet (Business Strategist + PM + Tech Lead)

We use [Shape Up](https://basecamp.com/shapeup) pitches as the input format. The PM writes a pitch in `docs/pitches/<slug>.md` covering the Shape Up sections (Problem, Appetite, Solution, Rabbit Holes, No-Gos). Then we run our own betting variant: the bet goes through three lenses (Tech feasibility, Product fit, Design patterns) each producing SIMPLE / MEDIUM / COMPLEX with one-sentence rationale. The PM consolidates - lowest-complexity path with highest-impact outcome. We work in 1-2 week sprints rather than Basecamp's 6-week appetite, so we call this Shape-Up-inspired, not Shape Up itself.

### Slicing and design (PM + Designer + Tech Lead)

The bet gets sliced into vertical AC items, each one shippable end-to-end. Designer sketches the solution shape in Google Stitch; Tech Lead writes a file map and boundary notes flagging where existing patterns must be reused.

### Delivery (Tech Lead pair + Critic Panel)

The Tech Lead splits into a Driver/Navigator pair: one agent writes, the other reviews each micro-step before commit. XP shows up as [test-driven development](/blog/test-driven-development-tdd-in-ruby-step-by-guide-tutorial-bestpractices/) and [refactor-step-tdd](/blog/refactor-step-tdd-three-line-discipline-ruby/) micro-commits. RED test commits before each GREEN feat commit (we verify commit order in CI). Kent Beck's *Tidy First?* rule applies - structural refactor commits land before behavior changes. The critics run after each green test, not at PR time.

### QA gates and shipping (QA + DevOps Gates)

Visual verification happens in a real browser via chrome-devtools MCP - screenshots desktop and mobile, console clean, network clean. CI runs the full test suite, type-check, lint, and build. The auto-reviewer reads the diff against project conventions. WIP=1 is enforced: one slice ships before the next slice starts.

### Reflection (every role)

Every repeated failure becomes a rule update or a new skill published to skills.sh. Next sprint inherits the lesson.

## The cadences we run

The sprint cycle runs the outermost loop - pitch, betting, slicing, design, delivery, QA, wrap-up. Cadence: one to two weeks per shaped bet.

The development cycle runs inside the sprint - Tech Lead pair on a slice, micro-commits ship behind tests, the critic panel runs after every test pass. Cadence: minutes to hours per slice.

Tightest of all, the [Ralph loop](https://ghuntley.com/ralph/) runs a single agent iterating on its own output, retrying the same prompt with a stricter rubric until the diff passes the simplicity critic. Anthropic ships it as a built-in [Claude Code plugin](https://github.com/anthropics/claude-code/blob/main/plugins/ralph-wiggum/README.md). Cadence: seconds to minutes per attempt.

Each cadence nests inside the larger one - sprint scope informs development tickets, and Ralph catches small failures inside development without escalating to a human.

## Tools that make this possible

Claude Code provides the runtime and the rule files in CLAUDE.md and .claude/ that each role pulls from. Google Stitch holds the design-system tokens and screen flows - Designer paints there, coding agents read constraints back from the same canvas. chrome-devtools MCP gives QA actual eyes through screenshots, console logs, and mobile emulation; without it, tests go green on builds that are visibly broken in the browser.

Semantic search through claude-context finds existing patterns before agents reinvent them - Sonnet 4.5 still autocompletes Rails 7 syntax inside our Rails 8 apps until claude-context forces it to read the actual Gemfile first. The skill marketplace at [skills.sh](https://skills.sh/) lets us publish a pattern once (database resets, payment-diff test enforcement) and every project pulls it. CI runs the full test suite, type-check, lint, and build, with an auto-reviewer reading the diff against project conventions before a human ever sees the PR.

## Team mode beats solo mode

Product teams keep failing the same way: one role swallows another's job. On the last fintech rescue we picked up, the PM had written ACs the Rails team had silently dropped two sprints earlier - the Designer's Figma had been reinterpreted by the front-end engineer with nobody flagging the drift, and QA was finding the bugs the team had already shipped. Each handoff lost signal.

Solo agents inherit all of that, compressed into one process. One agent makes the product call, the design call, the code call, and the self-review in a single shot - nobody to disagree, no record of what got skipped.

Team mode splits those decisions across collaborative agents, each holding one job, accountable through a written rule set. A PM agent blocks tickets without acceptance criteria. A simplicity critic stops unrequested abstractions before the diff lands. When two agents disagree, the rule file decides - we don't let the last-run agent win by default.

## Why the rules need to change every sprint

A rigid rule set ships yesterday's bias. Strategy docs get revised when the market signal changes. Rule files change when reflection surfaces a failure the current rules let through. And sprint goals shift mid-sprint when discovery surfaces new evidence about what users actually need.

Standups happen at the agent level: the discovery agent posts what it learned from this week's interviews, the simplicity critic logs which abstractions it blocked, and the customer voice agent surfaces new pain points from fresh transcripts. Decisions get re-opened when evidence demands it.

## Where to start

You don't need every role from day one. Begin with a strategy doc the agent reads at session start, a critic panel that blocks merges, and a reflection log that turns failures into rules. From there, add a designer when the UI starts drifting, a customer-voice capability into the PM agent when feature requests stop matching user pain, and a QA/visual verifier when builds keep going green on broken screens.

Setup eats one sprint of overhead. Rule files need writing, agent definitions need configuring, and the team needs convincing. By sprint two, the rule files write themselves from reflection logs and the overhead drops to about 30 minutes per week.

Cost on a small slice (one AC item, 50-100 lines of diff) runs $4-6 on Sonnet or $20-30 on Opus with prompt caching on, plus 30-45 minutes of wall-clock time when the 4-agent critic panel (PM, Designer, Rails, Simplicity) runs in parallel. Larger bets and Ralph-loop retries push the bill higher, but it's still cheaper than the rework on a vibe-coded PR that ships the wrong feature.

## What to do next

Send us one sentence (which role your solo Claude Code agent keeps skipping - PM, designer, tech lead, QA, or critic panel) plus your repo URL. We'll reply with the actual `.claude/agents/<role>.md` file we run for that seat, plus a one-page note naming the next two seats to staff for your stack. [Reach us at /contact-us/](/contact-us/).

<!-- Reference cadence: capability map (not how-to), 8-row team after squashing PM+BA+CustomerRep into PM, UX Researcher+UI/UX Designer into Designer, Tech Lead+Driver/Navigator into Tech Lead. Shape-Up-inspired pitches + JT 3-lens betting + XP delivery. Why team-mode beats solo-mode is load-bearing thesis. Low-friction CTA (one role -> rule file). -->
