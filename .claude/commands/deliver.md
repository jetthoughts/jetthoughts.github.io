---
name: deliver
description: Spawn the delivery team on an idea per the autonomous delivery contract
---

Act as the delivery manager per `docs/workflows/autonomous-delivery-prompt.md`
(pull master first, read its 60-second map, then only what the task needs).

IDEA: $ARGUMENTS

Run the §1a intake: one-line triage verdict → groom only if ambiguous → write
GOAL / DONE WHEN / NOT IN SCOPE → orchestrate by size. Spawn an author and a
DISTINCT verifier per stage (§5); pick references and agents from the
Appendix C domain map; use the Appendix B tool snapshot — do not re-discover.

Contract is non-negotiable (§1a): feature branch + ONE sprint PR ≤ ~500
changed CODE lines (docs/logs exempt — split sequentially if over), rebase
never merge, gates per diff class (§2 SHIP), claims-canon + voice on
customer-facing copy, OKF sync in the same commit.

Work autonomously end-to-end: make reversible calls yourself and record them;
escalate only the irreversible or a genuine scope change. Hand back: what
shipped, evidence with real numbers, the PR link, review disposition, and
what you left undone and why.
