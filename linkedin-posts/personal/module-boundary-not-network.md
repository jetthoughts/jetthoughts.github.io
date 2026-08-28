---
title: "You probably don't need a microservice. You need a folder with rules."
lane: personal
pillar: teach
author: paul-keen
voice: peer
icp_test: Does the "a module boundary, not a network boundary" take land with senior engineers, tech leads, and CTOs, and do they share the service split they are tempted to make this quarter?
image: ""
first_comment: |
  (value post - no link; reply-CTA only)
utm_campaign: ""
utm_content: module_boundary_not_network
status: draft
stage: future
proposed_for: "2026-09-01 17:00 CEST"
notes: |
  Pillar: teach (the 70% value; NO course link). Audience for this task: technical
  senior specialists, tech leaders, CTOs. Reuses the finalized Maya-segment draft
  (t_019ef725) but swaps the [HYPOTHETICAL] use case for a VERIFIED story-bank case
  (vibe-coded MVP -> rewrite, not refactor: AI regenerates code, same logic ends up
  in 5-6 places, one bug hides in several) so the sourcing gate is cleared before
  scheduling. Peer register, no em dashes, close is a real question, no CTA/link/JT.
  Image: left empty on purpose - text-only is a valid Holub-register choice for a
  blunt take, and the repo's native-upload attach step is Paul's manual gap per the
  README known-tooling-gap note. Paul can attach the boundary exhibit PNG at compose
  time if he wants one. Queued (stage: future) for pre-verify; scheduled_for stays
  Paul-gated per doctrine.
---

Most teams that say they need microservices actually need a module boundary, not a network boundary. The network part is the expensive part, and it is the part most teams are not ready for.

A service is a deployment and a failure domain, not a folder. The conference talks show the clean diagram. They skip the distributed write you will hand-roll at 2am when two services need one consistent update.

Here is the test I run before any extraction. Write one sentence: "Today, without this split, we are blocked because ____." If the blank is team coordination or deploy frequency, a boundary helps. If the blank is "the code is messy," extraction makes it messier, just farther apart. Run that sentence on your next refactor proposal.

A team I worked with let an AI tool regenerate a feature. The same validation logic ended up in five or six places. One bug hid in several of them, and nobody could see it from any single file. We drew a hard module boundary first: one owner, one interface, one place the logic lived. The duplication collapsed. Eighteen months on, they still had not needed the network split.

What is working:

- Soft boundaries. Owned modules, clear interfaces, one repo. This bought most of the benefit for most teams I have seen.
- Strangler-style extraction done against a measured pain, like one service that genuinely needs independent scale.

What is not:

- Jumping to a message queue and separate deployables because a talk said coupling is the enemy, when the real bottleneck was a review backlog. The queue added a failure mode and fixed nothing.
- Treating "too big" as a reason to distribute. Size is not coupling.

One claim I would not stake my name on yet: my read, not a measurement, is that teams under-estimate the operational tax of a distributed system by roughly an order of magnitude. Test it on your own setup before you quote it.

What is the one service split you are tempted to make this quarter, and what sentence would prove you actually need it?
