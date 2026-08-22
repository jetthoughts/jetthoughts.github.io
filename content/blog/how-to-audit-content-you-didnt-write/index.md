---
title: "How to Audit Content You Didn't Write"
description: "Someone spent $900,000 publishing fake research so chatbots would repeat it. The same economics apply to the blog your agency built. Four checks you can run."
date: 2026-08-22
draft: false
author: "Paul Keen"
slug: how-to-audit-content-you-didnt-write
keywords: 'content audit, ai generated content, fabricated case studies, blog credibility, agency content review, non-technical founder'
tags: ['content', 'ai', 'startup', 'marketing', 'trust']
categories: ['Engineering']
cover_image: "cover.png"
cover_image_alt: 'Obsidian-dark cover reading $900,000 Of Fake Research, with a faceted ruby gem and three chips: Pew 1 in 10 .com pages, the tell is an unnamed client, start with your top 10 by traffic'
metatags:
  image: cover.png
canonical_url: 'https://jetthoughts.com/blog/how-to-audit-content-you-didnt-write/'
related_posts: false
---

The Hanover Institute for Public Policy published more than a hundred research reports, complete with footnotes, tables of contents, and the flat neutral register that policy writing has.

It does not exist.

[Responsible Statecraft traced it](https://responsiblestatecraft.org/israel-influence-chatgpt/) to Piro, Inc., and Politico found the Department of Justice filing showing $900,000 of Israeli government funding behind it. GPTZero flagged eleven of twelve sampled articles as machine-written.

The interesting part is who the reports were written for. Piro's founder said it on LinkedIn: "When someone asks ChatGPT, Gemini, or Perplexity about your category, an answer comes back in one confident paragraph... we spent months reverse-engineering it."

Those reports were never aimed at readers. Their audience was the machine that answers readers, and the reports were shaped to be the thing it repeats.

## Your blog runs on the same economics

Nobody spent $900,000 on your content.

That is the point. They did not have to, and neither did whoever produced yours, because manufacturing text that reads like expertise stopped being expensive somewhere around the middle of 2023.

Ask what your blog archive actually is. An agency wrote some of it, on a monthly retainer measured in posts, and a freelancer wrote more.

Then a tool started drafting, and the person approving its output was not equipped to check the technical claims inside it. Nobody in that chain was lying. Each link did the job it was paid for, and the job was volume.

## Nobody can tell you how much of the web this is

You would think there is a number. There are several and they disagree.

[Graphite](https://graphite.io/five-percent/more-articles-are-now-created-by-ai-than-humans) sampled 43,000 CommonCrawl URLs published between January 2020 and May 2025, ran them through Surfer's detector, and put the crossover - more machine-written articles than human ones - in November 2024.

[Pew](https://www.pewresearch.org/data-labs/2026/08/20/how-much-of-the-internet-is-written-with-ai/) ran roughly 490,000 English-language pages from the same archive through Open Pangram this month and found 10% of all sampled pages showing significant signs of AI authorship - rising to over a third when you look only at pages published after ChatGPT shipped.

Ten percent, a third, or half. The numbers are not contradicting each other so much as answering different questions, on different samples, with different detectors.

Both teams publish their error bars, and that habit is worth stealing regardless of what you make of their numbers. Graphite reports a 4.2% false-positive rate against GPT-4o content and no measurement at all of AI-assisted-then-human-edited writing. Pew says plainly that "AI detection models aren't perfect" on individual documents and only hold up in aggregate.

One more number from Pew is the one that should interest you: **around one in ten `.com` pages carry those signals - roughly double the `.org` rate and ten times what `.edu` and `.gov` show.** Commercial sites are where this concentrates, and yours is a commercial site.

So the honest position is that the web's average is unknown and the detectors that estimate it are themselves approximate. Which is fine, because the average was never the thing you needed. **You need to know about your property, and your property is countable.**

## Four checks, and the commands that run them

Run them in this order. I have ranked them by what each one costs you to skip, not by how quick it is.

The commands assume a Hugo or Jekyll-shaped repo where posts are markdown files. Adapt the paths; the shapes they look for are the same everywhere. If you do not have repo access, these are exactly the four things to ask whoever does.

**1. Rank by who reads it, not by how bad it looks.**

Export your top pages from Search Console, then work down that list and nothing else.

The instinct is to start with whatever reads worst. Resist it - the page that makes you wince and the page that gets read are rarely the same one, and a `featured` flag in your site config tells you what someone decided once, not what anyone has done since.

Impressions are what readers actually did.

```bash
# Export "Pages" from Search Console as CSV, then rank what you actually have:
sort -t, -k2 -rn pages.csv | head -20
```

A false claim on a page nobody opens is a liability. On a page that ranks, it is the first thing a prospect reads.

**2. Search for the shape of invented work, not the words.**

A fabricated case study is written in ordinary vocabulary, so no word list catches it.

Its structure gives it away: a heading saying "Case Study", followed by a company that is never named. "A mid-sized content platform." "An anonymous HR tech SaaS with 15,000 customers." Precise numbers attached to a subject nobody can look up.

That shape is greppable:

```bash
# every case-study heading in the archive
grep -rniE '^#{2,4} .*case stud' content/ 

# the anonymous-subject tell, right after one
grep -rniE 'a (mid-siz|medium-siz|large)|\(anonymous' content/
```

Run the first one and read every hit. Real client work names the client or does not get published, and you can apply that test without understanding a word of the subject matter.

**3. Ask whether a claim can be checked at all.**

Count how many of your long posts link to nothing outside your own domain.

A post with no external citation is not necessarily wrong. It is unverifiable, which means nobody could have checked it - including whoever wrote it, at the moment they wrote it. That is the distinction I care about, and it is the one this count actually measures.

Uncheckable is where wrong survives, and the number usually comes back higher than anyone guesses.

Count yours:

```bash
# posts over 400 words carrying zero outbound links to anywhere but your own domain
for f in content/blog/**/index.md; do
  words=$(wc -w < "$f")
  links=$(grep -oE '\]\(https?://[^)]+\)' "$f" | grep -vc 'yourdomain.com')
  [ "$words" -gt 400 ] && [ "$links" -eq 0 ] && echo "$words words, 0 sources: $f"
done
```

A post making technical claims with zero citations is not a red flag about that post's accuracy so much as a flag that accuracy was never tested.

**4. Check whether the advice has expired.**

Any post with a version number in the title has a shelf life its author never wrote down.

A migration guide that recommends Laravel 11 today is sending readers onto a release whose security support ended in March 2026. Nothing in that guide has to be invented for it to do damage.

It was true when written, and became harmful without a word of it changing.

```bash
# every post whose title names a version - each one has an expiry date
grep -rlE '^title:.*[0-9]+(\.[0-9]+)?' content/blog/ | head -30
```

Then check each against the vendor's own support table. Laravel, Rails and Node all publish one; it takes two minutes and it is the only way this class of defect surfaces.

## What a check like this cannot do

It cannot tell you whether a claim is true.

We tried to build that and failed honestly. Two candidate patterns for detecting wrong technical claims got measured against the archive before we trusted either: one matched ten passages, mostly legitimate; the other matched a hundred and eighty-five, almost all ordinary prose. Both would have cried wolf until people stopped reading the output.

A wrong explanation is a well-formed sentence using correct vocabulary, pointing roughly the right direction. There is no pattern for it. What catches it is someone who knows the subject, reading with permission to disagree - which is a different investment, and the one worth making after the four checks above have narrowed where to look.

## Where to start this week

Open your search console. Take your top ten pages by impressions. For each one, ask: does it name a client, does it cite a source, and does it mention a version number.

That is an afternoon, and it tells you whether you have a problem worth spending more on.

If the answer is yes on several, the fix is not a rewrite of everything. It is the same order as the checks: highest-traffic first, fabrications before staleness, and a rule that whatever replaces a bad claim needs its own source. That last one matters more than it sounds - a correction is a new claim, and it tends to get less scrutiny than the thing it replaced.

## Sources

- Nick Cleveland-Stout, ["Israel creates fake think tank in likely attempt to dupe AI chatbots"](https://responsiblestatecraft.org/israel-influence-chatgpt/), Responsible Statecraft, 2026-08-17 - the Hanover Institute, the Piro, Inc. attribution, the $900,000 DOJ filing, and the GPTZero result
- Graphite, ["More articles are now created by AI than humans"](https://graphite.io/five-percent/more-articles-are-now-created-by-ai-than-humans) - 43,000 CommonCrawl URLs, January 2020 to May 2025, Surfer detector, with the authors' own 4.2% false-positive rate
- Pew Research Center, ["How Much of the Internet Is Written With AI?"](https://www.pewresearch.org/data-labs/2026/08/20/how-much-of-the-internet-is-written-with-ai/), 2026-08-20 - ~490,000 English-language Common Crawl pages, January 2021 to July 2026, Open Pangram, including the per-domain breakdown and the authors' caveat on per-document accuracy
