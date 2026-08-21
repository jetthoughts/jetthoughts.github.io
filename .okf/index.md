---
okf_version: "0.2"
---

# JetThoughts Blog & Course — Knowledge Bundle

Curated operational knowledge for the Hugo static site at
`jetthoughts.github.io`, with emphasis on the 2026 course project
(`content/course/tech-for-non-technical-founders-2026/`).

**OKF v0.2 (adopted 2026-08-01).** Concepts MAY carry provenance/trust/lifecycle
frontmatter: `generated: { by: <actor>, at: <iso> }`, `verified: [{ by, at }]`,
`status: draft|stable|deprecated`, `stale_after: <YYYY-MM-DD>`. Actors use
`<producer>/<version>` (agents, e.g. `claude/fable-5`), `human:<id>`, or
`process:<id>` — the `human:` prefix is what raises a concept to the
human-reviewed trust tier. These are OPTIONAL and added honestly by whoever
touches a concept; absence never invalidates it (§11). Legacy concepts still
carrying only `timestamp` remain conformant and migrate as they're edited — do
NOT back-stamp `generated`/`verified` you didn't actually perform. When two
sessions verify the same concept concurrently and a rebase conflicts on the
`verified:` array, keep BOTH entries and take the later `timestamp` - each
verification really happened, and dropping one falsifies the provenance the
field exists to carry (2026-08-20, `build/test-gates.md`).

**Stamp actual UTC - take it from `date -u`, never compose it** (2026-08-20).
Eighteen stamps across nine concepts were written as local time carrying a `Z`
suffix, putting them ~2h in the future. That is not cosmetic HERE of all
places: the conflict rule above resolves by taking the LATER timestamp, so a
future-dated stamp silently outranks a genuinely newer edit from a concurrent
session. The session clock displays local time; `Z` means UTC. Run `date -u`
and paste the result.

**Repair by CONVERTING each stamp, not by flattening them to one value.** The
first repair attempt normalised every affected stamp to the sweep time, which
fixed the future-dating and destroyed the thing `verified:` exists for: three
distinct checks became three identical entries, losing their order. Convert with
the offset the stamp was WRITTEN at (recoverable from the session or the
commit), or mark it unknown - never overwrite history with now.

**`okf_validate` checks the trust fields, but a MISSING `at` slips through**
(2026-08-21, measured). The v0.2 checker's `check_trust` does real work - it
requires `generated` to be a mapping, requires `generated.by`, validates actor
shapes, and rejects non-RFC-3339 instants - and `--strict` turns every one of
those warnings into a failure. The one hole found by probe: `check_instant`
returns early when the value is `None`, so an event like
`verified: [{ by: claude/opus-5 }]` with no `at` is reported **conformant** by
both validators on this machine.

Two things follow. A green run is real evidence about trust-field SHAPE - do not
dismiss it. But it cannot tell you an event has a time, and it can never tell you
a recorded time is TRUE; six review rounds on PR #538 turned on exactly that, and
no tool caught any of it. Conformance itself is narrow: v0.2 **§11** (parseable
frontmatter, non-empty `type`), not the trust family.

**There are TWO OKF specs on this machine and their section numbers disagree.**
The `/okf:okf` skill ships and points at
`.claude/plugins/cache/.../skills/okf/reference/SPEC.md`, which is **v0.1** (340
lines) and calls itself "the source of truth"; it never defines `generated` or
`verified` at all, and its §5.2 is "Relative links". The v0.2 spec at
`~/.agents/skills/okf/reference/SPEC.md` (792 lines) makes provenance, trust,
lifecycle and attestation first-class, and ITS §5.2 is "Trust: `generated` and
`verified`". **This bundle is `okf_version: "0.2"`, so the v0.2 copy governs.**

That mismatch cost two wrong rejections of a correct review finding: §5.2 was
looked up in the v0.1 copy, found to say something else, and the finding declared
miscited - twice. The validators differ in coverage too (261 vs 565 lines; only
the v0.2 one checks the trust family and the §13.1 `sources` convention), so a
warning count is only meaningful next to the validator that produced it - and is
not worth writing down at all, since every edit to this bundle changes it.

# Sections

* [Build & Test](build/) - build pipeline, validators, and the blocking test gates
* [Content](content/) - course structure, canonical numbers, and voice rules
* [Design](design/) - mermaid theme, house visual spec, covers, typography
* [Workflows](workflows/) - render-verification recipes, review-swarm patterns, the blog/LinkedIn/CSS pipelines, the visual scroll gate, and the 2607 outbound-sprint machinery
* [Architecture](architecture/) - Hugo site, CSS build pipeline, blog templates, cover images, SEO meta tags
* [Content Strategy](content-strategy/) - ICP profile, voice guide, and the pipeline-first content plan (20.09) governing all founder-facing content

# What belongs in this bundle

Rule, learned the hard way on 2026-07-26 (one concept was relocated twice):

* **`.okf/` holds durable operational knowledge distilled FROM research** - not
  the research itself, and not a copy of a doc that lives elsewhere. A concept
  that is a verbatim copy of a repo doc should be a pointer (see
  [architecture/](architecture/)).
* **Raw external research** belongs in `docs/projects/<project>/10-19-research/`
  (investigation and analysis).
* **Adopted, enforced specs** belong in `docs/projects/<project>/30-39-architecture-design/` -
  a doc that prescribes what creators MUST do goes here even when its origin
  was external research.
* **`log.md` records what changed, not what is true.** If a log entry's detail
  still matters six weeks later, lift it into a concept; the log gets squashed.
