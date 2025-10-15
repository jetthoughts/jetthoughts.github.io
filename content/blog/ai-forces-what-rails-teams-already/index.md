---
remote_url: https://dev.to/jetthoughts/ai-forces-what-rails-teams-already-knew-small-teams-ship-faster-3k3g
source: dev_to
remote_id: 2885479
dev_to_id: 2885479
dev_to_url: https://dev.to/jetthoughts/ai-forces-what-rails-teams-already-knew-small-teams-ship-faster-3k3g
title: 'AI Forces What Rails Teams Already Knew: Small Teams Ship Faster'
description: I found this discussion last week and it crystallized something that's been percolating in the...
created_at: '2025-10-02T15:05:46Z'
draft: false
date: 2025-10-02
tags:
- programming
- management
- ai
- tooling
canonical_url: https://dev.to/jetthoughts/ai-forces-what-rails-teams-already-knew-small-teams-ship-faster-3k3g
cover_image: https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/content/blog/ai-forces-what-rails-teams-already/cover.png
metatags:
  image: cover.png
slug: ai-forces-what-rails-teams-already
---
I found [this discussion](https://www.youtube.com/watch?v=c_w0LaFahxk) last week and it crystallized something that's been percolating in the industry for months. Not because it was novel—we've been running small, empowered teams at [JetThoughts](https://jetthoughts.com) for 17 years - but because AI is finally forcing the broader tech industry to confront what we figured out early: bureaucratic overhead kills velocity more than any technical constraint.

The shift isn't really about AI writing code. It's about AI making the cost of organizational complexity impossible to ignore.

**Work Smarter Finally Beats Work Harder**

There's a pattern in tech where we throw people at problems. Team struggling? Hire more engineers. Communication breaking down? Add a layer of management. Code quality slipping? Create a QA department.

Each addition feels reasonable in isolation. But the aggregate cost compounds exponentially.

We've maintained a hard rule at JetThoughts: [teams of 5-9 people](https://jetthoughts.com/blog/building-an-effective-dev-team-strategies/). Not because we couldn't grow larger—we've been around long enough to scale if we wanted to. But because we observed something counterintuitive early on: a team of 6 experienced developers consistently outshipped teams of 15-20.

The math isn't about individual productivity. It's about coordination tax.

```ruby
class Team
  def communication_overhead
    # Metcalfe's law applies to organizational complexity
    (members.count * (members.count - 1)) / 2
  end
  
  def effective_velocity
    total_capacity - communication_overhead - alignment_cost
  end
end

# 6 developers: 15 communication paths
# 20 developers: 190 communication paths
```

When AI amplifies individual developer output by 25-50%, that communication overhead becomes the dominant bottleneck. You can't coordinate 190 paths of communication 50% faster. But you can eliminate most of them by keeping teams small.

As we wrote in our analysis of [effective dev teams](https://jetthoughts.com/blog/building-an-effective-dev-team-strategies/): "A small team can be nimble and quick, but might lack the bandwidth for large projects. A large team has more resources, but can be slow and bureaucratic." What we've found is that the second constraint—bureaucracy—dominates at almost any meaningful project scale.

**The Silo Problem AI Exposes**

Here's what the YouTube discussion gets right: AI doesn't just make developers faster—it makes organizational inefficiency visible in cycle time metrics.

Traditional org structure creates information silos as a side effect of scale. Backend team doesn't know what frontend needs. Product doesn't understand technical constraints. Engineering Manager becomes a translation layer between teams and leadership.

Each silo requires synchronization points. Each synchronization point requires meetings, alignment discussions, status updates. The work-to-coordination ratio inverts.

We eliminated most of this through radical transparency. Not as an aspirational value, but as hard process—what we call [our communication architecture](https://jetthoughts.com/blog/cons-of-private-chats-for-team-collaboration-communication-process/):

```ruby
# At JetThoughts, this pattern is enforced
class Communication
  validates :channel, inclusion: { in: ['public'] }
  
  def share
    # Private discussions are actively discouraged
    # If they happen, summary must be posted publicly
    post_to_public_channel if private_discussion_occurred?
  end
end
```

Our rule: [all team communication happens in public project channels](https://jetthoughts.com/blog/cons-of-private-chats-for-team-collaboration-communication-process/). No DMs about project decisions. No hallway conversations that change direction. If it's important enough to discuss, it's important enough to document publicly.

This isn't about surveillance. It's about removing the need for synchronization meetings. When context is public by default, developers can pull information as needed rather than waiting for it to be pushed through status updates.

AI makes this pattern more critical because it speeds up execution but can't speed up alignment. The gap between "how fast we could ship if we knew what to build" and "how fast we actually ship" is almost entirely organizational overhead.

**Reducing Tolerance for Inexperience Through Process**

The video discussion touches on something we've observed: effective practices aren't complicated, but they're often skipped because "experienced developers know what they're doing."

That's backwards. Experienced developers follow process because they've seen what happens when you don't.

Our [delivery flow](https://jetthoughts.com/blog/delivery-flow-for-distributed-remote-teams-agile-kanban/) isn't flexible or creative. It's deliberately constrained:

```ruby
class DeveloperWorkflow
  MAX_WIP_PER_DEVELOPER = 1  # In Progress
  MAX_TOTAL_ITEMS = 2        # Including Done
  MAX_DAYS_PER_ISSUE = 2
  
  def can_start_new_work?
    current_wip < MAX_WIP_PER_DEVELOPER &&
    total_items < MAX_TOTAL_ITEMS &&
    !blocked_items.any?
  end
end
```

These constraints serve multiple purposes:

**For junior developers:** Clear boundaries prevent scope creep and context switching. You can't take on too much because the system prevents it.

**For senior developers:** Forces decomposition of large work into shippable increments. The 2-day limit means if something doesn't fit, you break it down or rethink the approach.

**For the team:** Eliminates prioritization debates. Work on cards from right to left, top to bottom. If priority needs to change, someone moves the card. No meeting required.

When AI amplifies individual output, these constraints become more valuable. A developer using AI effectively might write 2-3x more code per day. Without WIP limits and time constraints, that accelerates feature creep and technical debt accumulation rather than shipping velocity.

**Empowerment as Process, Not Permission**

The other pattern the YouTube video highlights: empowerment isn't about giving developers autonomy after they prove themselves. It's about structuring work so autonomy is the default state.

Our [typical sprint structure](https://jetthoughts.com/blog/typical-day-at-jetthoughts-agile-remote/):

```ruby
class Sprint
  def initialize(week)
    @monday = kickoff_day    # Set goals, schedule issues
    @thursday = retro_day    # Review, measure, improve
    @friday = contribution   # Internal projects, OSS, learning
  end
  
  def developer_autonomy
    # No daily standups
    # No manager approval for technical decisions
    # No separate QA handoff (TDD from start)
    
    {
      planning: :collaborative,
      execution: :independent,
      review: :transparent,
      learning: :protected_time
    }
  end
end
```

Mondays we align on what matters. Then developers own their cards—completely. No check-ins. No status updates beyond what's visible in GitHub and project boards.

This only works because we've eliminated the reasons traditional teams need oversight:

**Transparent work:** Every commit visible. Every decision documented in PRs. Every question asked in public channels where others learn from the answer.

**Clear constraints:** [WIP limits](https://jetthoughts.com/blog/delivery-flow-for-distributed-remote-teams-agile-kanban/) prevent overcommitment. Time limits force scope management. Priority order removes decision paralysis.

**Built-in quality:** TDD isn't optional. Tests fail, code doesn't ship. No separate QA creates a handoff that requires coordination.

AI makes this pattern more effective because it removes the excuse that "junior developers need more guidance." With AI pair programming, junior developers have always-on mentorship. They can ask questions without interrupting seniors. They can explore solutions without getting stuck.

The coordination overhead that justified management layers—answering questions, unblocking work, reviewing decisions—largely disappears.

**What We're Seeing With AI Integration**

We've been integrating AI tools into our workflow over the past year. The pattern that emerged isn't what we expected.

We thought: AI will speed up code writing.

What actually happened: AI exposed where our process had unnecessary friction.

Example: Code review delays. Pre-AI, a PR might sit for hours or a day waiting for review. Not a huge deal when developers were context-switching less frequently.

With AI-assisted development, developers finish work faster. A task that took 2 days now takes 1. But if review still takes 6-12 hours, the cycle time improvement disappears.

So we adjusted:

```ruby
class PullRequest
  REVIEW_SLA = 2.hours  # Not 24 hours
  
  def merge_strategy
    # Small, frequent PRs > large, infrequent
    # AI helps decompose work into reviewable chunks
    prefer_incremental_over_comprehensive
  end
  
  def review_priority
    # Fresh context > perfect timing
    # Review immediately while code is fresh
    optimize_for_flow_over_batching
  end
end
```

Small PRs become natural with AI because you can ask it "how would you break this feature into 3 shippable increments?" and get reasonable decomposition suggestions.

Faster reviews become necessary because AI-accelerated development surfaces review as the bottleneck.

**The Broader Pattern AI Reveals**

What excites me about the conversation in that YouTube video isn't the specific predictions about AI replacing mid-level engineers or eliminating certain roles.

It's that AI is forcing a reckoning with organizational patterns that were always inefficient but seemed necessary because "that's how software teams work."

Small teams weren't viable before because individual developers couldn't cover enough ground. Now they can.

Flat hierarchies created gaps in mentorship and unblocking. Now AI provides those functions.

Eliminating managers meant losing coordination and communication facilitation. Now transparent, async communication provides that context.

The core insight: **most organizational complexity exists to compensate for communication and coordination problems that software can solve better than hierarchy.**

We didn't figure this out because we're smarter. We figured it out because we started small and optimized for shipping, not for organizational structure. As we describe in [how we organize startup teams](https://jetthoughts.com/blog/how-organize-startup-team-structure/), flat hierarchies with fewer management levels mean "less bureaucracy and quicker decision-making."

When you have 6 developers and a client deadline, you don't have the luxury of management layers and synchronization meetings. You build processes that eliminate the need for them.

Turns out those processes scale better than traditional structure. They just weren't necessary at scale before because individual developer productivity was the constraint.

AI removes that constraint. Now organizational overhead is the dominant factor.

**What This Means Practically**

If your team is considering how to integrate AI into development workflow, the technical integration is the easy part. The hard part is organizational:

**Can your team ship small increments?** AI makes large features faster to write but not faster to review or deploy. If your deployment process takes days, AI just means code sits in branches longer.

**Is context public by default?** AI can answer technical questions but not "why are we building this?" or "what did we decide last week?" If that context lives in meeting notes and DMs, AI-accelerated development just means more misalignment.

**Do developers have autonomy?** AI amplifies execution speed but not decision-making speed. If every choice requires approval, you've just moved the bottleneck from coding to coordination. Our approach of [giving developers autonomy](https://jetthoughts.com/blog/building-an-effective-dev-team-strategies/) means "let them make decisions. Don't micromanage."

**Is quality built-in or bolted-on?** AI writes code fast. It also writes bugs fast. If your QA process is separate from development, AI-generated code creates a backlog in testing rather than faster shipping.

The teams that benefit most from AI aren't those with the best engineers. They're teams with the least organizational friction.

We've been running that experiment for 13 years. The results are consistent: small teams with clear constraints, transparent communication, and built-in quality ship faster than large teams with flexibility, hierarchical communication, and separate quality processes.

AI just makes the gap bigger.

**Watching the Industry Catch Up**

Finding that YouTube video felt validating in a way I didn't expect. Not because we need validation—our [client retention rate and delivery metrics](https://jetthoughts.com/) speak for themselves.

But because it suggests the industry is finally ready to question patterns that seemed inevitable. Maybe management layers aren't necessary. Maybe large teams aren't more productive. Maybe coordination overhead isn't just a cost of doing business.

The Rails and XP communities figured this out through constraint—small teams, tight feedback loops, sustainable pace. The broader industry is discovering it through AI exposing inefficiency.

Either way, we're moving in the same direction: work smarter by eliminating the organizational patterns that force us to work harder.

That's the shift worth celebrating.

---

**Related Posts:**
- [Building an Effective Dev Team: Strategies for Success](https://jetthoughts.com/blog/building-an-effective-dev-team-strategies/)
- [Delivery Flow for Distributed Remote Teams](https://jetthoughts.com/blog/delivery-flow-for-distributed-remote-teams-agile-kanban/)
- [How to Get Remote Teams to High Perform](https://jetthoughts.com/blog/how-get-remote-teams-high-perform-agile-development/)
- [Cons of Private Chats for Team Collaboration](https://jetthoughts.com/blog/cons-of-private-chats-for-team-collaboration-communication-process/)
- [A Typical Day at JetThoughts](https://jetthoughts.com/blog/typical-day-at-jetthoughts-agile-remote/)
- [The discussion that sparked this post](https://www.youtube.com/watch?v=c_w0LaFahxk)