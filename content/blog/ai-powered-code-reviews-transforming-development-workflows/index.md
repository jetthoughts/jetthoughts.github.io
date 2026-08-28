---
title: "Your AI Reviewer Approved It. Did It Read Its Own Report?"
description: "We built a code reviewer out of AI agents. One of them found a SQL injection, listed it, and wrote approve directly above it. Here is why that happens and what to ask your team about it."
created_at: '2025-01-16T00:00:00Z'
edited_at: '2026-08-28T00:00:00Z'
date: 2025-01-16
draft: false
tags: ["ai", "code-review", "startup", "engineering", "automation"]
canonical_url: https://jetthoughts.com/blog/ai-powered-code-reviews-transforming-development-workflows/
aliases:
  - /blog/ai-powered-code-reviews-transforming-development-workflows-2025/
metatags:
slug: ai-powered-code-reviews-transforming-development-workflows
---

We built a code reviewer out of AI agents. Three specialists look at a change, one for security, one for performance, one for style, and a fourth model merges what they found into a single review.

It found a SQL injection. It listed the SQL injection. Then it wrote **approve** on the line directly above.

Not a hallucination, and not a model having a bad day. The same response contained both the finding and the verdict contradicting it. That is worth your attention if anybody has ever told you the AI reviewed it, because the sentence you were given was the verdict, and the verdict is the part that was wrong.

## Reporting and judging are different jobs

The model was good at the first one. It read a diff it had never seen, found a real injection, and described it accurately. As a reporter it did the work.

Then we asked the same model, in the same breath, to summarise its own findings into a decision. That is a different task. It is not looking for problems any more; it is producing a tidy summary, and "approve" is the tidiest summary there is.

![Diagram contrasting two designs: asking the model for a verdict, where it reports a SQL injection and then approves it in the same response, against computing the verdict in code, where any specialist reporting a finding forces request-changes](reporter-not-judge.svg)

The fix was not a better prompt. We deleted the field.

The specialists still report findings. The synthesiser still merges them into a readable list. But it is no longer asked what the findings mean, because a field that is unreliable and that something depends on is worse than no field at all. The verdict is now five lines of ordinary code counting reports:

```ruby
# The gate is deterministic Ruby over reported findings, not model
# self-assessment: a free model will happily write "approve" above
# the injection it just found.
def headline
  blocking = @reviews.values.count { |review| Array(review['findings']).any? }
  return '**Verdict:** approve' if blocking.zero?

  "**Verdict:** request changes - #{blocking} of #{@reviews.size} specialists reported findings"
end
```

That is the whole gate. If any specialist reported anything, changes are requested. No model gets a vote on whether its own findings matter.

## Why this is not a Ruby problem

Nothing above depends on the language. The shape is: a model produced structured output, and a human asked the same model to interpret it.

Anywhere that shape exists, the same failure is available. A model that summarises a security scan can call it clean. A model that grades its own output can pass it. A model asked whether a task is finished will usually say yes, because finished is the shape of a good answer.

The general rule we now work by: **anything that gates a decision belongs in code that reads the model's output, never in the model's summary of it.** Models are worth trusting as instruments. The thing that decides what an instrument's reading means is not itself an instrument.

## Four questions for whoever runs your reviews

None of these needs you to read code.

| Ask them | What a good answer sounds like |
|---|---|
| When the AI approves a change, what actually decided that? | A rule they can state. **"The model said it looked fine" is the failure above.** |
| Can I see a review where it found something and the change was blocked? | A real one, with the finding and the block. **If every review approves, nothing is gating.** |
| What happens if the AI reports a problem and the author disagrees? | A person decides, by name. **"We take the AI's summary" means nobody does.** |
| Is the security check the same tool as the review? | Ideally not. **One tool tuned to be quiet should not be the only thing looking for the expensive bugs.** |

A team that answers these well is doing something real. A team whose answer is that the AI approves things is describing the exact defect we hit, and we hit it in code we wrote deliberately, with the failure in front of us.

## What we are not claiming

We have not measured how often this happens. It happened in our own example workflow, we could reproduce it, and we changed the design so it cannot happen again. That is one team's finding, not a rate.

We also are not claiming AI review is bad. Ours found the injection. The reporting worked, which is precisely why the verdict being wrong is worth knowing about: the useful part and the unreliable part arrive in the same message, and the unreliable part is the one that reads like a decision.

If you want the details, the workflow is public: [`examples/code_review/workflow.rb`](https://github.com/jetthoughts/ruby_llm-team/blob/main/examples/code_review/workflow.rb) in [`jetthoughts/ruby_llm-team`](https://github.com/jetthoughts/ruby_llm-team), including the comment we left ourselves about what a free model will happily approve.

We have written separately about [what to ask when a dev shop says the code was reviewed](/blog/dev-shop-ai-code-review-what-to-ask/), which covers the research on what automated reviewers miss and why the tuning that makes them tolerable is the same tuning that makes them quiet.

## Sources

- [`jetthoughts/ruby_llm-team`](https://github.com/jetthoughts/ruby_llm-team), `examples/code_review/workflow.rb` - the workflow described above, including the deterministic verdict and the comment explaining why it exists.
- GitHub Blog, [How AI is transforming code review at GitHub](https://github.blog/ai-and-ml/github-copilot/how-ai-is-transforming-code-review-at-github/) - GitHub's own account of Copilot review adoption.
- C. Bird et al., [Expectations, Outcomes, and Challenges of Modern Code Review](https://www.microsoft.com/en-us/research/publication/expectations-outcomes-and-challenges-of-modern-code-review/), IEEE Software, 2016 - what human code review actually catches, which is the baseline any automated reviewer is measured against.
