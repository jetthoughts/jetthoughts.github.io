---
title: "Module 3 Walkthrough: Mia Writes the One-Page Brief"
description: "Follow Mia through Module 3 as she turns ten scored transcripts and prototype vocabulary into a one-page Product Brief, then quality-checks it until an AI contractor prompt can't invent anything she didn't ask for."
date: 2026-07-09
draft: false
slug: module-3-walkthrough-mia
---

> **Module 3 walkthrough · Mia** · [From Idea to First Paying Customer](/course/tech-for-non-technical-founders-2026/)
>
> *Illustrative composite based on patterns from real founder builds, not a single client story. Mia's earlier runs are in the [Module 1](/course/tech-for-non-technical-founders-2026/module-1-walkthrough-mia/) and [Module 2](/course/tech-for-non-technical-founders-2026/module-2-walkthrough-mia/) walkthroughs.*

Mia came out of Module 2 with a BUILD verdict, a one-page validated problem statement, and a sentence three parents had handed her almost verbatim: "a vetted shortlist instead of Googling." She also carried one prototype finding that still stung a little - the fifth test parent scrolling a profile page, looking for a price that wasn't there.

Module 3 was one evening and one lunch break: draft the brief, then try to break it.

---

## [Lesson 3.1: The One-Page Product Brief](/course/tech-for-non-technical-founders-2026/one-page-product-brief-vibe-prd/)

Section 1 took ninety seconds, because the lesson forbids writing it: she copied the problem paragraph from her validated problem statement word for word - parents of kids with learning differences, 8 of 10 with real past spend, the mother who "called eleven places in March," the $600 generic-center mistake.

Section 2 she wrote from memory of her own interviews: a parent at 9:30pm after the kids are asleep, a Facebook group thread in one tab and a search in the other, tired of opening tutor sites that all say "all subjects, all ages." Section 3 came out as one paragraph built on the parents' own words: *a web app where a parent searches by their kid's specific need, gets a short vetted list of tutor profiles - each with parent reviews, credentials, the session rate, and response time - and requests an intro call in one click.* The session rate on the profile was the prototype fail, promoted to a requirement.

The no-go list ran longer than the build paragraph, which the lesson says is the healthy shape: no in-person coordination, no school-district partnerships, no tutor self-signup (she would onboard the first fifteen tutors by hand), no multi-child accounts, one metro area only. When she read the brief aloud to a founder friend and asked what he'd build that wasn't on the list, he said "a chat so parents can message tutors" before she finished the question. Messaging went on the no-go list; the intro call already did that job.

Her Section 4 metric: of the first 20 parents who search, 10 request an intro call within 30 days - counted by the request event, not by signups.

---

## [Lesson 3.2: Quality-check the Brief](/course/tech-for-non-technical-founders-2026/stop-specifying-features-start-outcomes/)

Reading Section 3 out loud the next day, two phrases came out feature-shaped: the search and the tutor profiles - both named things the software has, not things a parent does. The rewrites came straight from the transcripts. *When I search for a math tutor for my 10-year-old with dyslexia, I want to filter by "dyslexia-trained" and see reviews from other parents - not scroll 50 generic math tutors.* And the one the prototype had taught her: *When I open a tutor's profile, I want the session rate next to the reviews, so I can rule out the ones outside my budget before I request a call.*

Then she ran the contractor prompt against the brief. Claude's first answer named an availability-calendar sync, automated tutor matching, and in-app messaging. Messaging was already on her no-go list, but the other two were not - 2+ items outside the list, which the rubric counts as a fail. The gap was hers: Section 3 never said the shortlist was curated by hand in v1. She added the line "the shortlist is assembled manually by us; there is no matching algorithm in v1," put calendar sync on the no-go list (the intro call already covers scheduling), and re-ran the prompt. The second answer stayed inside her scope, and she filed the brief in her Founder OS folder next to the problem statement.

---

## What Mia Walked Away With at the End of Module 3

- **A one-page Product Brief** with Section 1 copied verbatim from her validated problem statement - nothing softened, nothing reworded.
- **An outcome-shaped Section 3** where every line traces back to something a parent actually said in the Module 2 interviews or prototype sessions.
- **A no-go list longer than the build paragraph** - the cheapest scope-control document she will ever write.
- **A passed quality check**: one failed AI contractor run, one fix, one clean run. The fuzziness got caught on paper instead of in a Lovable build.

**Next: [Module 4, where Mia decides who builds TutorMatch - and the brief decides with her](/course/tech-for-non-technical-founders-2026/should-you-hire-2026-decision-tree/).**

---

*Built by [JetThoughts](https://jetthoughts.com) as part of the [From Idea to First Paying Customer](/course/tech-for-non-technical-founders-2026/) free curriculum.*
