---
title: 'How We Run Claude Code Agents Like an XP Team: From Idea to Production'
description: 'Solo Claude Code agents ship vibe-coded code that crashes on real users. Here is the XP-team setup we use - rules, rhythms, critic agents, gates, reflection.'
date: 2026-05-04
draft: false
author: 'JetThoughts Team'
slug: claude-code-xp-team-workflow
keywords: 'claude code agents, ai code agents production, multi-agent workflow, xp team ai, claude code workflow, ai agents code review'
tags: ['ai', 'claude-code', 'xp', 'productivity', 'startup', 'engineering']
categories: ['Engineering']
cover_image: cover.png
metatags:
  image: cover.png
  og_title: 'How We Run Claude Code Agents Like an XP Team: From Idea to Production'
  og_description: 'Solo Claude Code agents ship vibe-coded code that crashes on real users. Here is the XP-team setup we use - rules, rhythms, critic agents, gates, reflection.'
cover_image_alt: 'Diagram of a Claude Code agent pipeline for a Rails app: rules, rhythms, parallel critic agents and gates, reflection - styled as an XP team standup board.'
canonical_url: 'https://jetthoughts.com/blog/claude-code-xp-team-workflow/'
related_posts: false
---

[Veracode tested a wide field of LLMs](https://www.veracode.com/blog/genai-code-security-report/) on real coding tasks. **45% of the generated code shipped with at least one exploitable security flaw** - SQL injection, broken crypto, the kind of thing a code review catches. A solo Claude Code agent produces the same artifact. We wrap each agent in an [XP team](https://www.extremeprogramming.org/) before it ships code. We covered the founder pain in [Vibe Coding Crisis](/blog/vibe-coding-crisis-ai-code-debt/).

![Five-step Claude Code XP-team pipeline for shipping product code: rules, rhythms, critics, gates, reflection looping back to rules](pipeline.svg)

## What the agent reads at session start

A solo agent has no idea which patterns already live in your codebase, which library version is installed, or which abstractions your team rejected last quarter, so it reinvents what already exists.

A small set of mandatory rules sits in `CLAUDE.md` and additional rule files we keep alongside agent definitions in `.claude/`. They answer the questions a second engineer would catch: search for existing code before implementing, prefer the simplest solution that already works, refactor before adding behavior, test what changes versus what the framework already covers, never extract an abstraction until duplication appears three times.

Without these, the agent ships a fifty-line method when a ten-line helper already exists three folders away.

## Three checks before any commit

Agents without rhythm produce 200-line afternoons that break tests in unrelated places.

Research first uses semantic search across the repo plus a library-docs lookup at the installed version - stale training data still produces Rails 7 patterns inside a Rails 8 app. [Tidy first](/blog/refactor-step-tdd-three-line-discipline-ruby/) reads the surrounding code and refactors messy structure as a separate commit, before any behavior change lands.

4-eyes pairs the change: a Driver agent writes, a Navigator agent reviews, both approve before commit. Same-model agents share blind spots - the Navigator catches typos and missed cases, not architectural drift. Each micro-step ends with a fast targeted [test](/blog/test-driven-development-tdd-in-ruby-step-by-guide-tutorial-bestpractices/). When the bar goes red, we throw the diff away and start the micro-step over - debugging takes longer than rewriting.

## Critic agents, then mechanical checks

Tests passing only proves we didn't break what we already had specs for. Real review catches scope creep, design drift, premature abstractions, and conventions the test suite cannot see.

After tests pass, a panel of critic agents reads the diff in parallel: PM confirms the change matches the acceptance criteria, Designer verifies the UI follows the design system, Rails checks code quality and conventions, simplicity blocks any extraction the change did not request.

When critics disagree, the change goes back. When they approve, mechanical gates fire automatically - the full test suite, browser screenshots on desktop and mobile, an auto-reviewer reading the diff against project conventions.

Running this pipeline costs roughly $4-6 per ticket on Sonnet, $20-30 on Opus, plus 45 minutes of wall-clock time when the four critics run in parallel. Cheaper than the rework cycle on a vibe-coded PR.

The pipeline ends at PR-merge. Staging deploys, canary rollout, and SLO checks live in the CI/CD layer below this and run regardless of whether the PR was authored by an agent or a human - the panel doesn't replace those gates, it just makes sure agent diffs reach them clean.

## When something breaks, write it down

Without reflection, the same failure ships every sprint. The agent has no memory across sessions; the team does, but only if the team writes it down.

Repeated issues become incident records. Each one captures root cause, classifies the gap (test, rule, process, knowledge), and names the rule update or skill that prevents the next occurrence.

Recent examples: on a marketplace rescue last quarter the agent skipped a test before changing a payment calculator, so we added a pre-commit check that blocks any payment-related diff without a new test. Two weeks later, fixture data leaked between tests on the same project, so we extracted a skill that resets the database between scenarios.

## What one ticket looks like

A checkbox in the candidate list to mark someone shortlisted: that's a recent change. The sprint runner opens with research - semantic search finds an existing `favorites` join table the agent reuses instead of inventing a new model. Driver writes the controller action in 6 lines; Navigator catches that the existing pattern uses a service object and asks for a refactor.

Tidy-first runs, the controller drops to 3 lines, tests stay green. Three of the four critics approve quickly. The simplicity critic blocks an unrequested `ShortlistService` extraction the agent suggested - the change didn't ask for it, the existing controller pattern carries the load. Round trip back to the agent, extract removed, panel re-runs and approves.

Four hours of agent time, thirty-five minutes of human time across the day. The full test suite passes; browser screenshots confirm the toggle works on mobile; the auto-reviewer opens the PR.

## Start small

You don't need the full setup from day one. Begin with three rules - research before any change, [test behavior not framework](/blog/tdd-overkill-myth-lightweight-ruby/), refactor before adding. This setup costs the first sprint - rules need writing, agents need configuring, the team needs convincing. From sprint two onward, the time disappears.

Add the critic panel after a sprint of pain; you will know which checks you need by what slipped through. Add specialized agents only once the rules are stable enough that you trust the agent to follow them.

## Free audit

If a Claude Code agent is shipping code for you and something is leaking, we run a free 45-minute audit. Send the repo URL plus a paragraph on what is breaking, and within two business days you get back a one-page assessment naming the three changes that pay back fastest. [Book the audit at /contact-us/](/contact-us/).

<!-- Reference cadence: direct technical-strategy register, no founder-anecdote hook, no bold-header lists, why/what/how integrated as flowing prose, paragraphs capped at 3 sentences. -->
