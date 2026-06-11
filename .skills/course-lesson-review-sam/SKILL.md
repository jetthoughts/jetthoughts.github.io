---
name: course-lesson-review-sam
description: Run a Sam-perspective customer-research review on a draft course lesson. Use this skill whenever the user asks to review a lesson from Sam's perspective, check a lesson for ICP fit, validate that a lesson works for non-technical founders, or mentions `/course-lesson-review-sam`. Triggers on phrases like "Sam review", "review this lesson", "check this for Sam", "ICP review", "customer lens review", or any request to validate a course lesson against the target audience.
---

# Course Lesson Sam-Review

Run a Sam-perspective customer-research review on a draft lesson. Channels Sam beat-by-beat with verbatim reactions, friction points, glossing gaps.

## Pre-loaded context

Sam profile (from `docs/projects/2605-tech-for-non-technical-founders/40-49-review/40.06-sam-customer-journey-report-2026-06.md`). The corrected newbie one:

| Attribute | Detail |
|---|---|
| **Role** | Founder & CEO, B2B SaaS |
| **Age** | 38 |
| **Tech literacy** | Can read a Stripe invoice, cannot read a GitHub commit |
| **Burn history** | NONE — this is Sam's FIRST venture. No prior devshop experience. |
| **PM background** | NONE — never worked in product management |
| **Current state** | Has runway, has an idea, has NOT validated anything yet |
| **Emotional load** | Intimidation ("everyone seems to know things I don't"), first-timer enthusiasm ("this course will finally make it clear"), fear ("what if I pick wrong?") |
| **Reading mode** | Skim-first, time-poor. Reads H2 headings on phone during commute before committing. Wants specific numbers, not vague promises. |
| **Trust trigger** | "This person knows I'm coming in cold and doesn't judge me for it." |
| **Trust killer** | Jargon without explanation. Too many choices. Being told to "figure it out." |

## The 6 tests

Run all 6 tests on the draft lesson. For each test, produce:
- A verdict (PASS / PARTIAL / FAIL)
- The specific line or section that triggered the verdict
- A Sam-character verbatim reaction (how Sam would actually react in his head)
- A priority fix (HIGH / MEDIUM / LOW)

### Test 1: 3-second hook test

Can Sam tell what this lesson does and why he should care within the first 2 sentences?

- Read the hook (first 1-3 sentences after the course-frame callout)
- If the hook is a narrative vignette longer than 3 sentences, it FAILS
- If the hook uses "we" language without naming Sam's pain, it FAILS
- If Sam can't picture what tangible thing he'll walk away with after reading the hook, it FAILS

Sam's likely reaction to a bad hook: opens lesson, scrolls past 4 paragraphs, thinks "I don't know what this is for," closes tab.

### Test 2: Glossing audit

Every term Sam doesn't know — decoded at first mention?

Scan the entire lesson body. Flag every technical term and check:
- Is it glossed at first mention with a one-sentence plain-English definition?
- Is the gloss in parentheses right next to the term, not in a footnote or sidebar?
- Filter for: MVP, PMF, ICP, CTA, DPA, ARR, MRR, SOC2, HIPAA, API, RLS, JWT, OAuth, SDK, CI/CD, CMS, DNS, SSL, JSON, CSV, HTML, CSS, JS, SQL, CRUD, REST, GraphQL, webhook, endpoint, deploy, staging, production, migration, ORM, framework, runtime, SDK, hero section, incognito mode, headless CMS, CDN, reverse proxy

For each unglossed term, Sam's reaction: "I keep nodding but I don't know what half of these mean."

### Test 3: Progressive disclosure

First 30% orients Sam; thresholds/metrics arrive only when Sam acts on them.

- Does the first 30% of the lesson body (after the course-frame callout, before the "Do this now") ONLY orient Sam?
- Do thresholds, decision numbers, scoring rubrics appear only in or after the action section?
- If a scoring table or decision threshold appears in the first 30%, it FAILS

Sam's reaction to bad progressive disclosure: "There's a 40% threshold and a 7/10 score and a $300 budget and I haven't even been told what I'm building yet."

### Test 4: Tool-paralysis check

Single golden path or named alternatives?

- Does the lesson recommend ONE primary tool with exactly ONE named fallback?
- If there's a comparison table with 4+ options, it FAILS
- If Sam has to make a tool choice before the action steps, it FAILS

Sam's reaction to tool paralysis: "Mixo vs Carrd vs Lovable vs Framer — which one? What if I pick wrong? I'll come back to this later." (Never comes back.)

### Test 5: Confidence-to-act check

Sam knows what to do next with no remaining ambiguity?

- After reading the entire lesson, can Sam name the next step without re-reading?
- Is there an observable success check?
- Is there a concrete "If blocked" escape valve?
- If any of these three is missing or vague, it FAILS

Sam's reaction to ambiguity: "OK... I think I'm supposed to build something? With what? How do I know if it worked?"

### Test 6: Off-ICP drift check

Any sentence that reads as written for a developer, PM, or scarred founder?

Scan every sentence and ask:
- Would a first-time founder who's never hired a devshop understand this?
- Would someone with zero PM background follow this?
- Does any sentence assume the reader has been burned before?
- Does any sentence use "your devshop" or "your last agency" or "the team you fired"?

For each sentence that fails, Sam's reaction: "This is written for someone who's been through this before. I haven't."

## Output format

Always produce this exact output structure:

```
## Sam Review — [Lesson Slug]

### Overall: [PASS / PARTIAL / FAIL] ([N]/6 tests passed)

### Beat-by-beat

| # | Test | Verdict | What triggered it | Sam's reaction | Fix priority |
|---|---|---|---|---|---|
| 1 | 3-second hook | PASS/FAIL | "exact quote from lesson" | "Sam's verbatim reaction" | HIGH/MED/LOW |
| ... | ... | ... | ... | ... | ... |

### Priority fix list

1. **[HIGH/MED/LOW]** [specific fix instruction]
2. ...

### Verbatim Sam quotes

- "[what Sam would actually say to a friend about this lesson if it were a draft]"
```

## What NOT to do

- Do NOT critique the lesson as a technical reviewer — ONLY channel Sam
- Do NOT suggest structural rewrites that serve SEO or "best practices" — Sam doesn't care about those
- Do NOT use "the learner would benefit from" language — say "Sam wouldn't understand this"
- Do NOT grade on word count alone — a 700-word lesson that passes all 6 tests is fine for Sam
