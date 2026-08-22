---
title: "Your Dev Shop Says the Code Was Reviewed. By What?"
description: "More than one in five code reviews on GitHub are now done by Copilot. The research says AI reviewers earn their keep - and that the tuning which makes them usable suppresses about a fifth of real vulnerabilities."
date: 2026-08-26
draft: false
author: "Paul Keen"
slug: dev-shop-ai-code-review-what-to-ask
keywords: 'ai code review, dev shop code quality, non-technical founder, vendor due diligence, ai generated code security, outsourced development'
tags: ['ai', 'startup', 'code-review', 'hiring', 'security']
categories: ['Startups']
related_posts: false
---

"It's been reviewed" used to mean a person read it.

That is no longer a safe assumption, and the change happened fast enough that most founders never got told. GitHub published the number in March: Copilot code review usage "has grown 10X, now accounting for more than one in five code reviews on GitHub." If your shop works on GitHub, there is a reasonable chance the reviewer on your last release was software.

This is not an argument that you were cheated. The evidence for AI review is better than most people expect, and I want to put it in front of you before the part that should worry you.

## The case for the machine is stronger than the case against

Uber built an AI reviewer called uReview and published what it does. The system now analyses over 90% of the roughly 65,000 diffs that land at Uber each week, inside a median of four minutes.

The number worth sitting with is the comparison they ran against their own engineers. By Uber's measurement, "only 51% of human-written comments are considered as bugs by the author and addressed in the same changeset." uReview gets "over 65% of its posted comments addressed," and engineers mark 75% of them as useful.

So the machine reviewer, at least at Uber's scale, produces a higher share of comments that a developer looks at and agrees with than the humans do. Anyone selling you the idea that AI review is uniformly sloppy is not reading the same evidence.

A separate benchmark on C# code found language models beating the established scanners at finding real vulnerabilities - an F1 score of 0.797 for GPT-4.1 against 0.546 for Snyk Code, 0.386 for CodeQL and 0.260 for SonarQube. The researchers were careful about what that means, and their caveat matters more than the scores: "their noisier output and imprecise localisation limit their standalone use in safety-critical audits."

That phrase about noisier output is the one that matters, because noise is what everybody built their process around.

## Noise is the problem everyone actually solved for

An AI reviewer that comments on everything gets ignored, then switched off. So every serious deployment does the same thing: it filters. Uber's own write-up describes pruning low-confidence alerts, merging duplicate comments, and automatically suppressing whole categories that historically annoyed developers.

That is sensible engineering. It is also where the risk moved, and a paper accepted to ISSTA 2026 measured it.

Yunpeng Xiong and Ting Zhang at Monash University tested three agent frameworks against the OWASP Benchmark and real Java vulnerabilities. The filtering works: an initial false-positive rate above 92% fell to as low as 6.3% in the best configuration. Then they checked what went missing along with the noise. Their third stated lesson is blunt enough to quote whole:

> Aggressive FP suppression risks hiding real vulnerabilities and should not be fully automated.

The measurement behind it: even the best-performing configuration "incorrectly suppresses 22.25% of real vulnerabilities." Roughly one in five genuine findings, quietly reclassified as noise.

It gets worse in a specific place. The miss rate is close to nothing for the injection-style bugs everyone knows about, and it "exceeds 50% for cryptography- and policy-related categories." Weak encryption. Weak password hashing. Trust boundaries. The failures a founder would care most about are the ones the filter is worst at keeping.

## Why this lands harder on AI-written code

There is a second piece that makes the overlap uncomfortable.

A study at ISSRE 2025 compared more than 500,000 code samples, human-written against output from ChatGPT, DeepSeek-Coder and Qwen-Coder. Machine code and human code turn out to fail in different directions. AI-generated code is "generally simpler and more repetitive," while human-written code "exhibits greater structural complexity and a higher concentration of maintainability issues."

And then: "AI-generated code also contains more high-risk security vulnerabilities."

Put the two results next to each other. AI writes code that carries more high-risk security problems. AI review is weakest at exactly the security categories where suppression is worst. If your shop uses AI to write and AI to review, the gap in the reviewer lines up with the weakness in the writer.

Nobody designed that. It is just where two reasonable decisions happen to meet.

## Four things you can check without reading code

None of these require you to evaluate a line of anything. They are artifacts - either they exist or they do not, and asking for them tells you something either way.

| Ask for | What a good answer looks like | What it tells you |
|---|---|---|
| The review configuration | They can show you which categories are suppressed, and who decided | Somebody chose the filter deliberately instead of accepting a default |
| A recent review with comments | Real comments, some disagreed with, some acted on | Reviews are read rather than rubber-stamped |
| The security scan, separately | A named tool, run on a schedule, with its own output | Security is not delegated to the same filter that optimises for quiet |
| Who signs off | A person's name, and what they check that the tool does not | Accountability did not evaporate into the pipeline |

The third row is the one I would not compromise on. The research points the same direction from both ends: run something deterministic for the security categories, and do not let the tool that was tuned for developer patience be the only thing standing between you and a weak hashing bug.

## What this does not tell you

The suppression study is Java, against a benchmark and one real-world dataset. The scanner comparison is C#. Neither is Rails, or Python, or whatever your product is built in, and a number measured on one stack does not transfer to another just because it is inconvenient to re-measure.

The headline numbers also look like they disagree. An industry study at Tencent found hybrid static-analysis-plus-LLM methods eliminating 94-98% of false positives "while maintaining high recall," which sounds like the suppression problem solved.

Read to the end of that paper and it lands somewhere else: "recall remains below the enterprise-expected threshold of 90%, indicating that some degree of manual review is still necessary to guarantee absolute safety." Two research teams, different continents, opposite-looking headlines, same conclusion. Do not run this unattended.

That convergence is worth more than either number. The filter is a decision, somebody made it, and you are allowed to ask what it was.

## The question for your next status call

Not "was the code reviewed." You will get a yes, and it will be true, and it will not mean what you wanted it to mean.

Ask what the review was configured to ignore, and who decided that. A shop that has thought about this will have an answer ready and will be glad you asked. A shop that has not will tell you the tool handles it.

If you want a second opinion on what you have been shipped, that is [what a rescue context call is for](/services/vibe-code-rescue/). And if the answers you get make you want to leave, [there is a way to do that without losing the codebase](/blog/switch-dev-shops-safely-transition-guide/).

## Sources

- GitHub, [60 million Copilot code reviews and counting](https://github.blog/ai-and-ml/github-copilot/60-million-copilot-code-reviews-and-counting/), 5 March 2026.
- Uber Engineering, [uReview: Scalable, Trustworthy GenAI for Code Review at Uber](https://www.uber.com/us/en/blog/ureview/).
- Yunpeng Xiong and Ting Zhang, [Sifting the Noise: A Comparative Study of LLM Agents in Vulnerability False Positive Filtering](https://arxiv.org/abs/2601.22952), Proc. ACM Softw. Eng. (ISSTA 2026).
- [Large Language Models Versus Static Code Analysis Tools: A Systematic Benchmark for Vulnerability Detection](https://arxiv.org/abs/2508.04448), arXiv 2508.04448.
- Domenico Cotroneo, Cristina Improta and Pietro Liguori, [Human-Written vs. AI-Generated Code: A Large-Scale Study of Defects, Vulnerabilities, and Complexity](https://arxiv.org/abs/2508.21634), IEEE ISSRE 2025.
- Xueying Du et al., [Reducing False Positives in Static Bug Detection with LLMs: An Empirical Study in Industry](https://arxiv.org/abs/2601.18844), arXiv 2601.18844.
