---
title: "Dev Shop Contract: Who Owns the Code?"
description: "Under US copyright law your dev shop owns the code it writes until a signed clause says otherwise. Five clauses to check, plus one command to run first."
date: 2026-07-31
draft: true
author: "JetThoughts Team"
slug: "dev-shop-contract-code-ownership"
keywords: "dev shop contract code ownership, software development contract IP, work for hire developer agreement"
tags: ["startup", "founder", "dev-agency", "code-ownership", "outsourcing"]
categories: ["Startup"]
canonical_url: "https://jetthoughts.com/blog/dev-shop-contract-code-ownership/"
og_title: "Dev Shop Contract: Who Owns the Code?"
og_description: "Under US copyright law your dev shop owns the code it writes until a signed clause says otherwise. Five clauses to check, plus one command to run first."
related_posts: false
---

Under US copyright law, whoever types the code owns it. Paying the invoice does not move that ownership to you, and a surprising number of agency contracts never do it properly either.

Your dev shop contract is the only document that decides who owns the code, and paying every invoice on time does not change what it says. You can have a signed master services agreement and a product your customers open every morning, and still not have the legal right to hand that codebase to a different team next month.

## First, find out whose hands were on the keyboard

Ask your agency for read access to the repository, clone it, and run this in the project folder:

```bash
git log --format='%ae' | sort | uniq -c | sort -rn
```

Each line is an email address and the number of commits behind it. Read the domains. If your contract is signed by Acme Software LLC and half your commits come from three Gmail addresses and a domain you have never heard of, you have found the gap that matters more than any clause.

Agencies subcontract. That is normal and often fine. The problem starts when your contract says the agency assigns you everything it owns, and the agency never got a written assignment from the freelancer in another timezone who wrote your billing module.

The US Copyright Office spells the default out in [Circular 30](https://www.copyright.gov/circs/circ30.pdf): a specially commissioned work is only a "work made for hire" if it falls into one of nine narrow categories *and* both parties signed a written agreement saying so. Software is not one of the nine categories. Absent a signed assignment, the contractor who wrote it keeps the copyright, which the Supreme Court settled back in [CCNV v. Reid](https://supreme.justia.com/cases/federal/us/490/730/) and Congress wrote into [17 U.S.C. §101](https://www.law.cornell.edu/uscode/text/17/101).

One honest caveat about the command. If the agency squashed everything into a single "initial commit" or pushed under one shared bot account, the history tells you nothing about authorship. Say that back to them and ask who the individual contributors were. A team that cannot produce the list is telling you something.

## Clause 1: assignment happens on delivery, not on final payment

Search your contract for the word "assign" and read the tense.

"Contractor shall assign all right, title and interest" is a promise to do a thing later. Somebody still has to sign the paper, and if the relationship ends badly nobody signs anything. "Contractor hereby assigns" moves the copyright the moment the code exists, with no follow-up signature required. One word of difference, and your lawyer will fix it in ten minutes if you point at it.

Then check the trigger. Plenty of MSAs assign ownership "upon completion of the Project" or "upon payment in full," which sounds fair until you try to leave in month seven of a twelve-month build and learn that the definition of completion belongs to the other side. Tie assignment to each accepted milestone instead: three months paid means three months of code is yours, whatever happens in month four.

Before you sign anything, read the [annotated SOW walkthrough in the course](/course/tech-for-non-technical-founders-2026/sow-reading-guide/) - IP assignment is one of the eight clauses agencies count on you skimming.

## Clause 2: everyone who touched it signed something

This is the clause almost nobody has, and it is the one the git log check exists to justify.

You want language that requires the agency to have a written present assignment from every employee, contractor, and subcontractor before that person commits a line to your repository, plus the agency's warranty that it has those agreements on file and will show them to you on request. Ask for the contributor list as an exhibit, updated when people join. If the agency's own lead developer is a contractor rather than an employee, this clause is the only thing standing between you and a person you have never met owning part of your product.

Add a moral-rights waiver if any contributor sits in the EU, Canada, or Australia. Those jurisdictions give authors rights that survive an assignment, and a waiver is one sentence.

## Clause 3: the accounts are in your name, not "available to you"

"Client shall have access to all repositories and cloud infrastructure" reads fine until you notice it only promises a login someone else can revoke, not ownership of the account. What you want is that the GitHub organization, the AWS or Heroku root account, the domain registrar, and the production database all sit under an account your company owns, with the agency added as a member. Write it as a condition of the first invoice, not a nice-to-have.

Skip it and you learn the difference at the worst possible moment, usually the week you decide to leave. That is the mechanic behind the [outsourcing trap](/blog/outsourcing-trap-why-your-product-deserves-better-startup-tutorial/): the damage rarely starts with bad code, it starts with who holds the keys.

## Clause 4: AI-assisted code gets disclosed and warranted

Most agency contracts written before 2023 say nothing about a model writing part of your code, and the copyright rules caught up in 2025. In January of that year the US Copyright Office published Part 2 of its AI report and drew a firm line: material generated by a model without meaningful human authorship is not copyrightable at all, and detailed prompting on its own does not create authorship. [Jones Day's summary](https://www.jonesday.com/en/insights/2025/02/copyrightability-of-ai-outputs-us-copyright-office-analyzes-human-authorship-requirement) is the readable version; the [Copyright Office's own AI page](https://www.copyright.gov/ai/) carries the full reports. Practically, an assignment clause can only transfer rights that exist. If a chunk of your product has no copyright behind it, your competitor can copy that chunk and you have no infringement claim.

So ask for two things in writing. Disclosure of which AI tools the team uses and how output gets reviewed, and a warranty that generated code and every dependency it pulled in are free of third-party license claims. We wrote up the accountability side of this in [AI code has an owner problem](/blog/ai-code-ownership-accountability/), including what investors have started asking during diligence.

## Clause 5: transition assistance with a number on it

A usable transition clause spells out what the last two weeks of the relationship look like: it names hours (say, 40 hours of the departing team's time), a rate, a deadline measured in business days from notice, and a list of deliverables such as repository transfer, credential handover, a written architecture summary, and a recorded walkthrough of anything undocumented. Without a number, "reasonable transition assistance" turns into three unanswered emails while your new team burns its first sprint guessing.

Our own contracts carry a termination clause tied to missed milestones, which is a strange thing for an agency to volunteer until you notice that our average client relationship runs about five years. Writing the exit down early is what keeps the middle honest.

## "But I already signed"

If you already signed a contract that does none of this, you are not stuck, you are negotiating from a different position. The next SOW, the next renewal, the next scope change is an amendment opportunity, and the moment your agency wants something from you is the moment to attach a two-page addendum: present assignment, contributor warranty, account ownership, transition terms. Send it as housekeeping your investors asked for, because that framing is true and it removes the accusation from the conversation.

If they refuse to sign an assignment they claim already exists, you have learned the real answer. The [exit guide](/blog/fire-dev-shop-guide/) covers what to secure and in what order once you get there.

## What their reply tells you

Send the addendum, then watch how they answer it. A team that replies "here is the contributor list, here are the assignment agreements, we will move the GitHub org to your account this week" has done this before. Compare that to "our standard MSA covers all of that" with no clause number attached, which usually means nobody there has read their own paperwork. Pushback specifically on the contributor warranty tends to mean the agency knows it never collected those signatures, and you want that answer now rather than during diligence.

The pre-signature version of this check lives in the [ownership checklist](/course/tech-for-non-technical-founders-2026/ownership-checklist/) - GitHub, cloud, database, domain, one row each, run it before you sign. For the behavioral warning signs that show up long before the contract matters, there is the [eight red flags checklist](/blog/dev-shop-red-flags-checklist/).

## What five clauses will not do for you

None of this makes the code good; ownership is only what you reach for after something has already gone wrong. You can own every line of a codebase that has no tests and no deploy script, and the paperwork will not shorten the rescue by a day. Clauses cost you something too: a startup lawyer bills real hours to redline an agency MSA properly, a few agencies will walk rather than sign a contributor warranty, and the negotiation adds a week or two before anyone writes code.

So keep the trade narrow. Contract work protects your ability to leave and to sell the company later, and that is all it does. Keeping the code healthy is a separate job that needs [someone reviewing the work every week](/blog/code-quality-evaluation-non-technical-founders/), not a paragraph in an MSA.

## Further reading

- [US Copyright Office, Circular 30: Works Made for Hire](https://www.copyright.gov/circs/circ30.pdf)
- [17 U.S.C. §101 - definitions, including "work made for hire"](https://www.law.cornell.edu/uscode/text/17/101)
- [Community for Creative Non-Violence v. Reid, 490 U.S. 730 (1989)](https://supreme.justia.com/cases/federal/us/490/730/)
- [Jones Day: Copyrightability of AI outputs and the human authorship requirement](https://www.jonesday.com/en/insights/2025/02/copyrightability-of-ai-outputs-us-copyright-office-analyzes-human-authorship-requirement)
- [US Copyright Office: Copyright and Artificial Intelligence](https://www.copyright.gov/ai/)
