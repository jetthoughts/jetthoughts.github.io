---
title: "When Did a Test Last Fail on Purpose?"
description: "SQLite had to write code to deliberately trigger a bug before its tests could see it. We planted eight defects in our own gates and five walked through."
date: 2026-08-22
draft: false
author: 'JetThoughts Team'
slug: when-did-a-test-last-fail-on-purpose
keywords: 'test coverage, green tests, fault injection, ci gates, technical due diligence, non-technical founder testing'
tags: ['testing', 'quality', 'startup', 'engineering', 'ci']
categories: ['Engineering']
cover_image: "cover.png"
cover_image_alt: 'Obsidian-dark cover reading Eight Planted, Three Caught, with a faceted ruby gem and three chips: SQLite 16 years hidden, 133,874 links skipped, and the rule break it on purpose'
metatags:
  image: cover.png
canonical_url: 'https://jetthoughts.com/blog/when-did-a-test-last-fail-on-purpose/'
related_posts: false
---

SQLite is about as thoroughly tested as software gets. Its test suite is famously larger than the database itself.

It still carried a data-race bug for sixteen years.

Tailscale hit it in production and [wrote up the hunt](https://tailscale.com/blog/sqlite-wal-reset-bug). The detail worth stopping on is not the bug. It is what SQLite's developers had to do to see it: "It could exist that long because it was rare - so rare, the SQLite developers had to add code to deliberately trigger it in their testing environments."

They had to break it on purpose. Until they did, every run was green, and green meant nothing about that bug.

## Green answers a question nobody asked

A passing suite tells you the tests ran. It does not tell you they would have noticed.

Those are different claims, and only one of them is what you actually wanted to know when you asked, but the two arrive in the same green icon and nothing distinguishes them. The gap is invisible from outside the team, and mostly invisible from inside it.

We went looking for ours.

## Eight planted defects, three caught

We took our own checks and injected realistic failures into the codebase one at a time - a broken link, a banned phrase, a wrong figure in published copy - writing down beforehand which check should catch each one.

Three of eight were caught.

Two of the five misses were not gaps in coverage. They were checks reporting green while inspecting almost nothing, which is a worse failure, because a gap at least looks like a gap.

Our internal link checker was skipping **133,874 of the 149,516 links** it claimed to be checking. Production renders internal links as absolute URLs, and the crawler had been configured to drop every `http(s)` address as external. It was checking about a tenth of the site and reporting the rest clean.

Pointing it at the built tree took it to 114,050 links actually checked. It immediately found five real defects that had been sitting there invisibly: two wrong blog slugs, a post whose own canonical URL pointed at a 404, a dead link on a conversion page, and a closing section offering a downloadable ROI calculator - itemising five things inside it, promising "no email required, instant download" - for a spreadsheet that had never existed.

Nobody wrote that last one to deceive anyone. It was a template ending that never got filled in, and every green run since had confirmed the page was fine.

## The one that should worry you most

A second gate, our visual regression suite, was passing because it was comparing screenshots to nothing at all.

Run from a particular working directory, it silently lost its reference images and wrote fresh captures over them instead. Every run went green. It had been green for a while.

Someone finally tested the tester: they injected a red background into the site, confirmed the change reached the built page, and measured the captured image against the baseline. The difference was unambiguous - and the suite reported zero failures.

Three earlier attempts to break it had also come back green, and the person doing it had blamed their own injections. That is the honest shape of this problem. When a gate is broken, the evidence that it is broken looks exactly like evidence that everything is fine.

## What to ask instead

You cannot audit a test suite you cannot read.

You can ask questions whose answers are checkable, and these four are.

**"When did a test last fail on purpose?"** Not a flaky failure - a deliberate one, where someone broke the code to confirm the test noticed. If the answer is "we don't do that", the suite's green has never been tested.

**"Which check would have caught the last bug that reached a customer?"** A good answer names one and explains why it did not. A bad answer is that the bug was unusual. Every shipped bug was unusual; that is why it shipped.

**"What does this check actually look at?"** Ask for a number, not a name. Ours claimed to check links and checked a tenth of them. A test named after the thing it should do is not evidence it does it.

**"What happens when a gate fails - who is allowed to say stop?"** A team where every check ends in approval does not have checks. It has a ritual with a green icon.

## Why this is worth your attention specifically

If you are not technical, "the tests pass" is where the conversation usually ends, because it sounds like a fact and you have no way to interrogate it.

It is a fact. It is just a fact about the tests, not about the software.

The rule we adopted after the eight-defect exercise fits in a sentence, and you can hold a team to it without reading a line of code: **a new test is not finished until someone has broken the thing it guards and watched it fail.** Until that happens, a passing run proves the test executed. Nothing more.

SQLite's developers understood this well enough to write code whose only purpose was to make their own software fail. That is what taking your tests seriously looks like, and it is the opposite of trusting them.

## Sources

- Tailscale, ["Tracking down the 16-year-old WAL-reset SQLite bug"](https://tailscale.com/blog/sqlite-wal-reset-bug) - the sixteen-year lifetime, the `tmstmpvfs` shim built to catch it in production, and the deliberate-trigger quote
- Our own fault-injection run and its numbers are recorded in this repository's engineering log, along with the link-checker misconfiguration and the visual-suite failure described above
