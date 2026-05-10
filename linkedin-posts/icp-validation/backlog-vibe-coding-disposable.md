---
week: 1-extra
day: backlog
author: paul-keen
voice: personal-first-person
pillar: validation-vs-production
hypothesis: H3, H4
icp_test: Do founders who vibe-coded an MVP recognize the disposable-vs-production line and share their rebuild stories? Do builders/CTOs add their own war stories?
cta: Open question - "If you've been through one of these rebuilds, what's the part you thought you'd keep that you ended up throwing out anyway?"
utm_campaign: icp_validation_validation_vs_production
utm_content: vibe_coding_disposable_by_design
status: draft
notes: |
  Off-pillar post activated from backlog. Not in the planned Week 1
  (Progress Visibility) or Week 2 (Ownership & Access) slots.

  REFRAMED 2026-05-09 (second pass): user flagged that leading with
  security incidents was the wrong frame. The position is that vibe
  coding produces unmaintainable code - generate-and-kill, not
  generate-and-defend. Security failures are downstream symptoms.
  Opener now leads with the maintenance mechanic (every fix breaks
  something else; AI regenerates instead of refactors; fourteen
  implementations of the same auth check) and skips the leak headlines.

  Hook archetype: observation-led (not stat-led, not dialogue-led).
  Mon=dialogue, Tue=history, Wed=question, so this is a fresh shape.

  Story-shape: encounter (founders messaging Paul about vibe-coded
  MVPs they can't change) -> mechanism (fourteen auth implementations,
  AI regenerates) -> Karpathy framing -> Paul's personal rule (validate,
  kill, rebuild fresh) -> peer question close.

  Position: vibe coding is hypothesis-validation tooling; the code is
  disposable BY DESIGN because it can't be maintained; the founder
  mistake is treating disposable code as production code. The
  generate-and-kill frame is now the post's spine.

  Voice: ~85% Walling + 15% Fishkin. Confession ("I vibe-code on
  weekends too") softens the line and earns the right to draw it. No
  credential stamps, no em dashes, no rule of three, no anaphora pairs.
---

Three founders messaged me about the same thing this month. Vibe-coded MVP in front of paying customers, and a bug that keeps coming back no matter how many times the team patches it. They patch Monday, customer hits it Wednesday, they patch again Thursday, support ticket lands Friday. Three weeks in, the same file is open for the fourth time.

AI doesn't refactor when you ask for a fix. It writes fresh code. So after a few months of patches, the same broken logic lives in six different places in your codebase. The next "fix" patches one of them. The other five still produce the bug. From your seat, "we fixed it" keeps turning into "wait, it's back" three days later.

I vibe-code on weekends. Once the hypothesis lands, I throw the code out and rebuild from scratch. Not because I'm pure about it. Because otherwise you keep paying for the same fix every couple of weeks for the rest of the product's life.

If you've been through one of these rebuilds, what's the part you assumed you'd keep that you ended up tossing anyway?
