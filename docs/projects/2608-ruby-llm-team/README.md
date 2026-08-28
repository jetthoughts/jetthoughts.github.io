---
type: Reference
title: ruby_llm-team — source material for posts
description: First-hand engineering findings from building a Ruby multi-agent library, written so the blog pipeline can source posts without inventing anything.
tags: [ruby, ai, agents, engineering, source-material]
status: stable
generated:
  by: claude/sonnet-5
  at: 2026-08-28T00:00:00Z
timestamp: 2026-08-28T00:00:00Z
sources:
  - id: repo
    resource: https://github.com/jetthoughts/ruby_llm-team
    title: jetthoughts/ruby_llm-team — the library these findings come from
  - id: master
    resource: https://github.com/jetthoughts/ruby_llm-team/commit/cbdfbc2
    title: master at the time of writing
---

# What this is

JetThoughts built [`ruby_llm-team`][^repo], a small Ruby library for coordinating several
RubyLLM agents through one auditable run. Building it produced a set of findings that are
worth publishing: most were **measured, not reasoned about**, and several contradict what the
same team believed a day earlier.

This folder exists so [`blog-next`](../../workflows/blog-pipeline.md) can pick topics from real
work rather than from a keyword tool. Every entry in [`findings.md`](findings.md) carries the
file or commit that proves it, so the fabrication ratchet has something to check against.

## Why this material is unusually publishable

Three properties that most "we built a thing" posts lack:

1. **Reproduced, not asserted.** Each bug below was demonstrated with a runnable script before
   it was fixed — the recursion depth, the forged handoff, the concurrency count are measured
   numbers, not estimates.
2. **Self-correcting.** Several entries record the team being wrong: a security guard that did
   not cover the path every example used, documentation that described a method already
   deleted, a justification falsifiable by one grep in its own repository.
3. **Transferable.** Almost none of it is Ruby-specific. The failure modes apply to anyone
   wiring LLM agents together in any language.

## Constraints for anything published from here

- **Claim only what a file proves.** Every finding names the path or commit. If a draft makes
  a claim this folder does not support, cut the claim rather than soften it.
- **The library is unpublished at the time of writing.** Do not describe it as available on
  RubyGems until that is true, and do not imply adoption, downloads, or users. There are none.
- **No invented incidents.** These findings came from building a library, not from a client
  outage. Keep the setting honest — a reader who checks will find a public repository, and
  that is the strongest asset here.
- **Attribute the AI-assisted work honestly** if a post discusses process; the repository
  history shows it plainly.

## Suggested reading order for a writer

Start with the two findings that need no Ruby to understand: the **forged handoff** and the
**model that approved its own SQL injection**. Both are about trust boundaries between agents,
which is the general lesson under all of this.
